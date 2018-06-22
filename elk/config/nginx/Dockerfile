FROM nginx:1.15.0

RUN apt-get update && apt-get install -y --no-install-recommends \
      apache2-utils && rm -rf /var/lib/apt/lists/*

# Directory for password file
RUN mkdir /etc/apache2/
