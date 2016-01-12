class wso2esb490::unzip_bundle (
  $wso2_bundle_name = $wso2_bundle_name,
  $wso2_user_name   = $wso2_user_name,
  $wso2_group_name  = $wso2_group_name
  ) {

  Exec {
    path => ['/usr/bin', '/bin', '/usr/sbin']
  }

  file { "GET_ZIP_${wso2_bundle_name}": 
    path   => "/tmp/${wso2_bundle_name}.zip",
    source => "/vagrant/_downloads/${wso2_bundle_name}.zip"
  } -> 
 
  exec { "EXTRACT_${wso2_bundle_name}": 
    command => "unzip /tmp/${wso2_bundle_name}.zip",
    cwd     => '/tmp',
    creates => "/tmp/${wso2_bundle_name}/bin/wso2server.sh",
    user  => "${wso2_user_name}",
    group  => "${wso2_group_name}",
    timeout => 0,
  } 

}