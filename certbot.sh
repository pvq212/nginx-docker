#!/bin/bash
certbot --nginx --domains $1 --email ${CERTBOT_EMAIL} --agree-tos --redirect --reinstall --non-interactive;
