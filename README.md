# rockmongo
My docker image for [rockmongo project](https://github.com/iwind/rockmongo).
Run nginx web server and expose 80 port.
It is expected that config directory will be specified and will content config.php for rockmongo.

Examples of running:
```
docker run -d --name=rockmongo -v /var/docker/rockmongo/config:/config -p 27080:80 telminov/rockmongo
```
```
docker run -d --name=rockmongo --link mongo3:mongo.docker -v /var/docker/rockmongo/config:/config -p 27080:80 telminov/rockmongo
```