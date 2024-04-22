class profile::loadbalancer(
  $balance_type   = 'roundrobin',
  $stats_username = 'puppet',
  $stats_password = 'puppet',
  $stats_port     = 9090,
){
  class { 'haproxy':
    global_options => {
      'log'     => "${facts['networking']['ip']} local0",
      'chroot'  => '/var/lib/haproxy',
      'pidfile' => '/var/run/haproxy.pid',
      'maxconn' => '40000',
      'daemon'  => '',
      'stats'   => 'socket /var/lib/haproxy/stats',
    },
  }

  haproxy::listen { 'stats':
    ipaddress        => '*',
    ports            => "${stats_port}",
    collect_exported => false,
    options          => {
      'mode'  => 'http',
      'stats' => ['uri /', "auth ${stats_username}:${stats_password}"]
    },
  }

  haproxy::listen { "compile":
    ipaddress        => '*',
    ports            => '8140',
    collect_exported => true,
    options          => {
      'balance'      => $balance_type,
      'maxconn'      => '4000',
    },
  }

  haproxy::listen { "pcp":
    ipaddress        => '*',
    ports            => '8142',
    collect_exported => true,
    options          => {
      'balance'      => $balance_type,
      'maxconn'      => '4000',
      'timeout'      => 'tunnel 15m',
    },
  }
}
