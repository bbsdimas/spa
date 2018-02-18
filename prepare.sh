#!/bin/sh


apt-get update
apt-get install rpm mc vim bash -y
apt-get install openssh-server wget curl sudo gnupg apt-transport-https apt-utils -y
apt-get install lsb-release ca-certificates -y
# php72
wget -O /etc/apt/trusted.gpg.d/php.gpg https://packages.sury.org/php/apt.gpg
echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" | sudo tee /etc/apt/sources.list.d/php.list
# nodejs6
curl https://deb.nodesource.com/gpgkey/nodesource.gpg.key | apt-key add -
echo "deb https://deb.nodesource.com/node_6.x $(lsb_release -sc) main" | sudo tee /etc/apt/sources.list.d/node.list
apt-get install apache2 libapache2-mod-php -y
apt-get update

# composer git
apt-get install composer git -y
apt-get install php-xml php-mbstring -y
apt-get install nodejs -y

#make user
#useradd app
useradd --create-home app
#make apps
cd /
mkdir app
cd app
git clone https://github.com/Saritasa/simplephpapp.git
chown -R app:app simplephpapp
cd simplephpapp                 
bash
sudo -u app composer install
sudo -u app npm install


echo "<IfModule alias_module>" > /etc/apache2/conf-enabled/app.conf
echo " Alias /app/ \"/app/simplephpapp/public\"" >> /etc/apache2/conf-enabled/app.conf
echo " <Directory \"/app/simplephpapp/public\">" >> /etc/apache2/conf-enabled/app.conf
echo "  Options FollowSymlinks" >> /etc/apache2/conf-enabled/app.conf
echo "  AllowOverride None" >> /etc/apache2/conf-enabled/app.conf
echo "  Require all granted" >> /etc/apache2/conf-enabled/app.conf
echo " </Directory>" >> /etc/apache2/conf-enabled/app.conf
echo "</IfModule>" >> /etc/apache2/conf-enabled/app.conf

chmod -R 777 /app/simplephpapp/storage
chmod -R 777 /app/simplephpapp/bootstrap/cache
service apache2 restart


