FROM mtorromeo:latest

#Install nginx (w/ LuaJIT) and tools
RUN pacman -Syu --no-cache curl nginx-mainline-mod-lua
RUN mkdir -p /run/nginx
COPY /contrib/default.conf /etc/nginx/conf.d/default.conf

#Install Signal Sciences Agent
RUN curl https://dl.signalsciences.net/sigsci-agent/sigsci-agent_latest.tar.gz | tar -zxf - -C /usr/sbin/

#Install Signal Sciences nginx module
RUN mkdir -p /opt/sigsci/nginx
RUN curl https://dl.signalsciences.net/sigsci-module-nginx/sigsci-module-nginx_latest.tar.gz | tar -zxf - -C /
RUN mv /sigsci-module-nginx/* /opt/sigsci/nginx && rm -rf /sigsci-module-nginx

#Enable Signal Sciences module by including in nginx.conf
COPY /contrib/sigsci-include.conf /etc/nginx/conf.d/sigsci-include.conf

COPY contrib/start.sh /start.sh
RUN chmod +x /start.sh

ENTRYPOINT ["/start.sh"]
