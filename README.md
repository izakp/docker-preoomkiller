# docker-preoomkiller
Watches container memory use and softly kills the container with SIGTERM before Docker OOMKills it

## Dependencies

Python 2 / 3

`preoomkiller` has no Python package dependencies so should work everywhere

## Install

With `curl`: put `RUN curl -sSf https://raw.githubusercontent.com/izakp/docker-preoomkiller/master/install-preoomkiller.sh | sh` in your Dockerfile to install `preoomkiller` to `/usr/local/bin`

Manually `ADD` `preoomkiller` to your Docker image somewhere on your `$PATH`

## Use

By default, `preoomkiller` will send `SIGTERM` to its parent pid, and is designed to run in the background in a container's entrypoint script.

For example use, see the Dockerfiles and `docker-entrypoint.sh` in the root of this repo. `preoomkiller` is invoked with `exec /usr/local/bin/preoomkiller &` before the main process executes in the foreground, and so the resulting process tree will look like:

```
root         1  0.1  0.0   4036   664 ?        Ss   14:24   0:00 /usr/bin/dumb-init -- /docker-entrypoint.sh
root         8  0.0  0.0  19708  3196 ?        Ss   14:24   0:00 /bin/bash /docker-entrypoint.sh
root         9  0.0  0.0  24512  6400 ?        S    14:24   0:00  \_ python /usr/local/bin/preoomkiller
root        36  0.0  0.0   5932   644 ?        S    14:24   0:00  \_ sleep 1
```

You can also configure `preoomkiller` to send its signal to pid 1 (see below)

`preoomkiller` is observed to use approximately 3.4Mb running on Python 2 and 5.7Mb running on Python 3

## Configuration options

`preoomkiller` won't start unless the environment variable `ENABLE_PREOOMKILLER` is set

`PREOOMKILLER_MEMORY_USE_FACTOR` - (float) at what percentage of used / total memory to kill the container (default `0.95`)

`PREOOMKILLER_POLL_INTERNAL` (integer) - how many seconds to wait beween polling memory use (default `10`)

`PREOOMKILLER_KILL_SIGNAL` (integer) - what signal to send to the process (default `SIGTERM` / `15`)

`PREOOMKILLER_KILL_PID` (integer) - what pid will receive a SIGTERM (default: the pid of the parent that spawned `preoomkiller`) If you don't start `preoomkiller` and your application's main process via an entrypoint script (see the example `docker-entrypoint.sh`) you can also set this to `1`.  Note: make sure you're using an init system like [dumb-init](https://github.com/Yelp/dumb-init) to make sure the pid 1 process properly proxies signals to children

`PREOOMKILLER_DEBUG` - if set, print memory statistics when polling

## Testing

`make test-all`

## Building Docker images

`make build-all`
