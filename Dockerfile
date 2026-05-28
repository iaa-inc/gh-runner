FROM ghcr.io/actions/actions-runner:latest

USER root

# Install Python & other dependencies
RUN apt-get update && apt-get install -y python3 python3-pip apt-transport-https \
    ca-certificates curl file make jq unzip autoconf automake gcc g++ gnupg software-properties-common \
    git

# Install NodeJS, and Yarn
RUN curl -sL https://deb.nodesource.com/setup_24.x | bash - && \
    apt-get install -y nodejs && \
    npm install -g yarn

RUN add-apt-repository ppa:ondrej/php

# Install PHP & Extensions
RUN apt install -y php8.4 php8.4-cgi php8.4-cli php8.4-curl php8.4-dev php8.4-fpm php8.4-intl  \
    php8.4-mbstring php8.4-mysql php8.4-opcache php8.4-pgsql php8.4-xml php8.4-zip php8.4-bcmath \
    php8.4-soap php8.4-gd php8.4-sqlite3 php8.4-imagick

# Install Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

USER runner
