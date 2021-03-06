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

Checks are located per default in `/checks` and are grouped into folders, so you can have a repertoire of all your checks and only run a specific `list` of groups in certain containers, specified via docker variable `GROUPS=`

The example checks `bar` and `baz` are placed in the group `foo`. They both just generate a random number.  
A check consists of two files:

- meta: there you define the `TYPE` and `HELP` line for the prometheus exporter metrics page (see https://prometheus.io/docs/concepts/metric_types/)
- run: the actual script to be run. Should return not more than exactly that value you want to publish

The /metrics route will trigger all checks via `ts` task-spooler (for parallel runs) and `flock` (with `-n` for avoiding overlaps and stapling) and afterwards `cat` all output files (directory is `$OUT`)

*Note:* First time it most certainly won't output anything due to the short time between trigger and `cat`. Prometheus will scrape every X seconds anyway.

Currently there are 3 ways to trigger and scrape metrics.

- `promex run [all]` -> Runs all checks in all defined `$GROUPS`  -> asynchronous
- `promex run foo [all]` -> Runs all checks in group `foo`  -> synchronous
- `promex run foo bar` -> Runs check `bar` in group `foo` -> synchronous

The peculiarity on the specific ones is that it will return the output directly after the command is finished; hence synchronous.

##### HTTP examples:

- http://localhost:8080/metrics
- http://localhost:8080/check?g=foo
- http://localhost:8080/check?g=foo&c=bar

#### Credits

- https://github.com/msoap/shell2http
- http://vicerveza.homeunix.net/~viric/soft/ts/
