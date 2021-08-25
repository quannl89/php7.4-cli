####################################
# PHPDocker.io PHP 7.4 / CLI image #
####################################

FROM ubuntu:focal

# Fixes some weird terminal issues such as broken clear / CTRL+L
ENV TERM=linux

# Ensure apt doesn't ask questions when installing stuff
ENV DEBIAN_FRONTEND=noninteractive

# Install Ondrej repos for Ubuntu focal, PHP7.4, composer and selected extensions - better selection than
# the distro's packages
RUN apt-get update \
    && apt-get install -y --no-install-recommends gnupg \
    && echo "deb http://ppa.launchpad.net/ondrej/php/ubuntu focal main" > /etc/apt/sources.list.d/ondrej-php.list \
    && apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 4F4EA0AAE5267A6C \
    && apt-get update \
    && apt-get -y --no-install-recommends install \
        ca-certificates \
        curl \
        unzip \
		php7.4-dev \
        php7.4-apcu \
        php7.4-apcu-bc \
        php7.4-curl \
        php7.4-json \
        php7.4-mbstring \
        php7.4-opcache \
        php7.4-readline \
        php7.4-xml \
        php7.4-zip \
		php7.4-mysql \
		php7.4-mongodb \
		php7.4-gd \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/share/doc/*

COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

# CMD ["php", "-a"]

# If you'd like to be able to use this container on a docker-compose environment as a quiescent PHP CLI container
# you can /bin/bash into, override CMD with the following - bear in mind that this will make docker-compose stop
# slow on such a container, docker-compose kill might do if you're in a hurry
# CMD ["tail", "-f", "/dev/null"]

# Quannl Script
RUN apt update -y 
RUN apt -y install \
	git \
	python3-pip 
	
RUN pip install boto3 \
    && pip install awscli 
	
RUN echo 'max_execution_time = 600' >> /etc/php/7.4/cli/conf.d/docker-php-quannl.ini &&\
	echo "upload_max_filesize = 100M"  >> /etc/php/7.4/cli/conf.d/docker-php-quannl.ini &&\
    echo "post_max_size = 100M"  >> /etc/php/7.4/cli/conf.d/docker-php-quannl.ini &&\
    echo "memory_limit = 4096M"  >> /etc/php/7.4/cli/conf.d/docker-php-quannl.ini
	
RUN mkdir /var/www 

#RUN apt-get -y install openssh-server
#RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
#RUN service ssh start
#RUN apt-get -y install vim 
EXPOSE 22

WORKDIR "/var/www"






	
	
