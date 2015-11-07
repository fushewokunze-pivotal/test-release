#!/bin/bash

JOB_NAME=service
RUN_DIR=/var/vcap/sys/run/$JOB_NAME
LOG_DIR=/var/vcap/sys/log/$JOB_NAME
JOB_DIR=/var/vcap/jobs/$JOB_NAME
EPHEMERAL=/var/vcap/data/$JOB_NAME
PERSISTENT=/var/vcap/store/$JOB_NAME
PIDFILE=$RUN_DIR/pid
RUNAS=vcap

mkdir -p $RUN_DIR $LOG_DIR $EPHEMERAL
chown -R $RUNAS:$RUNAS $RUN_DIR $LOG_DIR $EPHEMERAL $PERSISTENT

exec 1>> $LOG_DIR/$JOB_NAME.stdout.log
exec 2>> $LOG_DIR/$JOB_NAME.stderr.log

case $1 in

  start)
    echo "Starting service"

    <% if p("service.start_successfully") %>
    echo 1 >> $PIDFILE
    <% end %>

    ;;

  stop)
    echo "Stopping service"

    <% if p("service.stop_successfully") %>
    rm -f $PIDFILE
    <% end %>

    ;;

  *)

  echo "Usage: ctl {start|stop}" ;;
esac
