```sh
#! /bin/sh

### BEGIN INIT INFO
# Provides:          bot.py
# Required-Start:    $remote_fs $syslog
# Required-Stop:     $remote_fs $syslog
# Default-Start:     2 3 4 5
# Default-Stop:      0 1 6
### END INIT INFO

# Carry out specific functions when asked to by the system
case "$1" in
  start)
    echo "Starting bot.py"
        sleep 30
        cd /home/pi/KnightBot
        screen -S knight -d -m bash -c 'python bot.py'
    ;;
  stop)
    echo "Stopping bot.py"
    cd /home/pi/KnightBot
    sudo pkill -f bot.py
    ;;
  *)
    echo "Usage: /etc/init.d/autoKnightbot.sh {start|stop}"
    exit 1
    ;;
esac

exit 0
```