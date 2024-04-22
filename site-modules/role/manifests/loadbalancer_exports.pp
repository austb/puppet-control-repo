class role::loadbalancer_exports(
  $haproxy_options = 'check',
  $puppet_port     = '8140',
  $pcp_port        = '8142',
){

  profile::loadbalancer_exports { 'loadbalancer_exports':
    haproxy_options => $haproxy_options,
    puppet_port     => $puppet_port,
    pcp_port        => $pcp_port,
  }
}
