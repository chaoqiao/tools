FROM ubuntu:18.04

MAINTAINER cqiao "986531620@qq.com"

RUN apt-get update && apt-get install nginx openssl -y

CMD ["openssl", "genrsa","-des3","-out", "server.key" ]

CMD ["openssl", "req","-new","-key","server.key","-out","server.csr"]

CMD ["openssl","rsa","-in","server.key","-out","server.key"]

CMD ["openssl","x509","-req","-days","365","-in","server.csr","-signkey","server.key","-out","server.crt"]

