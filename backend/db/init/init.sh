#!/bin/bash
set -e

echo "📡 Esperando a que PostgreSQL esté disponible..."

# Espera a que PostgreSQL responda
until pg_isready -h db -p 5432 -U "${POSTGRES_USER}"; do
  echo "⏳ Esperando conexión con la base de datos..."
  sleep 2
done

echo "✅ Base de datos disponible. Ejecutando init.sql..."

# Ejecutar script SQL (solo si el archivo existe)
if [ -f /docker-entrypoint-initdb.d/init.sql ]; then
  psql -h db -U "$POSTGRES_USER" -d "$POSTGRES_DB" -f /docker-entrypoint-initdb.d/init.sql
  echo "🎉 Script de inicialización ejecutado con éxito."
else
  echo "⚠️ No se encontró init.sql en /docker-entrypoint-initdb.d/"
fi
