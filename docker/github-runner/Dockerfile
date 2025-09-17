FROM ubuntu:24.04

SHELL ["/bin/bash", "-c"]

# libicu74 is for ubuntu:24.04 is required to download github-runner
# rync and openssh-client are required for the rsync action to work correctly
RUN apt-get update && apt-get install -y \
    curl \
    git \
    bash \
    tar \
    libicu-dev \
    libicu74 \
    docker.io \
    lsb-release \
    rsync \
    openssh-client \
    && rm -rf /var/lib/apt/lists/*

# Environment variables that will be used in the entrypoint.sh file    
ARG REPOSITORY_URL
ENV REPOSITORY_URL=$REPOSITORY_URL
ARG RUNNER_TOKEN
ENV RUNNER_TOKEN=$RUNNER_TOKEN
ARG CLOUDFLARE_SSH_TUNNEL_ID
ENV CLOUDFLARE_SSH_TUNNEL_ID=$CLOUDFLARE_SSH_TUNNEL_ID
ARG CLOUDFLARE_SSH_TUNNEL_TOKEN
ENV CLOUDFLARE_SSH_TUNNEL_TOKEN=$CLOUDFLARE_SSH_TUNNEL_TOKEN

# Copy the entrypoint.sh file and add write permission
COPY entrypoint.sh /home/runner/entrypoint.sh
RUN chmod +x /home/runner/entrypoint.sh

# Get HOST ID's to create runner user and group
ARG UID
ARG GID
ARG DOCKER_HOST_GID

RUN if ! getent group runner >/dev/null; then \
      groupadd -g ${GID} runner; \
    fi

RUN if ! getent group docker >/dev/null; then \
      groupadd -g ${DOCKER_HOST_GID} docker; \
    else \
      groupmod -g ${DOCKER_HOST_GID} docker; \
    fi

RUN if ! id -u runner >/dev/null 2>&1; then \
      useradd -m -u ${UID} -g ${GID} -G docker runner; \
    fi

WORKDIR /home/runner

# Download github-runner and install its dependencies
ENV RUNNER_VERSION=2.328.0
ENV ARCH=x64
ENV RUNNER_HASH=01066fad3a2893e63e6ca880ae3a1fad5bf9329d60e77ee15f2b97c148c3cd4e

RUN curl -o actions-runner-linux-${ARCH}-${RUNNER_VERSION}.tar.gz -L \
    https://github.com/actions/runner/releases/download/v${RUNNER_VERSION}/actions-runner-linux-${ARCH}-${RUNNER_VERSION}.tar.gz && \
    echo "${RUNNER_HASH}  actions-runner-linux-${ARCH}-${RUNNER_VERSION}.tar.gz" | sha256sum -c && \
    tar xzf actions-runner-linux-${ARCH}-${RUNNER_VERSION}.tar.gz && \
    rm actions-runner-linux-${ARCH}-${RUNNER_VERSION}.tar.gz

RUN ./bin/installdependencies.sh

# Download and install Cloudflare/Cloudflared so that the runner can connect via SSH to the server when executing the rsync action
RUN mkdir -p --mode=0755 /usr/share/keyrings && \
    curl -fsSL https://pkg.cloudflare.com/cloudflare-main.gpg \
      | tee /usr/share/keyrings/cloudflare-main.gpg >/dev/null && \
    echo "deb [signed-by=/usr/share/keyrings/cloudflare-main.gpg] https://pkg.cloudflare.com/cloudflared $(lsb_release -cs) main" \
      | tee /etc/apt/sources.list.d/cloudflared.list && \
    apt-get update && apt-get install -y cloudflared

USER runner

ENTRYPOINT ["/home/runner/entrypoint.sh"]