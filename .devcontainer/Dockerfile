FROM mcr.microsoft.com/devcontainers/php:8.2

# Install system dependencies
RUN apt-get update && apt-get install -y \
    git \
    unzip \
    curl \
    nodejs \
    npm

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Install latest Node.js LTS
RUN npm install -g n
RUN n lts

# Install global packages
RUN npm install -g pnpm yarn

WORKDIR /workspace
