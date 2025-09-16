FROM ubuntu:latest

RUN apt-get update && apt-get install -y \
  curl unzip sudo git jq build-essential \
  && rm -rf /var/lib/apt/lists/*

RUN useradd -m runner
USER runner
WORKDIR /home/runner

RUN ARCH=$(uname -m | sed 's/x86_64/x64/') && \
    curl -o actions-runner.tar.gz -L https://github.com/actions/runner/releases/latest/download/actions-runner-linux-${ARCH}.tar.gz && \
    tar xzf actions-runner.tar.gz && \
    rm actions-runner.tar.gz

COPY runner-entrypoint.sh .
ENTRYPOINT ["./runner-entrypoint.sh"]