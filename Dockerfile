FROM ubuntu:16.10

MAINTAINER Alexandre Garnier <zigarn@gmail.com>

ARG BUILD_DATE=none
ARG VCS_REF=none
ARG VERSION=none

LABEL org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.name="docker-gitdags" \
      org.label-schema.description="gitdags docker image to generate git commit graphs" \
      org.label-schema.usage="https://github.com/zigarn/docker-gitdags/blob/$VCS_REF/README.md" \
      org.label-schema.url="https://github.com/zigarn/docker-gitdags" \
      org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.vcs-url="https://github.com/zigarn/docker-gitdags.git" \
      org.label-schema.vendor="Zigarn" \
      org.label-schema.version=$VERSION \
      org.label-schema.schema-version="1.0"

# Install necessary binaries and libraries
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
         texlive \
         xzdec \
         pdf2svg \
         wget \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*
RUN tlmgr init-usertree && tlmgr install pgf xcolor-solarized standalone lm
RUN mkdir -p $(kpsewhich -var-value=TEXMFHOME)/tex/latex/gitdags/ \
    && wget -q --no-check-certificate -O $(kpsewhich -var-value=TEXMFHOME)/tex/latex/gitdags/gitdags.sty https://github.com/Jubobs/gitdags/raw/master/gitdags.sty

# Data volumes
VOLUME /data
WORKDIR /data

# SVG generation script
ADD generateSVG.sh /generateSVG.sh
ENTRYPOINT ["/generateSVG.sh"]
