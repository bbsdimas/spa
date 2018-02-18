FROM debian
MAINTAINER bbsdimas@gmail.com
 
#RUN apt-get update && apt-get install -y openssh-server apache2 supervisor
#RUN mkdir -p /var/lock/apache2 /var/run/apache2 /var/run/sshd /var/log/supervisor


RUN apt-get update
RUN apt-get install rpm mc vim bash -y
RUN apt-get install openssh-server wget curl sudo gnupg apt-transport-https apt-utils -y
RUN apt-get install lsb-release ca-certificates -y
# php72
RUN wget -O /etc/apt/trusted.gpg.d/php.gpg https://packages.sury.org/php/apt.gpg
RUN echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" | sudo tee /etc/apt/sources.list.d/php.list
# nodejs6
RUN curl https://deb.nodesource.com/gpgkey/nodesource.gpg.key | apt-key add -
RUN echo "deb https://deb.nodesource.com/node_6.x $(lsb_release -sc) main" | sudo tee /etc/apt/sources.list.d/node.list
RUN apt-get install apache2 libapache2-mod-php -y
RUN apt-get update

# composer git
RUN apt-get install composer git -y
RUN apt-get install php-xml php-mbstring -y
RUN apt-get install nodejs -y

#make user
#RUN useradd app
RUN useradd --create-home app
#make apps
RUN cd /
RUN mkdir app
RUN cd app
RUN git clone https://github.com/Saritasa/simplephpapp.git
RUN chown -R app:app simplephpapp
RUN cd simplephpapp                 
RUN bash
RUN sudo -u app composer install
RUN sudo -u app npm install


RUN echo "<IfModule alias_module>" > /etc/apache2/conf-enabled/app.conf
RUN echo " Alias /app/ \"/app/simplephpapp/public\"" >> /etc/apache2/conf-enabled/app.conf
RUN echo " <Directory \"/app/simplephpapp/public\">" >> /etc/apache2/conf-enabled/app.conf
RUN echo "  Options FollowSymlinks" >> /etc/apache2/conf-enabled/app.conf
RUN echo "  AllowOverride None" >> /etc/apache2/conf-enabled/app.conf
RUN echo "  Require all granted" >> /etc/apache2/conf-enabled/app.conf
RUN echo " </Directory>" >> /etc/apache2/conf-enabled/app.conf
RUN echo "</IfModule>" >> /etc/apache2/conf-enabled/app.conf

RUN chmod -R 777 /app/simplephpapp/storage
RUN chmod -R 777 /app/simplephpapp/bootstrap/cache
RUN service apache2 restart


