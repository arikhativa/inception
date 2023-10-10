#!/bin/sh

useradd -m  $FTP_USER && echo "$FTP_USER:$FTP_PASS" | chpasswd

mkdir -p /home/$FTP_USER/ftp
mkdir -p /var/run/vsftpd/empty

chown $FTP_USER:$FTP_USER /home/$FTP_USER/ftp
chmod a-w /home/$FTP_USER/ftp

echo secure_chroot_dir=/home/$FTP_USER/ftp >> /etc/vsftpd.conf

exec "$@"
