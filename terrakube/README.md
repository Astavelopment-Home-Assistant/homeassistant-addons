# Terrakube Add-on
This add-on provides a self-hosted Terrakube environment (API and UI) running directly in Home Assistant.

## Configuration
Configure the following options in the Home Assistant Add-on UI:
- **Database URL**: A PostgreSQL database connection string (e.g., `jdbc:postgresql://<host>:5432/terrakube`).
- **Redis URL**: A Redis connection string (e.g., `redis://<host>:6379`).
- **API Base URL**: The public or local URL where the API is accessible.
- **UI Base URL**: The public or local URL where the UI is accessible.
- **Workspace Storage**: Path for storing Terraform state files (e.g., `/ssl/workspace` or cloud storage).

You must configure an external PostgreSQL database and an external Redis instance to use this Add-on.
