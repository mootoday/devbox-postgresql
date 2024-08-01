#!/bin/bash
DB_NAME=my_database

# DB does not exist
if ! psql -lqt | cut -d \| -f 1 | grep -qw $DB_NAME; then
  echo "[Postgres] Creating database..."
  createdb $DB_NAME
  echo "[Postgres] Done"
fi

# `dev` user does not exist
if ! psql -d $DB_NAME -c "SELECT 1 FROM pg_roles WHERE rolname='dev'" | grep -q 1; then
  echo "[Postgres] Setting permissions..."
  psql -d $DB_NAME -f config/devbox/db-permissions.sql
  echo "[Postgres] Done"
fi
