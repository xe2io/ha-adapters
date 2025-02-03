FROM golang:1.23-alpine AS gobuild
WORKDIR /opt/ha-adapters
COPY go.* ./
RUN go mod download
COPY . .

RUN go build ha-adapters/cmd/ad410

# Final image
#FROM alpine:latest
FROM scratch
WORKDIR /opt/ha-adapters
COPY --from=gobuild /opt/ha-adapters/ad410 .

ENTRYPOINT ["./ad410"]
