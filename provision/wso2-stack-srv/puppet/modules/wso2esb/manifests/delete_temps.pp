class wso2esb::delete_temps (
  $wso2esb_bundle_name = $wso2esb_bundle_name,
  $wso2_user_name      = $wso2_user_name,
  $wso2_group_name     = $wso2_group_name  
  ) {

  Exec {
    path => ['/usr/bin', '/bin', '/usr/sbin']
  }
 
  exec { "DELETE_TMP_${wso2esb_bundle_name}":
    command => "rm -rf /tmp/${wso2esb_bundle_name}*",
    cwd     => '/tmp',
    creates => "/tmp/${wso2esb_bundle_name}.deleted.ok",
    user  => "${wso2_user_name}",
    group  => "${wso2_group_name}",
    timeout => 0,
  }

}