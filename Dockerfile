# Declare the alpine linux base image
FROM alpine:3.10

MAINTAINER Andy Manson

# Set Environment variable(s) for q and add to Unix PATH
ENV QHOME /q
ENV PATH ${PATH}:${QHOME}/l32/

# Refresh / Update the base image using alpine's package manager "apk", and binutils to allow use of e.g. tar/ar while building
RUN apk update \
&& apk add --update binutils

# Download & unpack "libc6-i386 for amd64" debian package (this is required for "q" to run on a 64-bit OS).
# For information view: https://packages.debian.org/jessie/amd64/libc6-i386/
RUN LIBC32_DEB=libc6-i386_2.19-18+deb8u10_amd64.deb \
  && wget "http://ftp.us.debian.org/debian/pool/main/g/glibc/libc6-i386_2.19-18+deb8u10_amd64.deb" \
  && echo "aeee7bebb8e957e299c93c884aba4fa9  $LIBC32_DEB" | md5sum -c - \
  && ar p $LIBC32_DEB data.tar.xz | unxz | tar -x \
  && rm -rf $LIBC32_DEB /usr/share/doc/libc6-i386 /usr/lib32/gconv /usr/share/lintian \
	&& apk del binutils \
	&& rm -rf /var/lib/apk/lists/*

# Ensure we have your our zipped version of q for linux in the same folder as this Dockerfile, and copy it
COPY q.zip .
COPY entrypoint.sh /entrypoint.sh

# Unzip q for linux to the root ('/'), change file / directory permissions, finally clean up by removing unused folders / utilities
RUN unzip /q.zip \
&& chown -R root /q; chmod 755 /q/l32/q \
&& rm /q.zip \
# NB Mac OSX users - the unzip process may have created a __MACOSX directory - it can be safely deleted by uncommenting the line below:
&& rm -rf /__MACOSX \
&& apk del binutils


WORKDIR /
EXPOSE  5001
