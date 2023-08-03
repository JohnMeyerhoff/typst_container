FROM rust:latest


WORKDIR /tmp


RUN cargo install --git https://github.com/typst/typst