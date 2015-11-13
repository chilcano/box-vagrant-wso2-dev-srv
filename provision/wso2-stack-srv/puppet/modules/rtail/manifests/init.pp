class rtail (
  $server_name_array = undef,
  $rtail_ip_address = undef,
  $rtail_port_http = undef,
  $rtail_port_udp  = undef
  ) {
  
  if $server_name_array {
    fail ("Parameter server_name_array is mandatory.")
  }
  if $rtail_ip_address {
    fail ("Parameter rtail_ip_address is mandatory.")
  }
  if $rtail_port_http {
    fail ("Parameter rtail_port_http is mandatory.")
  }
  if $rtail_port_udp {
    fail ("Parameter rtail_port_udp is mandatory.")
  }

}