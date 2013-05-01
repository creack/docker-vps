#!/bin/sh
#!/bin/bash

#
# Wrapper based on MiteshShah script
# https://github.com/rtCamp/easyengine/issues/3
#

# Start nginx
/usr/sbin/nginx

# Start supervising the config
while true
do
    inotifywait --exclude .swp -e create  /etc/nginx/sites-enabled
    nginx -t
    if [ $? -eq 0 ]
    then
        echo "Reloading Nginx Configuration"
        /usr/sbin/nginx -s reload
    else
	echo "Error config"
    fi
done
