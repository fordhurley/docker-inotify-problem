FROM ubuntu:14.04

RUN apt-get update && apt-get install -y \
    inotify-tools

WORKDIR /app
ADD . /app/

CMD ["./watcher.sh"]
