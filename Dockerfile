FROM php:8.3.26-apache

RUN set -eux ; \
    apt-get update ; \
    apt-get -y upgrade ; \
    apt-get -y install --no-install-recommends \
        aspell-\* \
        git \
        libpspell-dev \
    ; \
    rm -rf /var/lib/apt/lists/*

RUN set -eux ; \
    docker-php-ext-install pspell

RUN set -eux ; \
    a2enmod rewrite

RUN set -eux ; \
    git clone https://github.com/roundcube/google-spell-pspell.git ; \
    install -m 0644 google-spell-pspell/spell-check-library.php . ; \
    install -m 0644 google-spell-pspell/index.php . ; \
    rm -rf google-spell-pspell

COPY --chmod=0644 .htaccess .

CMD ["apache2-foreground"]
