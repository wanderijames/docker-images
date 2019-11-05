#!/usr/bin/env bash
set -ex

airflow initdb
alembic upgrade heads
airflow scheduler &>/dev/stdout &
exec airflow webserver

