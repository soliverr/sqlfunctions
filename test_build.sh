#! /bin/bash

./build.sh

package=`cat ./configure.ac | sed -ne 's/^AC_INIT(\([^,]*\)\s*,.*/\1/gp'`

#
# Set up to test scripts locally
#

destdir=`pwd`/test

rm -rf $destdir 2>&-

./configure --prefix=$destdir/usr --localstatedir=$destdir/var \
            --sysconfdir=$destdir/etc --datadir=$destdir/share/$package \
            --with-liblsb=$destdir/lib/lsb

make install || exit 1


#
# Set up to emulate system installation process
#

destdir=inst

rm -rf $destdir 2>&-

./configure

make install DESTDIR=$destdir || exit 1
