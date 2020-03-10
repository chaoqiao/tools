FROM busybox:1.31.0
MAINTAINER Chao.Qiao
COPY index.html /tmp
EXPOSE 80
ENTRYPOINT ["/bin/sh","-c","echo `hostname` > /tmp/hostname.html;httpd -f -h /tmp"]
