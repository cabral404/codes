#!/bin/bash

while true
do
	find /home/fernando/files -type d -print0 | xargs -0 -I{} echo "{} IN_MODIFY,IN_CREATE,IN_DELETE,IN_DELETE_SELF,IN_MOVE_SELF /opt/matrix/bin/commit.sh" | grep -v ".git" > /etc/incron.d/update-files.conf
	sed -i '1 s/IN_DELETE,//' /etc/incron.d/update-files.conf
	sleep 10
done
