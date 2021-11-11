FROM python:3.7-slim

RUN apt update \
  && apt install -y openssh-server software-properties-common

WORKDIR /usr/app

COPY ./* /usr/app

RUN pip install -r requirements.txt && ansible-galaxy install -r requirements.yml

