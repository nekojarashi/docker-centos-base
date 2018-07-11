FROM centos:centos7.5.1804
LABEL maintainer="y-okubo"

# MariaDB
RUN curl -sS https://downloads.mariadb.com/MariaDB/mariadb_repo_setup -o /root/mariadb_repo_setup.sh && \
    sh /root/mariadb_repo_setup.sh --mariadb-server-version=mariadb-10.3.8

RUN yum install -y \
    bzip2 \
    curl \
    dtach \
    epel-release \
    fontconfig \
    freetype \
    gdbm-devel \
    git \
    hash-slinger \
    ImageMagick \
    ImageMagick-devel \
    libcurl-devel \
    libexif \
    libexif-devel \
    libffi-devel \
    libfontconfig.so.1 \
    libfreetype.so.6 \
    libsndfile-devel \
    libstdc++.so.6 \
    libxslt-devel \
    libyaml-devel \
    openssh-server \
    openssl-devel \
    python \
    readline-devel \
    sqlite-devel \
    sudo httpd-devel \
    tar \
    vim \
    wget \
    zlib-devel \
&&  yum groupinstall "Development Tools" -y \
&&  yum install -y --enablerepo=epel \
    npm \
&&  yum install -y \
    MariaDB-client \
    MariaDB-server \
    MariaDB-devel \
    MariaDB-shared \
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