# Class: hsmysql::ruby
#
# installs the ruby bindings for mysql
#
# Parameters:
#   [*package_ensure*]   - Ensure state for package. Can be specified as version.
#   [*package_name*]     - name of package
#   [*package_provider*] - The provider to use to install the package
#
# Actions:
#
# Requires:
#
# Sample Usage:
#
class hsmysql::ruby (
  $package_ensure   = 'present',
  $package_name     = $hsmysql::ruby_package_name,
  $package_provider = $hsmysql::ruby_package_provider
) inherits hsmysql {

  package{ 'ruby_mysql':
    ensure   => $package_ensure,
    name     => $package_name,
    provider => $package_provider,
  }

}
