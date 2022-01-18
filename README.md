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
docker run --rm --name promex -p 8080:8080 promex
```

see: http://localhost:8080

## How it works

Checks are located per default in `/checks` and are grouped into group folders, so you can have a repertoire of all your groups and only run a specific list of groups with certain containers, specified via docker variable `GROUPS=`

The example checks `bar` and `baz` are placed in the group `foo`.
A check contains of two files:

- meta: there you define the `TYPE` and `HELP` line for the prometheus exporter metrics page
- run: the actual script to be run. Should return not more than exactly that value you want to publish

The /metrics route will trigger all checks via task-spooler (for parallel runs) and flock (for avoiding overlaps) and `cat` all output files in `$OUT` 
  *Note:* First time it will most certainly not output anything. Prometheus will scrape every X seconds anyway.

Currently there are 3 ways to trigger and scrape metrics.

- `promex run all` -> Runs all checks in all defined `$GROUPS`  -> asynchronous
- `promex run foo all` -> Runs all checks in group `foo`  -> synchronous
- `promex run foo bar` -> Runs check `bar` in group `foo` -> synchronous

The peculiarity on the specific ones is that it will return the output directly after the command is finished, hence synchronous.


### Credits

- https://github.com/msoap/shell2http
- http://vicerveza.homeunix.net/~viric/soft/ts/
