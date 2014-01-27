## Running fpm on a compiled ruby folder

### Maybe not required
sudo yum groupinstall 'Development Tools' --skip-broken
> sudo yum install libyaml not required since 

sudo yum install ruby
sudo yum install ruby-gems
sudo yum install ruby-libs
sudo yum install ruby-devel

sudo gem update --system
sudo gem install fpm

curl -O http://cache.ruby-lang.org/pub/ruby/1.9/ruby-1.9.3-p484.tar.gz
tar zxvf ruby-1.9.4-p484.tar.gz

mkdir -p /tmp/installdir

pushd $HOME/ruby-1.9.3-p484
./configure --prefix=/usr && make install DESTDIR=/tmp/installdir
popd

fpm -s dir -t rpm -n ruby -v 1.9.3-p484 \
-C /tmp/installdir -p ruby-VERSION_ARCH.rpm \
-d "libyaml" \
--verbose \
usr/bin usr/lib usr/share/man usr/include
