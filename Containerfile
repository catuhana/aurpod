FROM archlinux:base-devel AS builder
WORKDIR /
COPY /scripts /

RUN chmod +x build.sh pre-build.sh
RUN ./pre-build.sh

VOLUME [ "/packages" ]
ENTRYPOINT [ "/build.sh" ]
