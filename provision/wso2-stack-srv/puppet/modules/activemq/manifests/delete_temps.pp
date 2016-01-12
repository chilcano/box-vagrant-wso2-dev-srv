class activemq::delete_temps (
  $bundle_name = $bundle_name,
  $user_name   = $user_name,
  $group_name  = $group_name  
  ) {

  Exec {
    path => ['/usr/bin', '/bin', '/usr/sbin']
  }
 
  exec { "DELETE_TMP_${bundle_name}":
    command => "rm -rf /tmp/${bundle_name}*",
    cwd     => '/tmp',
    creates => "/tmp/${bundle_name}.deleted.ok",
    user  => "${user_name}",
    group  => "${group_name}",
    timeout => 0,
  }

}