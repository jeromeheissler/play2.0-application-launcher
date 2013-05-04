
# play2.0-application-launcher
This is a script to launch as a deamon on debian or ubuntu a play2.0 application. The application must be compile with stage command.

It can be used like this : 

	play clean stage

	echo "killing running app..."
	sudo /etc/init.d/play2.0-application-launcher stop /var/www/site1

	echo "starting new app..."
	sudo /etc/init.d/play2.0-application-launcher start /var/www/site1 "-Dhttp.port=9090 -Dconfig.resource=production.conf"

	echo "app started"
	