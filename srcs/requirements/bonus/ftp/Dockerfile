
FROM debian:buster

RUN apt-get update && \
    apt-get install -y vsftpd

COPY ./conf/vsftpd.conf /etc/vsftpd.conf

# Setup ftp installation
COPY ./tools/ftp.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/ftp.sh

EXPOSE 21

ENTRYPOINT ["/usr/local/bin/ftp.sh"]

CMD ["vsftpd", "/etc/vsftpd.conf"]
