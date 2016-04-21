# Class: hsmysql::php
#
# This class installs the php libs for mysql.
#
# Parameters:
#   [*package_ensure*]   - Ensure state for package. Can be specified as version.
#   [*package_name*]     - The name of package
#
class hsmysql::php(
  $package_ensure = 'present',
  $package_name   = $hsmysql::php_package_name
) inherits hsmysql {

  package { 'php-mysql':
    ensure => $package_ensure,
    name   => $package_name,
  }

}
