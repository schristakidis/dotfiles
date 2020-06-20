### List images from a remote repository

```sh
curl -ik https://docker.mps.lan:5000/v2/_catalog
```

### login

```sh
docker login docker.mps.lan:5000
```

#### untrusted certificate

check if the certificate is in ```/etc/docker/certs.d/docker.mps.lan:5000```
need also ```/etc/ssl/certs/mps-lan.pem```

if it is and problem persists restart docker service

