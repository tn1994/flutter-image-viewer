#bin/sh
set -eu

cd .docker
docker-compose down
docker-compose up -d
docker-compose exec flutter bash

#docker-compose run --rm flutter -c '
#cd ./src; flutter run -d web-server --web-port 55555 --web-hostname 0.0.0.0
#'
