# Dockerfile to build planarRad as a CLI container
FROM ubuntu:24.04




RUN apt-get update && apt-get install -y \ 
    g++  \
    libsm-dev \
    libjpeg-dev \
    libboost-all-dev \
    make


ENV JUDE2DIR=/app/jude2_install
ENV LD_LIBRARY_PATH=$JUDE2DIR/lib
ENV PATH=$JUDE2DIR/bin:$PATH

WORKDIR /app
COPY  . /app/

RUN bash example_build

ENTRYPOINT ["/bin/bash", "/app/docker/planarRad_cli.sh"]