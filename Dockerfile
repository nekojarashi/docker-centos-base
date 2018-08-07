FROM centos:centos6.9
LABEL maintainer="y-okubo"

RUN yum install -y http://dev.mysql.com/get/mysql-community-release-el6-5.noarch.rpm \
&&  yum groupinstall "Development Tools" -y \
&&  yum install -y epel-release \
&&  yum install -y \
    curl \
    dtach \
    hash-slinger \
    httpd-devel \
    ImageMagick \
    ImageMagick-devel \
    libcurl-devel \
    libexif \
    libexif-devel \
    libffi-devel \
    libfontconfig.so.1 \
    libfreetype.so.6 \
    libsndfile \
    libsndfile-devel \
    libstdc++.so.6 \
    libxslt-devel \
    libyaml-devel \
    mysql-community-client \
    mysql-community-devel \
    mysql-utilities \
    npm \
    openssh-server \
    openssl-devel \
    perl-Image-ExifTool \
    readline-devel \
    sqlite-devel \
    sudo \
    vim \
    wget \
    zlib-devel \
&&  rm -rf /var/cache/yum/* \
&&  yum clean all

# 言語とタイムゾーン
ENV LANG=ja_JP.UTF-8
RUN localedef -f UTF-8 -i ja_JP ja_JP.UTF-8 \
&&  cp -p /usr/share/zoneinfo/Japan /etc/localtime \
&&  echo 'ZONE="Asia/Tokyo"' > /etc/sysconfig/clock

# SSH ログイン有効化
RUN sed -ri 's/^#PermitRootLogin yes/PermitRootLogin yes/' /etc/ssh/sshd_config \
&&  sed -ri 's/^#PermitEmptyPasswords no/PermitEmptyPasswords yes/' /etc/ssh/sshd_config \
&&  sed -ri 's/^UsePAM yes/UsePAM no/' /etc/ssh/sshd_config \
&&  passwd -d root

EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]
