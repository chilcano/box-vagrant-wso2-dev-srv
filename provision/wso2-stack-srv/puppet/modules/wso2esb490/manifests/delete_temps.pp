class wso2esb490::delete_temps (
  $wso2_bundle_name = $wso2_bundle_name,
  $wso2_user_name      = $wso2_user_name,
  $wso2_group_name     = $wso2_group_name  
  ) {

  Exec {
    path => ['/usr/bin', '/bin', '/usr/sbin']
  }
 
  exec { "DELETE_TMP_${wso2_bundle_name}":
    command => "rm -rf /tmp/${wso2_bundle_name}*",
    cwd     => '/tmp',
    creates => "/tmp/${wso2_bundle_name}.deleted.ok",
    user  => "${wso2_user_name}",
    group  => "${wso2_group_name}",
    timeout => 0,
  }

}