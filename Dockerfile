FROM docker.io/rust:1-alpine3.20 AS build
RUN apk add --no-cache typst
WORKDIR /build
COPY src Cargo.lock Cargo.toml ./
# I don't think this gives us what I wanted but. We do get a build out of it. I just wish it were local.
RUN apk add --no-cache musl-dev
RUN cargo install mdbook-typst
RUN cp /usr/local/cargo/bin/mdbook-typst /
RUN cp /usr/bin/typst /

FROM scratch AS final
COPY --from=build /typst /
COPY --from=build /mdbook-typst /
