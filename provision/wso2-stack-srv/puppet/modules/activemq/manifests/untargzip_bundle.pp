class activemq::untargzip_bundle (
  $bundle_name = $bundle_name,
  $user_name   = $user_name,
  $group_name  = $group_name
  ) {

  Exec {
    path => ['/usr/bin', '/bin', '/usr/sbin']
  }

  file { "GET_TARGZIP_${bundle_name}": 
    path   => "/tmp/${bundle_name}",
    source => "/vagrant/_downloads/${bundle_name}"
  } -> 
 
  exec { "EXTRACT_${bundle_name}": 
    command => "tar -zxf /tmp/${bundle_name}",
    cwd     => '/tmp',
    creates => "/tmp/${bundle_name}/bin/activemq.sh",
    user  => "${user_name}",
    group  => "${group_name}",
    timeout => 0,
  } 

}