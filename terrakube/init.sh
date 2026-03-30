#!/usr/bin/with-contenv bashio

export SPRING_DATASOURCE_URL=$(bashio::config 'database_url')
export SPRING_REDIS_URL=$(bashio::config 'redis_url')
export ORG_TERRAKUBE_API_URL=$(bashio::config 'api_base_url')
export ORG_TERRAKUBE_UI_URL=$(bashio::config 'ui_base_url')
export WORKSPACE_STORAGE=$(bashio::config 'workspace_storage')

# 1. Prepare UI Files
bashio::log.info "Moving Terrakube UI files to Nginx directory..."
mkdir -p /var/www/html
cp -r /opt/ui/usr/share/nginx/html/* /var/www/html/ || true

# 2. Setup UI env-config.js
bashio::log.info "Configuring Terrakube UI env-config.js..."
cat <<EOF > /var/www/html/env-config.js
window._env_ = {
  REACT_APP_TERRAKUBE_API_URL: "${ORG_TERRAKUBE_API_URL}"
}
EOF

# 3. Start Nginx
bashio::log.info "Starting Nginx..."
nginx -g "daemon off;" &
NGINX_PID=$!

# 4. Find the actual application jar, excluding libraries and JRE layers
bashio::log.info "Finding and starting Terrakube API..."

# Search for the jar but ignore the 'lib' and 'layers' folders
jar_file=$(find /opt/api -name "*.jar" \
    -not -path "*/BOOT-INF/lib/*" \
    -not -path "*/layers/*" \
    -print -quit)

if [ -n "$jar_file" ]; then
  bashio::log.info "Found Terrakube API at: $jar_file"
  
  # Change to the directory of the jar
  cd "$(dirname "$jar_file")"
  
  # Start Java
  java -jar "$jar_file" &
  JAVA_PID=$!
else
  bashio::log.error "Terrakube API jar not found! Check /opt/api folder structure."
  exit 1
fi

bashio::log.info "Both services booted successfully. Awaiting jobs..."
wait -n $NGINX_PID $JAVA_PID
