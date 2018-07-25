FROM centos:centos6.9
LABEL maintainer="y-okubo"

RUN yum install -y http://dev.mysql.com/get/mysql-community-release-el6-5.noarch.rpm
RUN yum install -y \
    bzip2 \
    curl \
    dtach \
    epel-release \
    git \
    hash-slinger \
    httpd-devel \
    ImageMagick \
    ImageMagick-devel \
    libffi-devel \
    libfontconfig.so.1 \
    libfreetype.so.6 \
    libsndfile \
    libsndfile-devel \
    libstdc++.so.6 \
    libxslt-devel \
    libyaml-devel \
    mysql \
    mysql-devel \
    mysql-utilities \
    openssh-server \
    openssl-devel \
    perl-Image-ExifTool \
    python \
    readline-devel \
    sqlite \
    sqlite-devel \
    sudo \
    tar \
    vim \
    wget \
    zlib-devel \
&&  yum groupinstall "Development Tools" -y \
&&  yum install -y --enablerepo=epel \
    npm \
&&  yum clean all

# 言語とタイムゾーン
ENV LANG=ja_JP.UTF-8
RUN localedef -f UTF-8 -i ja_JP ja_JP.UTF-8
RUN \cp -p /usr/share/zoneinfo/Japan /etc/localtime \
&&  echo 'ZONE="Asia/Tokyo"' > /etc/sysconfig/clock

# SSH ログイン有効化
RUN sed -ri 's/^#PermitRootLogin yes/PermitRootLogin yes/' /etc/ssh/sshd_config \
&&  echo 'root:root' | chpasswd \
&&  ssh-keygen -t rsa -N "" -f /etc/ssh/ssh_host_rsa_key
EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]
