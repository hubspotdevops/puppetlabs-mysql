class { 'hsmysql::server':
  config_hash => { 'root_password' => 'password', },
}
class { 'hsmysql::server::account_security': }
