# Etapa de build
FROM golang:1.19 AS builder
WORKDIR /app
COPY . .
RUN go mod tidy
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o meu_app .

# Etapa final
FROM debian:buster-slim
WORKDIR /app
COPY --from=builder /app/meu_app .
RUN chmod +x /app/meu_app
ENTRYPOINT ["/app/meu_app"]
