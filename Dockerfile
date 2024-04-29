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
RUN apt install -y php8.3

ADD --chmod=0755 https://github.com/mlocati/docker-php-extension-installer/releases/latest/download/install-php-extensions /usr/local/bin/
RUN install-php-extensions ctype curl fileinfo json mbstring mysqli openssl pdo pgsql redis tokenizer xml zip bcmath soap gd pdo_sqlite

# Install Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

USER runner