# Class: hsmysql::java
#
# This class installs the mysql-java-connector.
#
# Parameters:
#   [*package_name*]       - The name of the mysql java package.
#   [*package_ensure*]     - Ensure state for package. Can be specified as version.
# Actions:
#
# Requires:
#
# Sample Usage:
#
class hsmysql::java (
  $package_ensure = 'present',
  $package_name   = $hsmysql::java_package_name
) inherits hsmysql {

  package { 'mysql-connector-java':
    ensure => $package_ensure,
    name   => $package_name,
  }

}
