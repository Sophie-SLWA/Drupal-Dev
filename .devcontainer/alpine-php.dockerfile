FROM alpine:latest

ARG PHP_VERSION="84"

# Install our dependancies
RUN apk add --no-cache mysql-client git php${PHP_VERSION}
# Link the version of PHP we've installed to /usr/bin/php so just running 'php' works
RUN ln /usr/bin/php${PHP_VERSION} /usr/bin/php

# Install a million php modules
RUN apk add --no-cache php${PHP_VERSION}-dom php${PHP_VERSION}-openssl php${PHP_VERSION}-gd \
                       php${PHP_VERSION}-iconv php${PHP_VERSION}-mbstring php${PHP_VERSION}-mysqlnd \
                       php${PHP_VERSION}-pdo php${PHP_VERSION}-tokenizer php${PHP_VERSION}-phar\
                       php${PHP_VERSION}-xml php${PHP_VERSION}-zip php${PHP_VERSION}-curl \
                       php${PHP_VERSION}-session php${PHP_VERSION}-simplexml php${PHP_VERSION}-xmlwriter 

# Run the Composer Install Script
COPY install-composer.sh .
RUN . /install-composer.sh
RUN mv composer.phar /usr/bin/composer
RUN rm /install-composer.sh

# Running this command has issues with timing out on Drush?  may need the timeout extended
# COMPOSER_PROCESS_TIMEOUT=6000 composer create-project drupal/cms
  
