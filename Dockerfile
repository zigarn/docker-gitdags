FROM ubuntu:21.04

ARG BUILD_DATE=none
ARG VCS_REF=none
ARG VERSION=none

LABEL org.opencontainers.image.created=$BUILD_DATE \
      org.opencontainers.image.authors="Alexandre Garnier <zigarn@gmail.com>" \
      org.opencontainers.image.url="https://github.com/zigarn/docker-gitdags" \
      org.opencontainers.image.documentation="https://github.com/zigarn/docker-gitdags/blob/$VCS_REF/README.md" \
      org.opencontainers.image.source="https://github.com/zigarn/docker-gitdags.git" \
      org.opencontainers.image.version=$VERSION \
      org.opencontainers.image.revision=$VCS_REF \
      org.opencontainers.image.vendor="Zigarn" \
      org.opencontainers.image.licenses="MIT" \
      org.opencontainers.image.title="docker-gitdags" \
      org.opencontainers.image.description="gitdags docker image to generate git commit graphs"

# Install necessary binaries and libraries
RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
         texlive \
         xzdec \
         pdf2svg \
         wget \
         xz-utils \
         librsvg2-bin \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*
RUN tlmgr init-usertree \
    && tlmgr repository add ftp://tug.org/historic/systems/texlive/2020/tlnet-final \
    && tlmgr repository remove http://mirror.ctan.org/systems/texlive/tlnet \
    && tlmgr install pgf xcolor-solarized standalone lm
RUN mkdir -p $(kpsewhich -var-value=TEXMFHOME)/tex/latex/gitdags/ \
    && wget -q --no-check-certificate -O $(kpsewhich -var-value=TEXMFHOME)/tex/latex/gitdags/gitdags.sty https://github.com/Jubobs/gitdags/raw/master/gitdags.sty

# Data volumes
VOLUME /data
WORKDIR /data

# SVG and PNG generation script
ADD generateIMG.sh /generateIMG.sh
ENTRYPOINT ["/generateIMG.sh"]
