FROM debian
MAINTAINER bbsdimas@gmail.com

COPY prepare.sh /root/prepare.sh

EXPOSE  80

RUN chmod 777 /root/prepare.sh 


