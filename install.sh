#!/bin/bash
IP=$1
if [ -z "$IP"]
 then
	echo "YOU SHOULD INPUT YOUR SHARED SERVER IP ADDRESS e.x: ./install.sh 192.168.1.2"
 else
	sudo apt -y install software-properties-common
	sudo apt -y remove apache2
	sudo apt -y purge apache2
	sudo apt -y install nginx
	sudo apt -key adv --recv-keys --keyserver hkp://keyserver.ubuntu.com:80 0xF1656F24C74CD1D8
	sudo add-apt-repository "deb [arch=amd64,arm64,ppc64el] http://mariadb.mirror.liquidtelecom.com/repo/10.4/ubuntu $(lsb_release -cs) main"
	sudo apt -y update
	sudo apt -y -y install mariadb-server mariadb-client
	sudo apt -y -y install software-properties-common
	sudo add-apt-repository ppa:ondrej/php
	sudo apt -y update
	sudo apt -y install php7.4 php7.4-common php7.4-fpm php7.4-mysql php7.4-imagick imagick
	sudo cp -rf /etc/php/7.4 /etc/php/7.4.org
	sudo yes | cp -rf etc/php/7.4/fpm /etc/php/7.4/
	sudo mv /etc/nginx /etc/nginx.org
	sudo cp -rf etc/nginx /etc/
	sudo sed -i s/1.2.3.4/${IP}/g /etc/nginx/nginx-vhosts.conf
	sudo sed -i s/1.2.3.4/${IP}/g /etc/nginx/vhosts/example/nginx.conf

	sudo mkdir /var/www/html/phpMyAdmin
	sudo wget -O /var/www/html/phpMyAdmin-5.0.2-all-languages.zip https://files.phpmyadmin.net/phpMyAdmin/5.0.2/phpMyAdmin-5.0.2-all-languages.zip
	sudo unzip /var/www/html/phpMyAdmin-5.0.2-all-languages.zip
	sudo unzip /var/www/html/phpMyAdmin-5.0.2-all-languages.zip -d /var/www/html/
	sudo ln -s /var/www/html/phpMyAdmin-5.0.2-all-languages /var/www/html/phpMyAdmin

	sudo service nginx restart
	sudo service php7.4-fpm restart
	
	echo "INSTALL SUCCESSFULLY YOU CAN ADD SITE BY ./createSite.sh USERNAME DOMAINNAME.COM"
fi