FROM ubuntu:22.04
ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
      automake \
      autoconf \
      bsdmainutils \
      ca-certificates \
      libreadline-dev \
      libncurses-dev \
      libssl-dev \
      libyaml-dev \
      libxslt-dev \
      libffi-dev \
      libtool \
      tzdata \
      unixodbc-dev \
      unzip \
      curl \
      git wget && \
    rm -rf /var/lib/apt/lists/*

ENV PATH="$PATH:/root/.asdf/shims:/root/.asdf/bin"

RUN wget https://releases.hashicorp.com/terraform/1.6.6/terraform_1.6.6_linux_amd64.zip && \
    unzip terraform_1.6.6_linux_amd64.zip && \
    mv terraform /usr/local/bin/terraform && \
    rm terraform_1.6.6_linux_amd64.zip

RUN wget https://github.com/gruntwork-io/terragrunt/releases/download/v0.54.12/terragrunt_linux_amd64 && \
    mv terragrunt_linux_amd64 /usr/local/bin/terragrunt && \
    chmod +x /usr/local/bin/terragrunt

