#! /bin/bash

action=$1

./build.sh

package=`cat ./configure.ac | sed -ne 's/^AC_INIT(\([^,]*\)\s*,.*/\1/gp'`

if [ -z "$action" -o "$action" = "inst" ] ; then
    
    #
    # Set up to emulate system installation process
    #
    
    echo
    echo Test installation ...
    echo
    
    destdir=inst
    
    rm -rf $destdir 2>&-
    
    ./configure --with-logdir=/var/log/oradba/exec-sql \
                --with-archivelogdir=/var/log/oradba/archive/exec-sql \
                --with-spooldir=/var/spool/oradba/exec-sql
    
    make install DESTDIR=$destdir || exit 1
    
fi


if [ -z "$action" -o "$action" = "test" ] ; then

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
                --with-liblsb=$destdir/lib/lsb --with-confdir=$destdir/etc/oradba \
                --with-logdir=$destdir/var/log/oradba/exec-sql \
                --with-archivelogdir=$destdir/var/log/oradba/archive/exec-sql \
                --with-spooldir=$destdir/var/spool/oradba/exec-sql \
                --with-statusdir=$destdir/var/lib/oradba
    
    make install || exit 1
    
    # Copy function libraries
    install -D ../oracle-base/orabase-functions $destdir/lib/lsb/orabase-functions
    
    # Run tests
    echo
    echo Run tests ...
    echo
    
fi
