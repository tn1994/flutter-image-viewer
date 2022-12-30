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
# Only ONCE
sh flutter_exec.sh
sh flutter_init.sh
```

Development:

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
