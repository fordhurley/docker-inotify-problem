This project is a minimal example of a problem with using inotify to watch for
filesytem changes on a volume mounted within a Docker container.

To reproduce the problem, we will need two terminals, both inside this project
directory on your host machine.

In terminal 1:

    make run

In terminal 2, mess with the files in this directory:

    touch test
    echo "testing" > test
    cat test

Any of those commands should have caused `inotifywait` running in the first tab
to detect the changes, print out the change it saw, and exit immediately.

Here's what I see on the output:

    $ make run
    docker build -t docker-inotify-problem .
    Sending build context to Docker daemon 54.78 kB
    Sending build context to Docker daemon
    Step 0 : FROM ubuntu:14.04
     ---> d0955f21bf24
    Step 1 : RUN apt-get update && apt-get install -y     inotify-tools
     ---> Using cache
     ---> 2e84b50e46a0
    Step 2 : WORKDIR /app
     ---> Using cache
     ---> 2a2b93fab998
    Step 3 : ADD . /app/
     ---> 8f49a6c7fc85
    Removing intermediate container 30de7c1ab8bf
    Step 4 : CMD ./watcher.sh
     ---> Running in ff38e8daf284
     ---> b6b6b2986e5d
    Removing intermediate container ff38e8daf284
    Successfully built b6b6b2986e5d
    docker run --rm -v /Users/ford/repos/docker-inotify-problem:/app -ti docker-inotify-problem
    Before:
    total 16
    -rw-r--r-- 1 1000 staff  128 Jun  1 15:24 Dockerfile
    -rw-r--r-- 1 1000 staff  138 Jun  1 15:30 Makefile
    -rw-r--r-- 1 1000 staff 1961 Jun  1 15:35 README.md
    -rwxr-xr-x 1 1000 staff  268 Jun  1 15:35 watcher.sh

    Waiting 20 seconds for a change...
    Setting up watches.
    Watches established.
    Timed out waiting for change.

    After:
    total 20
    -rw-r--r-- 1 1000 staff  128 Jun  1 15:24 Dockerfile
    -rw-r--r-- 1 1000 staff  138 Jun  1 15:30 Makefile
    -rw-r--r-- 1 1000 staff 1961 Jun  1 15:35 README.md
    -rw-r--r-- 1 1000 staff    8 Jun  1 15:37 test
    -rwxr-xr-x 1 1000 staff  268 Jun  1 15:35 watcher.sh

I'm running Docker with `boot2docker` on OS X.
