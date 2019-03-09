FROM ubuntu:16.04

MAINTAINER Nishizaka <s.nishizaka@gvatech.co.jp

RUN apt-get -y update && apt-get install -y --no-install-recommends \
         wget \
         curl \
         python3.5-dev \
         nginx \
         ca-certificates \
         mecab \
         libmecab-dev \
         mecab-ipadic \
         mecab-ipadic-utf8 \
         git \
         make \
         xz-utils \
         file \
         sudo \
         swig \
         nano \
         vim \
         emacs \
         locales \
         patch \
         build-essential \
         ssh \
&& rm -rf /var/lib/apt/lists/*

RUN locale-gen ja_JP.UTF-8
ENV LANG ja_JP.UTF-8
ENV LANGUAGE ja_JP:ja
ENV LC_ALL ja_JP.UTF-8

RUN wget https://bootstrap.pypa.io/3.3/get-pip.py && python3.5 get-pip.py && \
pip3.5 install scipy scikit-learn pandas flask gevent gunicorn && \
rm -rf /root/.cache

ENV PYTHONUNBUFFERED=TRUE
ENV PYTHONDONTWRITEBYTECODE=TRUE
ENV PATH="/opt/program:${PATH}"

RUN pip install --upgrade pip
RUN pip install jupyter -U && pip install jupyterlab

#EXPOSE 8888

#ENTRYPOINT ["jupyter", "lab","--ip=0.0.0.0","--allow-root" ,"--no-browser"]
