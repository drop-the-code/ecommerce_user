#!/bin/sh
# wait-for-postgres.sh

set -e


until PGPASSWORD=$DB_PASSWORD psql -h "$DB_HOST" -U "$DB_USER" -c '\q'; do
    >&2 echo "Postgres is unavailable - sleeping"
    sleep 1
done

>&2 echo "Postgres is up - executing command"

mix deps.get
mix ecto.create
mix ecto.migrate

exec mix grpc.server