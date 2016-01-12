class activemq::setup_broker (
  $server_name_array = $server_name_array
  ) {

  Exec {
    path => ['/usr/bin', '/bin', '/usr/sbin']
  }

  #$server_name_array.each |$value| {
  #
  #  file { "COPY_ACTIVEMQ_INITD_IN_${value}": 
  #    path => "/etc/init.d/${value}",
  #    owner  => root,
  #    group  => root,
  #    mode   => 755,
  #    source => "/opt/${value}/bin/${value}"
  #  }
  #
  #}

}