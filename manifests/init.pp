# Class: mysql
#
#   This class installs mysql client software.
#
# Parameters:
#
# [*basedir*]               - The base directory mysql uses
#
# [*bind_address*]          - The IP mysql binds to.
#
# [*client_package_name*]   - The name of the mysql client package.
#
# [*config_file*]           - The location of the server config file
#
# [*config_template*]       - The template to use to generate my.cnf.
#
# [*datadir*]               - The directory MySQL's datafiles are stored
#
# [*default_engine*]        - The default engine to use for tables
#
# [*etc_root_password*]     - Whether or not to add the mysql root password to /etc/my.cnf
#
# [*java_package_name*]     - The name of the java package containing the java connector
#
# [*log_error*]             - Where to log errors
#
# [*manage_service*]        - Boolean dictating if hsmysql::server should manage the service
#
# [*old_root_password*]     - Previous root user password,
#
# [*package_ensure*]        - ensure value for packages.
#
# [*package_name*]          - legacy parameter used to specify the client package. Should not be used going forward
#
# [*php_package_name*]      - The name of the phpmysql package to install
#
# [*pidfile*]               - The location mysql will expect the pidfile to be, and will put it when starting the service.
#
# [*port*]                  - The port mysql listens on
#
# [*purge_conf_dir*]        - Value fed to recurse and purge parameters of the /etc/mysql/conf.d resource
#
# [*python_package_name*]   - The name of the python mysql package to install
#
# [*restart*]               - Whether to restart mysqld (true/false)
#
# [*root_group*]            - Use specified group for root-owned files
#
# [*root_password*]         - The root MySQL password to use
#
# [*ruby_package_name*]     - The name of the ruby mysql package to install
#
# [*ruby_package_provider*] - The installation suite to use when installing the ruby package.
#                             FreeBSD Does not use this.
#
# [*server_package_ensure*] - ensure value for server packages.
#
# [*server_package_name*]   - The name of the server package to install
#
# [*service_provider*]      - Sets the service provider to upstart on Ubuntu systems for hsmysql::server.
#
# [*service_name*]          - The name of the service to start
#
# [*socket*]                - The location of the MySQL server socket file
#
# [*ssl*]                   - Whether or not to enable ssl
#
# [*ssl_ca*]                - The location of the SSL CA Cert
#
# [*ssl_cert*]              - The location of the SSL Certificate to use
#
# [*ssl_key*]               - The SSL key to use
#
# Actions:
#
# Requires:
#
# Sample Usage:
#
class mysql(
  $basedir               = $hsmysql::params::basedir,
  $bind_address          = $hsmysql::params::bind_address,
  $client_package_name   = $hsmysql::params::client_package_name,
  $config_file           = $hsmysql::params::config_file,
  $config_template       = $hsmysql::params::config_template,
  $datadir               = $hsmysql::params::datadir,
  $default_engine        = $hsmysql::params::default_engine,
  $etc_root_password     = $hsmysql::params::etc_root_password,
  $java_package_name     = $hsmysql::params::java_package_name,
  $log_error             = $hsmysql::params::log_error,
  $manage_service        = $hsmysql::params::manage_service,
  $old_root_password     = $hsmysql::params::old_root_password,
  $package_ensure        = $hsmysql::params::package_ensure,
  $package_name          = undef,
  $php_package_name      = $hsmysql::params::php_package_name,
  $pidfile               = $hsmysql::params::pidfile,
  $port                  = $hsmysql::params::port,
  $purge_conf_dir        = $hsmysql::params::purge_conf_dir,
  $python_package_name   = $hsmysql::params::python_package_name,
  $restart               = $hsmysql::params::restart,
  $root_group            = $hsmysql::params::root_group,
  $root_password         = $hsmysql::params::root_password,
  $ruby_package_name     = $hsmysql::params::ruby_package_name,
  $ruby_package_provider = $hsmysql::params::ruby_package_provider,
  $server_package_name   = $hsmysql::params::server_package_name,
  $service_name          = $hsmysql::params::service_name,
  $service_provider      = $hsmysql::params::service_provider,
  $socket                = $hsmysql::params::socket,
  $ssl                   = $hsmysql::params::ssl,
  $ssl_ca                = $hsmysql::params::ssl_ca,
  $ssl_cert              = $hsmysql::params::ssl_cert,
  $ssl_key               = $hsmysql::params::ssl_key
) inherits hsmysql::params{
  if $package_name {
    warning('Using $package_name has been deprecated in favor of $client_package_name and will be removed.')
    $client_package_name_real = $package_name
  } else {
    $client_package_name_real = $client_package_name
  }
  package { 'mysql_client':
    ensure => $package_ensure,
    name   => $client_package_name_real,
  }

}
