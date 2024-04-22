class role::loadbalancer(
  $balance_type   = 'leastconn',
  $stats_username = 'puppet',
  $stats_password = 'puppet',
  $stats_port     = 9090,
){
  profile::loadbalancer { 'loadbalancer':
    balance_type   => $balance_type,
    stats_username => $stats_username,
    stats_password => $stats_password,
    stats_port     => $stats_port,
  }
}
