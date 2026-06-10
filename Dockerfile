

FROM rust:slim AS builder
ARG TAG=v0.13.1  # bump this when Typst ships a new release

ENV CARGO_NET_GIT_FETCH_WITH_CLI=true
RUN apt-get update && \
  apt-get install -y --no-install-recommends git libssl-dev pkg-config \
  && apt-get clean && rm -rf /var/lib/apt/lists/*

RUN git clone --branch "$TAG" --depth 1 https://github.com/typst/typst.git /typst
WORKDIR /typst
RUN CARGO_REGISTRIES_CRATES_IO_PROTOCOL=sparse cargo build -p typst-cli --release

FROM debian:stable-slim

COPY --from=builder /typst/target/release/typst /usr/bin/typst
WORKDIR /workspace

RUN apt-get update && \
  apt-get install -y --no-install-recommends \
    ca-certificates \
    make \
    zip \
    findutils \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

ENTRYPOINT ["/bin/bash"]