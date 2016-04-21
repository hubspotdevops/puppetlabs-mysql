class { 'hsmysql::server':
  config_hash => {'root_password' => 'password'}
}
class { 'hsmysql::backup':
  backupuser     => 'myuser',
  backuppassword => 'mypassword',
  backupdir      => '/tmp/backups',
}
