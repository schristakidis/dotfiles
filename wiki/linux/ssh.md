## SOCK5 Proxy

### SSH Command
```bash
ssh -D 1080 -q -C -N -f shame
```

To use the proxy in kubectl, add the following to your `~/.kube/config`:

### K8S

```yaml
apiVersion: v1
clusters:
- cluster:
    certificate-authority-data: LRMEMMW2 # shortened for readability 
    server: https://<API_SERVER_IP_ADDRESS>:6443  # the "Kubernetes API" server, in other words the IP address of kubernetes-remote-server.example
    proxy-url: socks5://localhost:1080   # the "SSH SOCKS5 proxy" in the diagram above
  name: default
```

[k8s-docs](https://kubernetes.io/docs/tasks/extend-kubernetes/socks5-proxy-access-api/)

### httpie
```bash
http --proxy=https:socks5h://localhost:1080 https://<API_SERVER_IP_ADDRESS>:6443
```

### curl
```bash
curl -x socks5h://localhost:1080 https://<API_SERVER_IP_ADDRESS>:6443
```

