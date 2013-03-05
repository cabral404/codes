#!/bin/bash

LOCK='/var/run/commit.lock'

if [ -e $LOCK ]
then
  exit 1
else
  touch $LOCK
  CLIENT=$(cat /var/temp/client.txt)
  SERVER=$(cat /var/www/server.txt)
  if [ "$SERVER" != "$CLIENT" ]
  then
    echo $(su - fernando -c 'cd /home/fernando/files && git pull')
    COMMIT=$(su - fernando -c cd /home/fernando/files && git show | grep commit | awk '{print $2}')
    echo $COMMIT > /var/www/server.txt
  fi
  find /home/fernando/files/* -type d | grep -v '.git' | xargs -I{} chown fernando.www-data -R {}
  find /home/fernando/files/* -type f | grep -v '.git' | xargs -I{} chown fernando.www-data {} 
  find /home/fernando/files/* -type d | grep -v '.git' | xargs -I{} chmod 775 {}
  find /home/fernando/files/* -type f | grep -v '.git' | xargs -I{} chmod 664 {}
  echo $(su - fernando -c "cd /home/fernando/files && git add . && git commit -a -m 'Auto commit server' && git push")
  COMMIT=$(su - fernando -c 'cd /home/fernando/files && git show' | grep commit | head -1 | awk '{print $2}')
  echo $COMMIT > /var/www/server.txt
  rm -rf $LOCK
fi
