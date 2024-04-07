# Import the base image
FROM eclipse-temurin:20-jammy

# Installing Depedencies
RUN apt-get update -y \
    && apt-get install -y --no-install-recommends curl ca-certificates openssl git tar sqlite3 fontconfig libfreetype6 libstdc++6 lsof build-essential tzdata iproute2 locales \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
    && useradd -m -d /home/container container \
    && locale-gen en_US.UTF-8

# Set the locale
ENV LC_ALL=en_US.UTF-8
ENV LANG=en_US.UTF-8
ENV LANGUAGE=en_US.UTF-8

# Set User and Workdir
USER container
ENV  USER=container HOME=/home/container
WORKDIR /home/container

# Copy the entrypoint
COPY ./entrypoint.sh /entrypoint.sh

# Set the entrypoint
CMD ["/bin/bash", "/entrypoint.sh"]