FROM golang:1.18
WORKDIR /opt/
COPY . ./

RUN go mod download && CGO_ENABLED=0 go build -o video-server

FROM alpine:latest
ENV GIN_MODE=release
WORKDIR /root/
EXPOSE 9090/tcp
COPY --from=0 /opt/video-server ./
CMD ["./video-server"]