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

RUN git clone --depth 1 https://github.com/neologd/mecab-ipadic-neologd.git\
    && cd mecab-ipadic-neologd\
    && bin/install-mecab-ipadic-neologd -n -y -a

# Neologdのユーザ辞書周りの設定　配置場所は仮（要検討）
# ユーザ辞書は本dockerfile内に配置する　（ノウハウが絡む部分なので，gitignore必須！）
COPY ./dictfiles/.userdic.csv /opt/program/.userdic.csv
RUN /usr/lib/mecab/mecab-dict-index -d /usr/lib/mecab/dic/mecab-ipadic-neologd \
    -u /opt/program/.mda_userdic.csv -f utf-8 -t utf-8 /opt/program/.userdic.csv
RUN echo "userdic = /opt/program/.mda_userdic.csv" >> /etc/mecabrc

RUN wget https://bootstrap.pypa.io/3.3/get-pip.py && python3.5 get-pip.py && \
pip3.5 install scipy scikit-learn pandas flask gevent gunicorn && \
rm -rf /root/.cache

ENV PYTHONUNBUFFERED=TRUE
ENV PYTHONDONTWRITEBYTECODE=TRUE
ENV PATH="/opt/program:${PATH}"

RUN pip install --upgrade pip

RUN pip3.5 install mecab-python3==0.7 \
    pandas \
    pyyaml \
    gensim \
    wikipedia2vec \
    keras \
    --upgrade tensorflow \
    mojimoji \
    awscli \
    sagemaker \
    python-dotenv

RUN pip3.5 install jupyter -U && pip install jupyterlab
