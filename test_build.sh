#! /bin/bash

./build.sh

destdir=test

package=`cat ./configure.ac | sed -ne 's/^AC_INIT(\([^,]*\)\s*,.*/\1/gp'`

rm -rf $destdir

# Configure for local path to test scripts
./configure --prefix=`pwd`/$destdir/usr --localstatedir=`pwd`/$destdir/var \
            --sysconfdir=`pwd`/$destdir/etc --datadir=`pwd`/$destdir/share/$package \
            --with-liblsb=`pwd`/$destdir/lib/lsb

make install || exit 1

