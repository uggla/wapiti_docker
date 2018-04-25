FROM fedora:27

ENV WAPITI_VERSION 3.0.0

RUN sed -i 'a fastestmirror=true' /etc/dnf/dnf.conf
RUN dnf install -y gcc libxml2-devel libxslt-devel redhat-rpm-config python3-devel wget && dnf clean all

RUN mkdir -p /opt \
&& cd /opt \
&& wget http://downloads.sourceforge.net/project/wapiti/wapiti/wapiti-${WAPITI_VERSION}/wapiti-${WAPITI_VERSION}.tar.gz \
&& tar xfvz wapiti-${WAPITI_VERSION}.tar.gz \
&& rm -fr wapiti-${WAPITI_VERSION}.tar.gz \
&& cd wapiti-${WAPITI_VERSION} \
&& ln -sF /opt/wapiti-${WAPITI_VERSION} /opt/wapiti \
&& chmod 755 /opt/wapiti/bin/wapiti \
&& adduser -d /workdir -s /bin/bash wapiti

RUN cd /opt/wapiti \
&& pip3 install requests \
&& pip3 install beautifulsoup4 \
&& python3 setup.py install

USER wapiti
VOLUME /workdir
WORKDIR /workdir

ENTRYPOINT ["wapiti"]
