FROM        debian
MAINTAINER  Love Nyberg "love.nyberg@lovemusic.se"

# Update the package repository
RUN apt-get update; apt-get upgrade -y; apt-get install locales

# Configure timezone and locale
RUN echo "Europe/Stockholm" > /etc/timezone; dpkg-reconfigure -f noninteractive tzdata
RUN export LANGUAGE=en_US.UTF-8; export LANG=en_US.UTF-8; export LC_ALL=en_US.UTF-8; locale-gen en_US.UTF-8; DEBIAN_FRONTEND=noninteractive dpkg-reconfigure locales

# Compiling and installing node.js
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y wget curl python g++ make checkinstall fakeroot && \
	src=$(mktemp -d) && cd $src && \
	wget -N http://nodejs.org/dist/node-latest.tar.gz && \
	tar xzvf node-latest.tar.gz && cd node-v* && \
	./configure && \
	fakeroot checkinstall -y --install=no --pkgversion $(echo $(pwd) | sed -n -re's/.+node-v(.+)$/\1/p') make -j$(($(nproc)+1)) install && \
	dpkg -i node_*

# Installing possible node executers
RUN npm install -g nodemon forever

RUN mkdir /var/www

EXPOSE 8080

ADD start.sh /start.sh
RUN chmod 0755 /start.sh
CMD ["bash", "start.sh"]