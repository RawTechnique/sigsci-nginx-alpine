#!/bin/sh

/usr/sbin/sigsci-agent &
nginx -g "daemon off;"
