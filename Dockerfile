FROM debian:13

RUN apt-get update \
    && apt install --yes tftpd-hpa \
    && apt-get autoremove --yes && apt-get clean && rm -rf /var/lib/apt/lists/*
# creates /srv/tftp/
VOLUME /srv/tftp
EXPOSE 69
ENTRYPOINT ["in.tftpd", "--foreground", "--secure", "/srv/tftp"]