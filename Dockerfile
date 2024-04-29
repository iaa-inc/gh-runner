FROM ghcr.io/actions/actions-runner:latest

USER root

# Install Python & other dependencies
RUN apt-get update && apt-get install -y python3 python3-pip apt-transport-https \
    ca-certificates curl file make jq unzip autoconf automake gcc g++ gnupg software-properties-common

# Install NodeJS, and Yarn
RUN curl -sL https://deb.nodesource.com/setup_20.x | bash - && \
    apt-get install -y nodejs && \
    npm install -g yarn

RUN add-apt-repository ppa:ondrej/php

# Install PHP & Extensions
RUN apt install -y php8.3 php8.3-cgi php8.3-cli php8.3-curl php8.3-dev php8.3-fpm php8.3-intl  \
    php8.3-mbstring php8.3-mysql php8.3-opcache php8.3-phsql php8.3-xml php8.3-zip

# Install Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

USER runner