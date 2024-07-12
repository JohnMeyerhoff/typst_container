FROM rust:slim

WORKDIR /tmp
RUN cargo install --locked typst-cli
