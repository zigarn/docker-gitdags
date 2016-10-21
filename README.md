# [gitdags](https://github.com/Jubobs/gitdags) docker image to generate git commit graphs

[![Build Status](https://travis-ci.org/zigarn/docker-gitdags.svg?branch=master)](https://travis-ci.org/zigarn/docker-gitdags)

[![Image Metadata](https://images.microbadger.com/badges/image/zigarn/gitdags.svg)](https://microbadger.com/images/zigarn/gitdags)
[![version](https://images.microbadger.com/badges/version/zigarn/gitdags.svg)](https://microbadger.com/images/zigarn/gitdags)
[![commit](https://images.microbadger.com/badges/commit/zigarn/gitdags.svg)](http://microbadger.com/images/zigarn/gitdags)

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
