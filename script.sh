#!/bin/bash
WORKSPACE="$2"
CONFIG="$3"
# Path to play install folder
PLAY_HOME=/usr/local/bin/play
PLAY=$PLAY_HOME/play

PATH=${PATH}:/sbin

# Path to the JVM
JAVA_HOME=/usr/lib/jvm/java-6-openjdk-i386
export JAVA_HOME

PATH=${PATH}:${JAVA_HOME}
export PATH

# User running the Play process
USER=jheissler

RETVAL=0

start() {
	#echo ${CONFIG}
	if [ -s ${WORKSPACE}/RUNNING_PID ]; then
	  echo "playapp is already running"
	else
	  start-stop-daemon --pidfile ${WORKSPACE}/RUNNING_PID --chuid ${USER} --exec ${WORKSPACE}/target/start --background --start -- "${CONFIG}"
	  echo -n "Started playapp"
	  RETVAL=$?
	  if [ $RETVAL -eq 0 ]; then
	    echo " - Success"
	  else
	    echo " - Failure"
	    exit -1
	 fi
	fi
	echo
}

stop() {
	if [ -s RUNNING_PID ]; then
	  kill $(cat ${WORKSPACE}/RUNNING_PID)
	  rm -rf ${WORKSPACE}/RUNNING_PID
	  echo -n "Stopping playpp"
	  RETVAL=$?
	  if [ $RETVAL -eq 0 ]; then
	    echo " - Success"
	  else
	    echo " - Failure"
	  fi
	else
	  echo "playapp not running"
	fi
	echo
}
case "$1" in
        start)
        start
        ;;
        stop)
        stop
        ;;
        restart|reload)
        stop
        sleep 10
        start
        ;;
        *)
        echo "Usage: $0 {start|stop|restart}"
esac
exit 0

