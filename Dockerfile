

FROM rust:slim AS base
ARG TAG=v0.11.1 


ENV CARGO_NET_GIT_FETCH_WITH_CLI=true
RUN apt-get update && \
  apt-get install -y git libssl-dev pkg-config \
  && apt-get clean

RUN git clone --branch "$TAG" --depth 1 https://github.com/typst/typst.git /typst
WORKDIR /typst
RUN CARGO_REGISTRIES_CRATES_IO_PROTOCOL=sparse cargo build -p typst-cli --release

FROM debian:stable-slim

COPY --from=base /typst/target/release/typst /usr/bin/typst
WORKDIR /tmp

RUN apt-get update && \
  apt-get install -y ca-certificates && \
  apt-get clean && \
  rm -rf /var/lib/{apt,dpkg,cache,log}/