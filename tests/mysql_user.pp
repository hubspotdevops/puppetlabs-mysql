$mysql_root_pw = 'password'

class { 'hsmysql::server':
  config_hash => {
    root_password => 'password',
  }
}

database_user{ 'redmine@localhost':
  ensure        => present,
  password_hash => mysql_password('redmine'),
  require       => Class['hsmysql::server'],
}

database_user{ 'dan@localhost':
  ensure        => present,
  password_hash => mysql_password('blah')
}

database_user{ 'dan@%':
  ensure        => present,
  password_hash => mysql_password('blah'),
}
