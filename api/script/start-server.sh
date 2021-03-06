#!/bin/bash -e
source /home/app/perl5/perlbrew/etc/bashrc

mkdir -p /data/log/;

export PENHAS_API_LOG_DIR=/data/log/

cd /src;
if [ -f envfile_local.sh ]; then
    source envfile_local.sh
else
    source envfile.sh
fi

export SQITCH_DEPLOY=${SQITCH_DEPLOY:=docker}

cpanm -nv . --installdeps
sqitch config --replace-all target.docker.uri db:pg://$POSTGRESQL_USER:$POSTGRESQL_PASSWORD@$POSTGRESQL_HOST:$POSTGRESQL_PORT/$POSTGRESQL_DBNAME
sqitch deploy -t $SQITCH_DEPLOY

LIBEV_FLAGS=4 APP_NAME=API MOJO_IOLOOP_DEBUG=1 hypnotoad script/quiz-api

sleep infinity