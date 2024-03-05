FROM gruntwork/terragrunt:0.0.2

ARG TG_VER

RUN sudo apt-get update && sudo apt-get install -y time
ENV TG_VERSION="${TG_VER}"
RUN tgswitch

USER root
WORKDIR /code