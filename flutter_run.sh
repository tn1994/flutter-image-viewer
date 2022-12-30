#bin/sh
set -eu

# do in docker container

cd ./src
rm pubspec.lock
flutter pub get
flutter run -d web-server --web-port 55555 --web-hostname 0.0.0.0
