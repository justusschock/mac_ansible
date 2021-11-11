FROM python:3.7-slim

WORKDIR /usr/app

COPY ./* /usr/app

RUN apt update \
  && apt install -y openssh-server software-properties-common \
  && pip install -r requirements.txt && ansible-galaxy install -r requirements.yml

