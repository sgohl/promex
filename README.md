# promex
Prometheus Exporter for Shell Checks

```
git clone https://github.com/sgohl/promex.git
cd promex
```

Build Docker Image
```
docker build -t promex .
```

Run a Test
```
docker run -it --rm -p 8080:8080 promex
```
