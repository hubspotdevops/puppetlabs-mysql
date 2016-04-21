#This is a helper class to add a monitoring user to the database
#
class hsmysql::server::monitor (
  $mysql_monitor_username,
  $mysql_monitor_password,
  $mysql_monitor_hostname
) {

  Class['hsmysql::server'] -> Class['hsmysql::server::monitor']

  database_user{ "${mysql_monitor_username}@${mysql_monitor_hostname}":
    ensure        => present,
    password_hash => mysql_password($mysql_monitor_password),
  }

  database_grant { "${mysql_monitor_username}@${mysql_monitor_hostname}":
    privileges => [ 'process_priv', 'super_priv' ],
    require    => Database_user["${mysql_monitor_username}@${mysql_monitor_hostname}"],
  }

}
