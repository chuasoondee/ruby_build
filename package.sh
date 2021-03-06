#!/bin/bash -e
set -x

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Install build dependencies
sudo yum groupinstall -y 'Development Tools' --skip-broken
sudo yum install -y openssl-devel zlib-devel gcc gcc-c++ autoconf readline-devel curl-devel expat-devel gettext-devel patch readline zlib libyaml-devel libffi-devel make bzip2
sudo yum install -y ruby rubygems ruby-devel libyaml-devel # install ruby-libs as dependency
sudo gem install fpm

# Download ruby source
curl -O http://cache.ruby-lang.org/pub/ruby/1.9/ruby-1.9.3-p484.tar.gz

tar xf ruby-1.9.3-p484.tar.gz -C $HOME

mkdir -p /tmp/installdir

pushd $HOME/ruby-1.9.3-p484
./configure --prefix=/usr && make install DESTDIR=/tmp/installdir
popd

fpm -s dir -t rpm -n ruby -v 1.9.3-p484 \
-C /tmp/installdir -p ruby-VERSION_ARCH.rpm \
-d "libyaml" \
--verbose \
usr/bin usr/lib usr/share/man usr/include
