#!/bin/bash

sed -i "s/my_cert/\/etc\/ssl\/certs\/goudmand.crt/g" /etc/nginx/sites-available/default
sed -i "s/my_key/\/etc\/ssl\/private\/goudmand.key/g" /etc/nginx/sites-available/default
sed -i "s/DOMAIN_NAME/$nginx_domain/g" /etc/nginx/sites-available/default   

nginx -g "daemon off;"
