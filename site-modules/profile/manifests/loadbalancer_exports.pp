class profile::loadbalancer_exports(
  $haproxy_options = 'check',
  $puppet_port     = '8140',
  $pcp_port        = '8142',
){

  @@haproxy::balancermember { "compile-${facts['networking']['fqdn']}":
    listening_service => 'compile',
    server_names      => $facts['networking']['fqdn'],
    ipaddresses       => $facts['networking']['ip'],
    ports             => $puppet_port,
    options           => $haproxy_options,
  }

  @@haproxy::balancermember { "pcp-${facts['networking']['fqdn']}":
    listening_service => 'pcp',
    server_names      => $facts['networking']['fqdn'],
    ipaddresses       => $facts['networking']['ip'],
    ports             => $pcp_port,
    options           => $haproxy_options,
  }
}
