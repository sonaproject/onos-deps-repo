FROM ubuntu:18.04

ENV NODEJS_VERSION v8.11.1

# Install Nginx
RUN \
  apt-get update && \
  apt-get install -y nginx wget && \
  rm -rf /var/lib/apt/lists/* && \
  echo "\ndaemon off;" >> /etc/nginx/nginx.conf && \
  chown -R www-data:www-data /var/lib/nginx

# Define mountable directories.
VOLUME ["/etc/nginx/sites-enabled", "/etc/nginx/certs", "/etc/nginx/conf.d", "/var/log/nginx"]

# Download ONOS dependencies
RUN mkdir -p /var/www/html/dist/${NODEJS_VERSION} && \
      cd /var/www/html/dist/${NODEJS_VERSION} && \
      wget https://nodejs.org/dist/${NODEJS_VERSION}/node-${NODEJS_VERSION}-darwin-x64.tar.gz && \
      wget https://nodejs.org/dist/${NODEJS_VERSION}/node-${NODEJS_VERSION}-linux-x64.tar.gz

# Define working directory.
WORKDIR /etc/nginx

# Define default command.
CMD ["nginx"]

# Expose ports.
EXPOSE 80
EXPOSE 443
