class wso2am::copy_files (
  $wso2_server_name_array = $wso2_server_name_array,
  $wso2_bundle_name = $wso2_bundle_name,
  $wso2_user_name = $wso2_user_name,
  $wso2_group_name = $wso2_group_name
  ) { 

  Exec {
    path => ['/usr/bin', '/bin', '/usr/sbin']
  }
 
  $wso2_server_name_array.each |$value| {

    file { "CREATE_FOLDER_${value}": 
      path => "/opt/${value}",
      ensure => directory,
      owner  => "${wso2_user_name}",
      group  => "${wso2_group_name}",
      mode   => 0644
    } ->

    exec { "COPY_UNZIPPED_FILES_IN_${value}":
      command => "cp -R /tmp/${wso2_bundle_name}/* /opt/${value}/.",
      cwd     => '/opt',
      creates => "/opt/${value}/bin/wso2server.sh",
      user  => "${wso2_user_name}",
      group  => "${wso2_group_name}",
      timeout => 0
    }

  }

}