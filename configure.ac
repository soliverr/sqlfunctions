AC_PREREQ(2.61)
AC_INIT(oradba-sqlfunctions, 2.1, soliverr@gmail.com)

AC_MSG_CHECKING(PACKAGE_NAME)
AC_MSG_RESULT($PACKAGE_NAME)

dnl
dnl Common path  for all oradba packages
dnl

dnl Default prefix
AC_PREFIX_DEFAULT('/usr')
if test "$prefix" != "NONE" ; then
    AC_MSG_CHECKING(prefix)
    AC_MSG_RESULT($prefix)
fi

if test "x$localstatedir" = 'x${prefix}/var' ; then
    dnl AC_MSG_NOTICE("Setting default LOCALSTATEDIR to '/var'")
    AC_SUBST(localstatedir, '/var')
fi
AC_MSG_CHECKING(localstatedir)
AC_MSG_RESULT($localstatedir)

if test "x$datadir" = 'x${datarootdir}' ; then
    AC_SUBST(datadir, '${datarootdir}/${PACKAGE_NAME}')
fi
AC_MSG_CHECKING(datadir)
AC_MSG_RESULT($datadir)

if test "x$sysconfdir" = 'x${prefix}/etc' ; then
    AC_SUBST(sysconfdir, '/etc')
fi
AC_MSG_CHECKING(sysconfdir)
AC_MSG_RESULT($sysconfdir)


dnl
dnl Additional path for oradba packages
dnl

dnl --with-liblsb
liblsb='/lib/lsb'
AC_MSG_CHECKING(liblsb)
AC_ARG_WITH(liblsb,
[  --with-liblsb=DIR       Directory for system wide functions files [/lib/lsb] ],
[ case "$withval" in
    no)
        AC_MSG_ERROR(Need liblsb)
        ;;
    [[\\/$]]* | ?:[[\\/]]* )
        liblsb="$withval"
        ;;
    yes | *)
        AC_MSG_ERROR([expected an absolute directory name for --with-liblsb: $withval])
        ;;
  esac ]
)
AC_SUBST(liblsb)
AC_MSG_RESULT($liblsb)

dnl --with-logdir
logdir='${localstatedir}/log/oracle/${PACKAGE_NAME}'
AC_MSG_CHECKING(logdir)
AC_ARG_WITH(logdir,
[  --with-logdir=DIR       Directory for logfiles [LOCALSTATEDIR/log/oracle/PACKAGE_NAME] ],
[ case "$withval" in
    no)
        AC_MSG_ERROR(Need logdir)
        ;;
    [[\\/$]]* | ?:[[\\/]]* )
        logdir="$withval"
        ;;
    yes | *)
        AC_MSG_ERROR([expected an absolute directory name for --with-logdir: $withval])
        ;;
  esac ]
)
AC_SUBST(logdir)
AC_MSG_RESULT($logdir)

dnl --with-confdir
confdir='${sysconfdir}/oracle'
AC_MSG_CHECKING(confdir)
AC_ARG_WITH(confdir,
[  --with-confdir=DIR      Directory for config files [SYSCONFDIR/oracle] ],
[ case "$withval" in
    no)
        AC_MSG_ERROR(Need confdir)
        ;;
    [[\\/$]]* | ?:[[\\/]]* )
        confdir="$withval"
        ;;
    yes | *)
        AC_MSG_ERROR([expected an absolute directory name for --with-confdir: $withval])
        ;;
  esac ]
)
AC_SUBST(confdir)
AC_MSG_RESULT($confdir)

dnl --with-spooldir
spooldir='${localstatedir}/spool/oracle/${PACKAGE_NAME}'
AC_MSG_CHECKING(spooldir)
AC_ARG_WITH(spooldir,
[  --with-spooldir=DIR     Directory for spool files [LOCALSTATEDIR/spool/oracle/PACKAGE_NAME] ],
[ case "$withval" in
    no)
        AC_MSG_ERROR(Need confdir)
        ;;
    [[\\/$]]* | ?:[[\\/]]* )
        spooldir="$withval"
        ;;
    yes | *)
        AC_MSG_ERROR([expected an absolute directory name for --with-spooldir: $withval])
        ;;
  esac ]
)
AC_SUBST(spooldir)
AC_MSG_RESULT($spooldir)

AC_CONFIG_FILES([Makefile logrotate.conf crontab.daily])
AC_OUTPUT([build_expand.sh exec_sql oradba-crontab sql-functions])

