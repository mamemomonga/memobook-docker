#!/bin/sh
set -xe

sudo sh << 'END_OF_SUDO'
set -xe

cat > /etc/apt/sources.list.d/backports.list << 'EOS'
deb http://ftp.jp.debian.org/debian jessie-backports main
EOS

aptitude update
aptitude install -y apt-transport-https ca-certificates
apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D

cat > /etc/apt/sources.list.d/docker.list << 'EOS'
deb https://apt.dockerproject.org/repo debian-jessie main
EOS

aptitude update
apt-cache policy docker-engine
aptitude update
aptitude install -y docker-engine
service docker start

apt-get -y install jq build-essential

for i in compose machine; do
  TAGNAME=$(curl -Ls https://api.github.com/repos/docker/$i/releases/latest | jq -r '.tag_name')
  URL=https://github.com/docker/$i/releases/download/$TAGNAME/docker-$i-`uname -s`-`uname -m`
  echo "docker-$i TAG: $TAGNAME"
  echo "docker-$i URL: $URL"
  curl -L $URL > /usr/local/bin/docker-$i
  chmod +x /usr/local/bin/docker-$i
  docker-$i -v
done

END_OF_SUDO


if [ -z $(getent group docker) ]; then
  sudo groupadd docker
fi
sudo gpasswd -a $USER docker
sudo service docker restart
exec $SHELL

