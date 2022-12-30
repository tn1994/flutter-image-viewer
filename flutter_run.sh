#bin/sh
set -eu

# do in docker container

cd ./src
rm pubspec.lock
flutter pub get
#flutter run -d web-server --web-port 55555 --web-hostname 0.0.0.0
flutter run -d web-server --web-port 62535 --web-hostname 0.0.0.0 --web-renderer html

#ref: https://zenn.dev/neruneru/articles/b9dcb800bd9f11