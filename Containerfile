FROM archlinux:base-devel AS builder
WORKDIR /
COPY build.sh pre-build.sh /

RUN chmod +x build.sh pre-build.sh
RUN ./pre-build.sh

VOLUME [ "/packages" ]
ENTRYPOINT [ "/build.sh" ]
