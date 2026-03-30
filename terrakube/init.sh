#!/usr/bin/with-contenv bashio
export SPRING_DATASOURCE_URL=$(bashio::config 'database_url')
export SPRING_REDIS_URL=$(bashio::config 'redis_url')
export ORG_TERRAKUBE_API_URL=$(bashio::config 'api_base_url')
export ORG_TERRAKUBE_UI_URL=$(bashio::config 'ui_base_url')
export WORKSPACE_STORAGE=$(bashio::config 'workspace_storage')

# Setup UI env-config.js
bashio::log.info "Configuring Terrakube UI env-config.js..."
cat <<EOF > /var/www/html/env-config.js
window._env_ = {
  REACT_APP_TERRAKUBE_API_URL: "${ORG_TERRAKUBE_API_URL}"
}
EOF

bashio::log.info "Starting Nginx..."
nginx -g "daemon off;" &
NGINX_PID=$!

bashio::log.info "Finding and starting Terrakube API..."
jar_file=$(find /app -name "*.jar" | head -n 1)
if [ -n "$jar_file" ]; then
  bashio::log.info "Running Java jar: $jar_file"
  java -jar "$jar_file" &
  JAVA_PID=$!
else
  bashio::log.error "Terrakube API jar not found!"
  exit 1
fi

wait -n $NGINX_PID $JAVA_PID
