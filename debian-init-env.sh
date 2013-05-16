#!/bin/bash

function SetEnviromentVariables() {
	export UMMC_WEB_SSL_DIR=/etc/nginx/ssl
	export UMMC_CONFIG_DIR=/usr/share/config
	export UMMC_REP_DIR=/mnt/rep
}

function CreateBaseDirs() {
	mkdir -p $UMMC_CONFIG_DIR
}

function InstallBaseApplications() {
	apt-get install nginx
	apt-get install git
	apt-get install autofs
}

function InitBaseSystem {
	InstallBaseApplications()
	CreateBaseDirs()
}

InitBaseSystem()