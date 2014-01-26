FROM        ubuntu
MAINTAINER  Love Nyberg "love.nyberg@lovemusic.se"

# Update apt sources
RUN echo "deb http://archive.ubuntu.com/ubuntu precise main universe" > /etc/apt/sources.list

# Update the package repository
RUN apt-get update; apt-get upgrade -y; apt-get install locales

# Configure timezone and locale
RUN echo "Europe/Stockholm" > /etc/timezone; dpkg-reconfigure -f noninteractive tzdata
RUN export LANGUAGE=en_US.UTF-8; export LANG=en_US.UTF-8; export LC_ALL=en_US.UTF-8; locale-gen en_US.UTF-8; DEBIAN_FRONTEND=noninteractive dpkg-reconfigure locales

# Install base system
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y wget curl nodejs

# Install forever
npm install forever -g

# Create www folder
mkdir /var/www

# Expose port 8080
EXPOSE 8080

ADD start /start.sh
RUN chmod 0755 /start.sh
CMD ["bash", "start.sh"]