FROM python:3.6-alpine3.8

MAINTAINER James Wanderi <wanderikinyanjui@gmail.com>

ENV GPG_KEY 97FC712E4C024BBEA48A61ED3A5CA953F73C700D
ENV PYTHON_VERSION 3.4.9

# sometimes ipv4.pool.sks-keyservers.net fails to connect
# so ping it and use the ip address instead
# export GPG_SERVER=$(ping -c 1 ipv4.pool.sks-keyservers.net| gawk -F'[()]' '/PING/{print $2}')


RUN set -ex \
	&& apk add --no-cache --virtual .fetch-deps \
		gnupg \
		tar \
		xz \
	\
	&& wget -O Python-$PYTHON_VERSION.tar.xz "https://www.python.org/ftp/python/${PYTHON_VERSION%%[a-z]*}/Python-$PYTHON_VERSION.tar.xz" \
	&& wget -O Python-$PYTHON_VERSION.tar.xz.asc "https://www.python.org/ftp/python/${PYTHON_VERSION%%[a-z]*}/Python-$PYTHON_VERSION.tar.xz.asc" \
	&& export GNUPGHOME="$(mktemp -d)" \
    && gpg --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys "$GPG_KEY" \
	&& gpg --batch --verify Python-$PYTHON_VERSION.tar.xz.asc Python-$PYTHON_VERSION.tar.xz \
	&& { command -v gpgconf > /dev/null && gpgconf --kill all || :; } \
	&& rm -rf "$GNUPGHOME" Python-$PYTHON_VERSION.tar.xz.asc \
	&& mkdir -p /usr/src/Python-$PYTHON_VERSION \
	&& tar -xJC /usr/src/Python-$PYTHON_VERSION --strip-components=1 -f Python-$PYTHON_VERSION.tar.xz \
	&& rm Python-$PYTHON_VERSION.tar.xz \
	\
	&& apk add --no-cache --virtual .build-deps  \
		bzip2-dev \
		coreutils \
		dpkg-dev dpkg \
		expat-dev \
		findutils \
		gcc \
		gdbm-dev \
		libc-dev \
		libffi-dev \
		libressl-dev \
		linux-headers \
		make \
		ncurses-dev \
		pax-utils \
		readline-dev \
		sqlite-dev \
		tcl-dev \
		tk \
		tk-dev \
		xz-dev \
		zlib-dev \
# add build deps before removing fetch deps in case there's overlap
	&& apk del .fetch-deps \
	\
	&& cd /usr/src/Python-$PYTHON_VERSION \
	&& gnuArch="$(dpkg-architecture --query DEB_BUILD_GNU_TYPE)" \
	&& ./configure \
		--build="$gnuArch" \
		--enable-loadable-sqlite-extensions \
		--enable-shared \
		--with-system-expat \
		--with-system-ffi \
		--with-ensurepip=install \
	&& make -j "$(nproc)" \
# set thread stack size to 1MB so we don't segfault before we hit sys.getrecursionlimit()
# https://github.com/alpinelinux/aports/commit/2026e1259422d4e0cf92391ca2d3844356c649d0
		EXTRA_CFLAGS="-DTHREAD_STACK_SIZE=0x100000" \
	&& make altinstall \
	\
	&& apk del .build-deps \
	\
	&& rm -rf /usr/src/Python-$PYTHON_VERSION \
	\
	&& python3.4 --version
