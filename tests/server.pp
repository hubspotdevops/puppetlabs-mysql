class { 'hsmysql::server':
  config_hash => { 'root_password' => 'password', },
}
