FROM rust:latest

WORKDIR /tmp
CARGO_NET_GIT_FETCH_WITH_CLI=true
RUN cargo install --git https://github.com/typst/typst/tree/0.10