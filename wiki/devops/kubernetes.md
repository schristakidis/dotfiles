## Intro

- to get all namespaces add to the flag `--all-namespaces`

### Various command
- Get core component statuses
```
kubectl get componentsstatuses
```
- Logs
```sh
kubectl log <pod name>
kubectl log <pod name> -f  # tail the logs
kubectl log <pod name> --previous # get the logs from the previous instance
```
- Exec
```sh
kubectl exec -it <pod-name> -- bash
```
- Attach 
```sh
kubectl attach -it <pod-name>
```
- Copy
```sh
kubectl cp <pod-name>:</path/to/remote/file> </path/to/local/file>
```
- Port Forwarding
```sh
kubectl port-forward <pod-name> 8080:80
```

- Run busybox debug pod
```sh
kubectl run -it --rm --image busybox busybox -- sh
```

### Selectors

| Operators                   | Description                        |
| -                           | -                                  |
| key=value                   | key is set to value                |
| key!=value                  | key is not set to value            |
| key in (value1, value2)     | key in one of value1 or value2     |
| key not in (value1, value2) | key is not one of value1 or value2 |
| key                         | key is set                         |
| !key                        | key is not set                     |
