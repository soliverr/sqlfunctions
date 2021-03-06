
# FIXME: get from configure.ac 
%define pkg_name    sqlfunctions

Summary   : Functions to maintain Oracle RDBMS.
Summary(ru_RU.UTF-8): Полезные функции для скриптов обслуживания СУБД Oracle.
Name      : oradba-%pkg_name
Version   : 2.2
Release   : 1
Group     : admin

Packager  : Kryazhevskikh Sergey, <soliverr@gmail.com>
License   : GPLv2
URL       : http://sourceforge.net/projects/oracledba

Requires  : logrotate, oracle-base
#Suggests  : opr, oracle-sysvinit, oracle-client, timelimit
BuildArch : noarch

Source    : %name-%version.tar.gz
BuildRoot : %_tmppath/%name-%version

%define pkg_build_dir   %_builddir/%name-%version
%define pkg_functions   %pkg_build_dir/_pkg-functions
%define logdir          /var/log/oradba/exec-sql
%define archivelogdir   /var/log/oradba/archive/exec-sql
%define spooldir        /var/spool/oradba/exec-sql

%description
Some usefull functions and scripts for Oracle RDBMS maintenance:
 oradba-crontab  - maintain crontab jobs
 oradba-exec-sql - execute SQL-scripts. Usefull to run as cron job
.

%description -l ru_RU.UTF-8
Данный пакет содержит функции, которые полезно использовать в
shell-скриптах поддержки и обслуживания СУБД Oracle:
 oradba-crontab  - обслуживание пользовательских задач crontab
 oradba-exec-sql - исполнение SQL, удобно при работе из cron
.

%prep

%setup
./build.sh
./configure --with-logdir=%logdir --with-archivelogdir=%archivelogdir --with-spooldir=%spooldir

%build

%install
[ "%buildroot" != "/" ] && rm -rf %buildroot

%__make install DESTDIR=$RPM_BUILD_ROOT/

# Change crontab
%__sed --in-place -e 's/--report //' $RPM_BUILD_ROOT/etc/oradba/cron.d/oradba

%pre
%include %pkg_functions
  
if [ $1 -eq 1 ] ; then
  action=install
else
  action=upgrade
fi

preinst "redhat" "$action"


%preun
%include %pkg_functions

if [ $1 -eq 0 ] ; then
  action=remove
else
  action=upgrade
fi

prerm "redhat" "$action"


%post
%include %pkg_functions

if [ $1 -eq 1 ] ; then
  action=configure
else
  action=upgrade
fi

postinst "redhat" "$action"


%postun
%include %pkg_functions

if [ $1 -eq 0 ] ; then
  action=purge
else
  action=upgrade
fi

postrm "redhat" "$action"


%clean
[ "%{buildroot}" != "/" ] && rm -rf %{buildroot}
[ "%{pkg_build_dir}" != "/" ] && rm -rf %{pkg_build_dir}

%files
%defattr(-,root,root)
%doc /usr/share/doc
%doc /usr/share/man/man1/*
%doc /usr/share/man/ru/man1/*
%dir %attr(2770,oracle,oinstall) %logdir
%dir %attr(2770,oracle,oinstall) %archivelogdir
%dir %attr(2770,oracle,oinstall) %spooldir
%dir %attr(2770,oracle,oinstall) /var/lib/oradba
%dir %attr(2775 oracle,oinstall) /etc/oradba
%dir %attr(2775 oracle,oinstall) /etc/oradba/cron.d
%dir %attr(2775 oracle,oinstall) /etc/oradba/cron.daily
%dir %attr(2775 oracle,oinstall) /etc/oradba/logrotate.d
%config(noreplace) %attr(664,oracle,oinstall) /etc/oradba/*.conf
%config(noreplace) %attr(664,oracle,oinstall) /etc/oradba/*.def
%config %attr(664,oracle,oinstall) /etc/oradba/logrotate.d/*
%config %attr(664,oracle,oinstall) /etc/oradba/cron.d/*
%config %attr(755,oracle,oinstall) /etc/oradba/cron.daily/*
/lib/lsb/*
/usr/bin/*

%changelog
* Thu Nov 14 2013 Kryazhevskikh Sergey <soliverr@gmail.com> - 2.2-1  15:40:29 +0600
- Public release of package
