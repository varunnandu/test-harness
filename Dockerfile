FROM continuumio/miniconda3

RUN conda create --name py36 python=3.6
SHELL ["conda", "run", "-n", "py36", "/bin/bash", "-c"]

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
      build-essential \
      git \
      && \
    apt-get purge && apt-get clean

WORKDIR /opt/tempus/
COPY . ./
RUN make init