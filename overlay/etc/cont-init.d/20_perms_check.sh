#!/usr/bin/with-contenv bash
if [ -d "/data/cache/cache" ]; then
	echo "Running fast permissions check"
	ls -l /data/cache/cache | tail --lines=+2 | grep -v abc > /dev/null

	if [[ $? -eq 0 || "$FORCE_PERMS_CHECK" == "true" ]]; then
		echo "Doing full checking of permissions (This WILL take a long time on large caches)..."
		find /data \! -user abc -exec chown abc:abc '{}' +
		echo "Permissions ok"
	else
		echo "Fast permissions check successful, if you have any permissions error try running with -e FORCE_PERMS_CHECK = true"
	fi

fi
