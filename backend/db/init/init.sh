#!/bin/bash
set -e

# Esperar a que PostgreSQL esté disponible
echo "Esperando a que la base de datos esté lista..."
until pg_isready -h db -p 5432 -U "$POSTGRES_USER"; do
  sleep 1
done

echo "Ejecutando script de inicialización..."
psql -h db -U "$POSTGRES_USER" -d "$POSTGRES_DB" -f /docker-entrypoint-initdb.d/init.sql
