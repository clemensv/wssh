FROM phusion/baseimage:0.9.17

RUN rm -f /etc/service/sshd/down

RUN apt-get update && \
    apt-get install -y python3 python3-pip python3-dev

# These packages are slow
RUN pip3 install gevent==1.1a1
RUN pip3 install gevent-websocket

WORKDIR /srv
COPY requirements-server.txt /srv/
COPY requirements-client.txt /srv/

COPY setup.py /srv/
COPY bin /srv/bin
COPY wssh /srv/wssh
COPY examples /srv/examples

RUN pip3 install -r requirements-server.txt
RUN pip3 install -r requirements-client.txt
RUN python3 setup.py install
