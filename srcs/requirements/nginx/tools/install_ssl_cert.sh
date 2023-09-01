#!/bin/bash

mkdir -p /etc/nginx/ssl
echo $SSL_KEY > /etc/nginx/ssl/yrabby.key
echo $SSL_CRT > /etc/nginx/ssl/yrabby.crt
