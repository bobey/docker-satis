FROM ubuntu:14.04

MAINTAINER Yannick Pereira-Reis <yannick.pereira.reis@gmail.com>

ENV DEBIAN_FRONTEND=noninteractive

# Install common libs
RUN apt-get update && apt-get install -y \
	 git \
	curl \
	wget \
	php5 \
	php5-cli \
	php5-common \
	php5-curl


# Install nodejs
RUN curl -sL https://deb.nodesource.com/setup | bash -
RUN apt-get install -y nodejs
RUN npm install express

# Install ssh key
RUN mkdir -p RUN mkdir /root/.ssh/
RUN touch /root/.ssh/known_hosts

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Display version information
RUN php --version
RUN composer --version

# Install Satis
RUN  composer create-project composer/satis --stability=dev --keep-vcs

ADD scripts/crontab /etc/cron.d/satis-cron
RUN chmod 0644 /etc/cron.d/satis-cron
ADD scripts/build.sh /satis/build.sh
RUN touch /var/log/satis-cron.log

VOLUME ["/app"]

WORKDIR /app

CMD ["/bin/bash", "./scripts/startup.sh"]
