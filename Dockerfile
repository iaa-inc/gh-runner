FROM ghcr.io/actions/runner:latest

USER root

# Install Python & other dependencies
RUN apt-get update && apt-get install -y python3 python3-pip apt-transport-https \
    ca-certificates curl file make jq unzip autoconf automake gcc g++ gnupg

# Install NodeJS, and Yarn
RUN curl -sL https://deb.nodesource.com/setup_20.x | bash - && \
    apt-get install -y nodejs && \
    npm install -g yarn

RUN add-apt-repository ppa:ondrej/php

# Install PHP & Extensions
# ctype, curl, fileinfo, json, mbstring, mysqli, openssl, pdo, pgsql, redis, tokenizer, xml, zip, bcmath, soap, php-gd, pdo_sqlite
RUN apt install php8.3 php8.3-ctype php8.3-curl php8.3-fileinfo php8.3-json \
    php8.3-mbstring php8.3-mysqli php8.3-openssl php8.3-pdo php8.3-pgsql  \
    php8.3-redis php8.3-tokenizer php8.3-xml php8.3-zip php8.3-bcmath  \
    php8.3-soap php8.3-gd php8.3-pdo_sqlite php8.3-sqlite3 php8.3-mysql  \
    php8.3-intl php8.3-imagick php8.3-xmlrpc php8.3-ldap php8.3-xml

# Install Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

USER runner