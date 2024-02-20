# syntax=docker/dockerfile:1
FROM python:3.12-slim-bullseye

RUN apt-get update && \
    apt-get install -yqq \
        python3-dev \
        libpq-dev \
        gcc \
        procps \
        make

WORKDIR /app

RUN --mount=type=cache,target=/root/.cache pip install uv
RUN mkdir /cache

ENV PYTHONUNBUFFERED=true
ENV XDG_CACHE_HOME=/cache/

COPY . /app
