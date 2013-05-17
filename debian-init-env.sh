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
	CRED_FILEPATH=$(UMMC_CREDENTIALS_DIR)/UGMK_REP

	if [ "$1" ] && [ "$2" ];
	then
		echo "username=$1" >> $(CRED_FILEPATH)
		echo "password=$2" >> $(CRED_FILEPATH)
	else
		echo "username=shareMan" >> $(CRED_FILEPATH)
		echo "password=rtf-123" >> $(CRED_FILEPATH)
	fi
}

function InitBaseSystem {
	domainname ugmk.com
	SetEnviromentVariables
	InstallBaseApplications
	CreateBaseDirs
}

function ConfigureNginx {
	NGINX_CONFIG_PATH=/etc/nginx/sites-available/$(hostname).$(domainname)

	echo "server {" >> $(NGINX_CONFIG_PATH)
    echo "	listen  443 ssl;" >> $(NGINX_CONFIG_PATH)
    echo "	root /usr/share/nginx/www;" >> $(NGINX_CONFIG_PATH)
	echo "	index index.html;" >> $(NGINX_CONFIG_PATH)
	echo "	" >> $(NGINX_CONFIG_PATH)
	echo "	server_name             $(hostname).$(domainname);" >> $(NGINX_CONFIG_PATH)
	echo "	ssl_certificate         /etc/nginx/ssl/ugmk-as2.ugmk.com.pem;" >> $(NGINX_CONFIG_PATH)
	echo "	ssl_certificate_key     /etc/nginx/ssl/ugmk-as2.ugmk.com.key;" >> $(NGINX_CONFIG_PATH)
	echo "	ssl_protocols           SSLv3 TLSv1 TLSv1.1 TLSv1.2;" >> $(NGINX_CONFIG_PATH)
	echo "	ssl_ciphers             HIGH:!aNULL:!MD5;" >> $(NGINX_CONFIG_PATH)
	echo "	location / {" >> $(NGINX_CONFIG_PATH)
	echo "		try_files $uri $uri/ /index.html;" >> $(NGINX_CONFIG_PATH)
	echo "	}" >> $(NGINX_CONFIG_PATH)
	echo "}" >> $(NGINX_CONFIG_PATH)
}

InitBaseSystem
SetCredentials "shareMan" "rtf-123"

# need testinc