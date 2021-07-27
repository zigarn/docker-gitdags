# [gitdags](https://github.com/Jubobs/gitdags) docker image to generate git commit graphs

[![Build Status](https://travis-ci.com/zigarn/docker-gitdags.svg?branch=master)](https://travis-ci.com/zigarn/docker-gitdags)

![Docker Image Version (latest by date)](https://img.shields.io/docker/v/zigarn/gitdags)
![Docker Image Size (latest by date)](https://img.shields.io/docker/image-size/zigarn/gitdags)
![Docker Pulls](https://img.shields.io/docker/pulls/zigarn/gitdags)

## Use

Launch the docker image with:

 - Volumes:
   - `/data`: folder containing tex files

E.g:

```shell
docker run \
  --volume ${PWD}:/data \
  zigarn/gitdags myfile.tex
```
