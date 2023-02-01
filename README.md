# flutter-image-viewer

Machine:

- OS: MacOS
- IDE: IntelliJ IDEA
- Docker, docker-compose

---

Setup Local:

```shell
# for MacOS
brew install flutter
```

Install Plugin Flutter to IntelliJ IDEA
Restart IDE

```shell
cd ./src
flutter packages get
flutter pub get
```

Setup Initial:

```shell
cp src/sample.env src/.env
vi src/.env
# setup API-and-Key
```

```shell
# Only ONCE
sh flutter_exec.sh
sh flutter_init.sh
```

Development Using Docker:

```shell
sh flutter_exec.sh

# do in container
sh flutter_run.sh

# after change files, wanna hot reload
r
```

```shell
# another local terminal
flutter packages get
```

Development At Local Machine:

```shell
sh flutter_run.sh

# after change files, wanna hot reload
r
```
