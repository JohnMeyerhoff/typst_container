FROM rust:1.77

WORKDIR /tmp
ENV CARGO_NET_GIT_FETCH_WITH_CLI=true
RUN cargo install --git https://github.com/typst/typst typst-cli
