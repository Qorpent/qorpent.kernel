cat /etc/apt/sources.list | grep -v experimental/mono > /etc/apt/sources.list
echo deb http://debian.meebey.net/experimental/mono /
apt-get install -y mono-runtime mono-xbuild mono-mcs
apt-get install -y libmono-system-data4.0-cil
apt-get install -y libmono-system-xml4.0-cil libmono-system-xml-linq4.0-cil
apt-get install -y libmono-system-net4.0-cil libmono-system-net-http4.0-cil
apt-get install -y libmono-system-web4.0-cil
