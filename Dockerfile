FROM golang:alpine as builder
RUN mkdir /build
ADD . /build
WORKDIR /build
RUN CGO_ENABLED=0 go build -o main .

FROM gcr.io/distroless/static
COPY --from=builder /build/main /app/
WORKDIR /app
EXPOSE 8080
CMD ["/app/main"]
