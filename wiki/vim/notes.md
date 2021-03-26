## Docker/Python

To develop python on docker with coc.vim


```json
"python": {
    "command": "docker-compose",
    "args": [
        "exec",
        "-T",
        "backend",
        "pyls"
    ]
}
```

#### Example Dockerfile

```
FROM python:3.9
ENV PYTHONBUFFERED 1
WORKDIR /packman_proxy
COPY requirements.txt /packman_proxy/requirements.txt
RUN pip install -r requirements.txt
COPY . .
RUN pip install python-language-server[all]
RUN python /packman_proxy/setup.py install

CMD ["uvicorn", "packman_proxy.main:app",  "--host", "0.0.0.0", "--port", "8000", "--reload"]
```

#### Example docker-compose

```yaml
version: '3.8'
services:
  backend:
    build:
      context: .
      dockerfile: Dockerfile
    ports:
      - 8000:8000
```
