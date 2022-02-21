#!/usr/bin/env sh

COMPOSE_PROJECT=codex-deploy

export FEASIBILITY_KEYCLOAK_ADMIN_PW=${FEASIBILITY_KEYCLOAK_ADMIN_PW:-admin}
FEASIBILITY_BASE_URL=${FEASIBILITY_BASE_URL:-https://localhost}
export CODEX_FEASIBILITY_BACKEND_FLARE_WEBSERVICE_BASE_URL=http://node-flare:8080
export CODEX_FEASIBILITY_BACKEND_DIRECT_ENABLED=true
export CODEX_FEASIBILITY_BACKEND_API_BASE_URL=$FEASIBILITY_BASE_URL/api/
export FEASIBILITY_KEYCLOAK_BASE_URL=$FEASIBILITY_BASE_URL/auth


BASE_DIR="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"

docker-compose -p $COMPOSE_PROJECT -f $BASE_DIR/keycloak/docker-compose.yml up -d
docker-compose -p $COMPOSE_PROJECT -f $BASE_DIR/backend/docker-compose.yml up -d
docker-compose -p $COMPOSE_PROJECT -f $BASE_DIR/gui/docker-compose.yml up -d
sleep 20
bash init-direct-db.sh
