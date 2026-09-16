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
RUN apt install -y php8.5 php8.5-cgi php8.5-cli php8.5-curl php8.5-dev php8.5-fpm php8.5-intl  \
    php8.5-mbstring php8.5-mysql php8.5-pgsql php8.5-xml php8.5-zip php8.5-bcmath \
    php8.5-soap php8.5-gd php8.5-sqlite3 php8.5-imagick

# Install Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

USER runner
