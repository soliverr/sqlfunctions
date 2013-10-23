#! /bin/bash

./build.sh

package=`cat ./configure.ac | sed -ne 's/^AC_INIT(\([^,]*\)\s*,.*/\1/gp'`

#
#
# Set up to emulate system installation process
#

echo
echo Test installation ...
echo

destdir=inst

rm -rf $destdir 2>&-

./configure --with-confdir=/etc/oracle/oradba \
            --with-logdir=/var/log/oracle/oradba-exec-sql \
            --with-archivelogdir=/var/log/oracle/archive/oradba-exec-sql \
            --with-spooldir=/var/spool/oracle/oradba-exec-sql 

make install DESTDIR=$destdir || exit 1

#
# Set up to test scripts locally
#

echo
echo Setup test units ...
echo

destdir=`pwd`/test

rm -rf $destdir 2>&-

./configure --prefix=$destdir/usr --localstatedir=$destdir/var \
            --sysconfdir=$destdir/etc --datadir=$destdir/share/$package \
            --with-liblsb=$destdir/lib/lsb --with-confdir=$destdir/etc/oracle/oradba \
            --with-logdir=$destdir/var/log/oracle/oradba-exec-sql \
            --with-archivelogdir=$destdir/var/log/oracle/archive/oradba-exec-sql \
            --with-spooldir=$destdir/var/spool/oracle/oradba-exec-sql

make install || exit 1

# Copy function libraries
install -D ../oracle-base/orabase-functions $destdir/lib/lsb/orabase-functions

# Run tests
echo
echo Run tests ...
echo


