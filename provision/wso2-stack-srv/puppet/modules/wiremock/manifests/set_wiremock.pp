class wiremock::set_wiremock (
  $wiremock_bundle_name = $wiremock_bundle_name,
  $wiremock_server_name = $wiremock_server_name,
  $wiremock_user_name   = $wiremock_user_name,
  $wiremock_group_name  = $wiremock_group_name
  ) {

  Exec {
    path => ['/usr/bin', '/bin', '/usr/sbin']
  }

  file { "CREATE_FOLDER_${wiremock_server_name}":
    path   => "/opt/${wiremock_server_name}",
    ensure => directory,
    owner  => "${wiremock_user_name}",
    group  => "${wiremock_group_name}",
    mode   => 0644,
  } ->

  file { "COPY_BUNDLE_IN_${wiremock_server_name}":
    path   => "/opt/${wiremock_server_name}/${wiremock_bundle_name}",
    source => "/vagrant/_downloads/${wiremock_bundle_name}"
  } -> 

  file { "COPY_INITD_${wiremock_server_name}":
    path => "/etc/init.d/${wiremock_server_name}",
    owner  => root,
    group  => root,
    mode   => 755,
    source => "/vagrant/provision/wso2-stack-srv/puppet/modules/wiremock/files/${wiremock_server_name}",
  } ->

  service { "ENABLE_INITD_${wiremock_server_name}":
    name   => "${wiremock_server_name}",
    ensure => true,
    enable => true
  }

}