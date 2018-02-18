# spa
Dockerfile for simplephpapp

1.git clone https://github.com/bbsdimas/spa.git
note:remeber path to spa

2. in docker envirment
cd path spa
note:in linux use sudo

docker build -t spa .
docker run -i -t -p 8080:80 spa bash

3. in docker container 
/root/prepare.sh

4. in host machine http://%docker ip%:8080/app
to check in docker container:
	- apt-get install lynx -y
	- lynx localhost/app/

trable:
-in linux container, php 7.2
-determinate network ip
