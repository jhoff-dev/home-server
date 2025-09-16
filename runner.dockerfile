FROM ubuntu:24.04

SHELL ["/bin/bash", "-c"]

RUN apt-get update && apt-get install -y \
    curl \
    git \
    bash \
    tar \
    libicu-dev \
    libicu74 \
    docker.io \
    && rm -rf /var/lib/apt/lists/*

ARG REPOSITORY_URL
ENV REPOSITORY_URL=$REPOSITORY_URL
ARG RUNNER_TOKEN
ENV RUNNER_TOKEN=$RUNNER_TOKEN

COPY runner-entrypoint.sh /home/runner/runner-entrypoint.sh
RUN chmod +x /home/runner/runner-entrypoint.sh

ARG UID
ARG GID
ARG DOCKER_HOST_GID

RUN groupmod -g ${DOCKER_HOST_GID:-$GID} docker 2>/dev/null || \
    groupadd -g ${DOCKER_HOST_GID:-$GID} docker

RUN useradd -m -u ${UID} -g ${GID} -G docker runner

WORKDIR /home/runner

ENV RUNNER_VERSION=2.328.0
ENV ARCH=x64
ENV RUNNER_HASH=01066fad3a2893e63e6ca880ae3a1fad5bf9329d60e77ee15f2b97c148c3cd4e

RUN curl -o actions-runner-linux-${ARCH}-${RUNNER_VERSION}.tar.gz -L \
    https://github.com/actions/runner/releases/download/v${RUNNER_VERSION}/actions-runner-linux-${ARCH}-${RUNNER_VERSION}.tar.gz && \
    echo "${RUNNER_HASH}  actions-runner-linux-${ARCH}-${RUNNER_VERSION}.tar.gz" | sha256sum -c && \
    tar xzf actions-runner-linux-${ARCH}-${RUNNER_VERSION}.tar.gz && \
    rm actions-runner-linux-${ARCH}-${RUNNER_VERSION}.tar.gz

RUN ./bin/installdependencies.sh

USER runner

ENTRYPOINT ["/home/runner/runner-entrypoint.sh"]