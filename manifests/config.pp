# Class: hsmysql::config
#
# Parameters:
#   [*bind_address*]      - address to bind service.
#   [*config_file*]       - my.cnf configuration file path.
#   [*datadir*]           - path to datadir.
#   [*default_engine]     - configure a default table engine
#   [*etc_root_password*] - whether to save /etc/my.cnf.
#   [*log_error]          - path to mysql error log
#   [*old_root_password*] - previous root user password,
#   [*port*]              - port to bind service.
#   [*restart]            - whether to restart mysqld (true/false)
#   [*root_group]         - use specified group for root-owned files
#   [*root_password*]     - root user password.
#   [*service_name*]      - mysql service name.
#   [*socket*]            - mysql socket.
#   [*ssl]                - enable ssl
#   [*ssl_ca]             - path to ssl-ca
#   [*ssl_cert]           - path to ssl-cert
#   [*ssl_key]            - path to ssl-key
#
#
# Actions:
#
# Requires:
#
#   class hsmysql::server
#
# Usage:
#
#   class { 'hsmysql::config':
#     root_password => 'changeme',
#     bind_address  => $::ipaddress,
#   }
#
class hsmysql::config(
  $bind_address      = $hsmysql::bind_address,
  $config_file       = $hsmysql::config_file,
  $datadir           = $hsmysql::datadir,
  $default_engine    = $hsmysql::default_engine,
  $etc_root_password = $hsmysql::etc_root_password,
  $log_error         = $hsmysql::log_error,
  $pidfile           = $hsmysql::pidfile,
  $port              = $hsmysql::port,
  $purge_conf_dir    = $hsmysql::purge_conf_dir,
  $restart           = $hsmysql::restart,
  $root_group        = $hsmysql::root_group,
  $root_password     = $hsmysql::root_password,
  $old_root_password = $hsmysql::old_root_password,
  $service_name      = $hsmysql::service_name,
  $socket            = $hsmysql::socket,
  $ssl               = $hsmysql::ssl,
  $ssl_ca            = $hsmysql::ssl_ca,
  $ssl_cert          = $hsmysql::ssl_cert,
  $ssl_key           = $hsmysql::ssl_key
) inherits hsmysql {

  File {
    owner  => 'root',
    group  => $root_group,
    mode   => '0400',
    notify    => $restart ? {
      true => Exec['mysqld-restart'],
      false => undef,
    },
  }

  if $ssl and $ssl_ca == undef {
    fail('The ssl_ca parameter is required when ssl is true')
  }

  if $ssl and $ssl_cert == undef {
    fail('The ssl_cert parameter is required when ssl is true')
  }

  if $ssl and $ssl_key == undef {
    fail('The ssl_key parameter is required when ssl is true')
  }

  # This kind of sucks, that I have to specify a difference resource for
  # restart.  the reason is that I need the service to be started before mods
  # to the config file which can cause a refresh
  exec { 'mysqld-restart':
    command     => "service ${service_name} restart",
    logoutput   => on_failure,
    refreshonly => true,
    path        => '/sbin/:/usr/sbin/:/usr/bin/:/bin/',
  }

  # manage root password if it is set
  if $root_password != 'UNSET' {
    case $old_root_password {
      '':      { $old_pw='' }
      default: { $old_pw="-p'${old_root_password}'" }
    }

    exec { 'set_mysql_rootpw':
      command   => "mysqladmin -u root ${old_pw} password '${root_password}'",
      logoutput => true,
      unless    => "mysqladmin -u root -p'${root_password}' status > /dev/null",
      path      => '/usr/local/sbin:/usr/bin:/usr/local/bin',
      notify    => $restart ? {
        true  => Exec['mysqld-restart'],
        false => undef,
      },
      require   => File['/etc/mysql/conf.d'],
    }

    file { '/root/.my.cnf':
      content => template('hsmysql/my.cnf.pass.erb'),
      require => Exec['set_mysql_rootpw'],
    }

    if $etc_root_password {
      file{ '/etc/my.cnf':
        content => template('hsmysql/my.cnf.pass.erb'),
        require => Exec['set_mysql_rootpw'],
      }
    }
  } else {
    file { '/root/.my.cnf':
      ensure  => present,
    }
  }

  file { '/etc/mysql':
    ensure => directory,
    mode   => '0755',
  }
  file { '/etc/mysql/conf.d':
    ensure  => directory,
    mode    => '0755',
    recurse => $purge_conf_dir,
    purge   => $purge_conf_dir,
  }
  file { $config_file:
    content => template('hsmysql/my.cnf.erb'),
    mode    => '0644',
  }

}
