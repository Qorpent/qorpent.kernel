#!/bin/bash

REP_SERVER_IP="192.168.26.133"
REP_SERVER_DIR="/rep"
UMMC_REP_NAME_LOCAL="ugmkrep"

function SetEnviromentVariables() {
	export UMMC_WEB_SSL_DIR=/etc/nginx/ssl
	export UMMC_CONFIG_DIR=/usr/share/config
	export UMMC_CREDENTIALS_DIR=/usr/share/config/credentials
	export UMMC_REP_DIR=/mnt/rep
}

function CreateBaseDirs() {
	mkdir -p $UMMC_CONFIG_DIR
	mkdir -p $UMMC_WEB_SSL_DIR
	mkdir -p $UMMC_REP_DIR
	mkdir -p $UMMC_CREDENTIALS_DIR
}

function InstallBaseApplications() {
	apt-get install nginx
	apt-get install git
	apt-get install autofs
}

function ConfigureAccessToRepo() {
	echo "/mnt /etc/auto.cifs --ghost" >> /etc/auto.master
	echo "$(UMMC_REP_NAME_LOCAL) -fstype=cifs,rw,noperm,credentials=$(UMMC_CREDENTIALS_DIR)/UGMK_REP ://$(REP_SERVER_IP)$(REP_SERVER_DIR)" >> /etc/auto.cifs
}

function SetCredentials() {
	if [ "$1" ] && [ "$2" ];
	then
		echo "username=$1" >> $(UMMC_CREDENTIALS_DIR)/UGMK_REP
		echo "password=$2" >> $(UMMC_CREDENTIALS_DIR)/UGMK_REP
	else
		echo "username=shareMan" >> $(UMMC_CREDENTIALS_DIR)/UGMK_REP
		echo "password=rtf-123" >> $(UMMC_CREDENTIALS_DIR)/UGMK_REP
	fi
}

function InitBaseSystem {
	domainname ugmk.com
	SetEnviromentVariables
	InstallBaseApplications
	CreateBaseDirs
}

function ConfigureNginx {
	echo "server {" >> /etc/nginx/sites-available/$(hostname).$(domainname)
    echo "	listen  443 ssl;" >> /etc/nginx/sites-available/$(hostname).$(domainname)
    echo "	root /usr/share/nginx/www;" >> /etc/nginx/sites-available/$(hostname).$(domainname)
	echo "	index index.html;" >> /etc/nginx/sites-available/$(hostname).$(domainname)
	echo "	" >> /etc/nginx/sites-available/$(hostname).$(domainname)
	echo "	server_name             $(hostname).$(domainname);" >> /etc/nginx/sites-available/$(hostname).$(domainname)
	echo "	ssl_certificate         /etc/nginx/ssl/ugmk-as2.ugmk.com.pem;" >> /etc/nginx/sites-available/$(hostname).$(domainname)
	echo "	ssl_certificate_key     /etc/nginx/ssl/ugmk-as2.ugmk.com.key;" >> /etc/nginx/sites-available/$(hostname).$(domainname)
	echo "	ssl_protocols           SSLv3 TLSv1 TLSv1.1 TLSv1.2;" >> /etc/nginx/sites-available/$(hostname).$(domainname)
	echo "	ssl_ciphers             HIGH:!aNULL:!MD5;" >> /etc/nginx/sites-available/$(hostname).$(domainname)
	echo "	location / {" >> /etc/nginx/sites-available/$(hostname).$(domainname)
	echo "		try_files $uri $uri/ /index.html;" >> /etc/nginx/sites-available/$(hostname).$(domainname)
	echo "	}" >> /etc/nginx/sites-available/$(hostname).$(domainname)
	echo "}" >> /etc/nginx/sites-available/$(hostname).$(domainname)
}

InitBaseSystem
SetCredentials "shareMan" "rtf-123"

# need testinc