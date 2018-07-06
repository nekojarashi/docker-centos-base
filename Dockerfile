FROM centos:centos6.9
LABEL maintainer="y-okubo"

RUN yum install -y http://dev.mysql.com/get/mysql-community-release-el6-5.noarch.rpm
RUN yum install -y \
    epel-release \
    openssh-server \
    openssl-devel \
    readline-devel\
    zlib-devel \
    wget \
    curl \
    git \
    dtach \
    vim \
    hash-slinger \
    bzip2 \
    tar \
    ImageMagick \
    ImageMagick-devel \
    libffi-devel \
    libxslt-devel \
    python \
    mysql \
    mysql-devel \
    mysql-server \
    mysql-utilities \
&&  yum groupinstall "Development Tools" -y \
&&  yum install -y --enablerepo=epel \
    npm \
&&  yum clean all

# 言語とタイムゾーン
ENV LANG=ja_JP.UTF-8
RUN localedef -f UTF-8 -i ja_JP ja_JP.UTF-8
RUN \cp -p /usr/share/zoneinfo/Japan /etc/localtime \
&&  echo 'ZONE="Asia/Tokyo"' > /etc/sysconfig/clock

# Enable SSH login.
RUN sed -ri 's/^#PermitRootLogin yes/PermitRootLogin yes/' /etc/ssh/sshd_config \
&&  echo 'root:root' | chpasswd \
&&  ssh-keygen -t rsa -N "" -f /etc/ssh/ssh_host_rsa_key
EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]
