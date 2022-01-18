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
docker run -it --rm --name promex -p 8080:8080 promex
```



## Help

Checks are located per default in `/checks` and are grouped into group folders, so you can have a repertoire of all groups and only run a specific list of groups with certain containers, specified via docker variable `GROUPS=`

The example checks `bar` and `baz` are placed in the group `foo`.
A check contains of two files:

- meta: there you define the `TYPE` and `HELP` line for the prometheus exporter metrics page
- run: the actual script to be run. Should return not more than exactly that value you want to publish

