FROM ubuntu:24.04

RUN apt-get update && apt-get install -y \
    curl \
    git \
    bash \
    tar \
    libicu-dev \
    libicu74 \
    && rm -rf /var/lib/apt/lists/*

RUN useradd -m runner

COPY runner-entrypoint.sh /home/runner/runner-entrypoint.sh
RUN chmod +x /home/runner/runner-entrypoint.sh

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