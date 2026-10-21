FROM golang:1.22.5 AS builder
WORKDIR /app
COPY go.mod .
RUN go mod download
COPY . .
RUN go build -o go-web-app


FROM gcr.io/distroless/base 
COPY --from=builder /app/go-web-app .
COPY static/* static/
EXPOSE 8080
ENTRYPOINT ["./go-web-app"]