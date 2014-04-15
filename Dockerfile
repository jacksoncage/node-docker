FROM        debian
MAINTAINER  Love Nyberg "love.nyberg@lovemusic.se"

# Update the package repository
RUN apt-get update; apt-get upgrade -y; apt-get install locales

# Configure timezone and locale
RUN echo "Europe/Stockholm" > /etc/timezone; dpkg-reconfigure -f noninteractive tzdata
RUN export LANGUAGE=en_US.UTF-8; export LANG=en_US.UTF-8; export LC_ALL=en_US.UTF-8; locale-gen en_US.UTF-8; DEBIAN_FRONTEND=noninteractive dpkg-reconfigure locales

# Install base system
RUN DEBIAN_FRONTEND=noninteractive apt-get -t wheezy-backports install -y wget curl nodejs
RUN npm install nodemon -g

RUN mkdir /var/www

EXPOSE 8080

ADD start.sh /start.sh
RUN chmod 0755 /start.sh
CMD ["bash", "start.sh"]