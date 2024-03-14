#!/bin/bash

# Running as a shell script so we can use the ENV variable BACKEND_PASSWORD
#
# * Creates a user named `backend` with password indicated by BACKEND_PASSWORD
# * Provides read only access to the `backend` user to the `ccc` database

set -e

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
  -- Create a user
  CREATE USER backend WITH PASSWORD '${BACKEND_PASSWORD}';

  -- Grant read-only access to the database
  GRANT CONNECT ON DATABASE ccc TO backend;
  GRANT USAGE ON SCHEMA public TO backend;
  GRANT SELECT ON ALL TABLES IN SCHEMA public TO backend;
  ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT SELECT ON TABLES TO backend;
EOSQL
