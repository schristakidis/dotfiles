## Create Helm Chart

```sh
helm create test-mailer
```

## S3 Helm Chart repo

- Install helm s3 plugin

```sh
helm plugin install https://github.com/hypnoglow/helm-s3.git
```

- Create s3 bucket
- Set plugin to work for helm version 3 (not mentioned anywhere)
```sh
export HELM_S3_MODE=3
```
- Init helm repo
```sh
helm s3 init s3://mps-charts/test-mailer
```
- Add repo alias
```sh
helm repo add test-mailer s3://mps-charts/test-mailer
```
- Create helm chart
```sh
helm package ./test-mailer
```
- Push chart
```sh
helm s3 push ./test-mailer-0.1.0.tgz test-mailer
```

