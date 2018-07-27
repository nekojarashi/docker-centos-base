FROM centos:centos7.5.1804
LABEL maintainer="y-okubo"

RUN curl -sS https://downloads.mariadb.com/MariaDB/mariadb_repo_setup -o /root/mariadb_repo_setup.sh \
&&  sh /root/mariadb_repo_setup.sh --mariadb-server-version=mariadb-10.3.8 \
&&  yum groupinstall "Development Tools" -y \
&&  yum install -y epel-release \
&&  yum install -y \
    https://rpmfind.net/linux/centos/6.10/os/x86_64/Packages/dtach-0.8-4.el6.x86_64.rpm \
    fontconfig \
    freetype \
    gdbm-devel \
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
    MariaDB-client \
    MariaDB-server \
    MariaDB-devel \
    MariaDB-shared \
    npm \
    openssh-server \
    openssl-devel \
    perl-Image-ExifTool \
    python \
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
RUN localedef -f UTF-8 -i ja_JP ja_JP.UTF-8
RUN cp -p /usr/share/zoneinfo/Japan /etc/localtime \
&&  echo 'ZONE="Asia/Tokyo"' > /etc/sysconfig/clock

# SSH ログイン有効化
RUN sed -ri 's/^#PermitRootLogin yes/PermitRootLogin yes/' /etc/ssh/sshd_config \
&&  echo 'root:root' | chpasswd \
&&  ssh-keygen -t rsa -N "" -f /etc/ssh/ssh_host_rsa_key
EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]