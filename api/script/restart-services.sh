#!/bin/bash -e
cd /src;
source /home/app/perl5/perlbrew/etc/bashrc;

if [ -f envfile_local.sh ]; then
    source envfile_local.sh
else
    source envfile.sh
fi

export PENHAS_API_LOG_DIR=/data/log/
export SQITCH_DEPLOY=${SQITCH_DEPLOY:=docker}

cpanm -nv . --installdeps

sqitch config --replace-all target.docker.uri db:pg://$POSTGRESQL_USER:$POSTGRESQL_PASSWORD@$POSTGRESQL_HOST:$POSTGRESQL_PORT/$POSTGRESQL_DBNAME
sqitch deploy -t $SQITCH_DEPLOY

export RESTART_TYPE='all'
if [ ! "$1" = "" ]; then
    export RESTART_TYPE=$1
fi
[ "$RESTART_TYPE" == "all" ] && RESTART_TYPE="api";

echo "restarting services [$RESTART_TYPE]...";

[[ $RESTART_TYPE == *"api"*       ]] && echo "hypnotoad..." && LIBEV_FLAGS=4 APP_NAME=API LIBEV_FLAGS=4 MOJO_IOLOOP_DEBUG=1 hypnotoad script/quiz-api
