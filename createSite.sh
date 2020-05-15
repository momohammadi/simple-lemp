#!/bin/bash
USER=$1
DOMAIN=$2
if [ -z "$DOMAIN" ]
 then
        echo "user or domain can not empty usage e.x: ./createSite.sh username domainname.com "
 else
		TDIR=`pwd`/LEMP/
        HOME=/home/${USER}
        useradd -m -d ${HOME} ${USER} --shell=/bin/false
        usermod -G nginx,${USER} ${USER}

        mkdir -p ${HOME}/.php
        mkdir -p ${HOME}/tmp
        mkdir -p ${HOME}/php7.4
        mkdir -p ${HOME}/domains/${DOMAIN}/public_html/
        mkdir -p ${HOME}/domains/${DOMAIN}/private_html/
        echo "${DOMAIN} init Success" > ${HOME}/domains/${DOMAIN}/public_html/index.html
        chown -R ${USER} ${HOME}/domains

        mkdir -p /etc/nginx/vhosts/${USER}
        cp /etc/nginx/vhosts/example/nginx.conf /etc/nginx/vhosts/${USER}/nginx.conf
        sed -i s/example.com/${DOMAIN}/g /etc/nginx/vhosts/${USER}/nginx.conf
        sed -i s/example/${USER}/g /etc/nginx/vhosts/${USER}/nginx.conf
        cp ${TDIR}/home/example/php7.4/fpm.conf ${HOME}/php7.4/
        cp ${TDIR}/home/example/nginx_php.conf ${HOME}/
        sed -i s/example/${USER}/g ${HOME}/php7.4/fpm.conf
        sed -i s/example/${USER}/g ${HOME}/nginx_php.conf

        service php7.4-fpm restart
        service nginx restart

        echo "NEW SITE SUCCESSFULLY CREATED WITH USER ${USER} AND DOMAIN ${DOMAIN}"
fi
USER=""
DOMAIN=""
