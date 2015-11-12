class wso2esb::copy_files (
  $wso2esb_server_name_array = $wso2esb_server_name_array,
  $wso2esb_bundle_name = $wso2esb_bundle_name,
  $wso2_user_name = $wso2_user_name,
  $wso2_group_name = $wso2_group_name
  ) { 

  Exec {
    path => ['/usr/bin', '/bin', '/usr/sbin']
  }
 
  ## If the next line doesn't work, try it again before enabling 'future parser' in Puppet of your VM
  $wso2esb_server_name_array.each |$value| {

    file { "CREATE_FOLDER_${value}": 
      path => "/opt/${value}",
      ensure => directory,
      owner  => "${wso2_user_name}",
      group  => "${wso2_group_name}",
      mode   => 0644,
      #notify  => File['${wso2esb_server_name}']
    } ->

    exec { "COPY_UNZIPPED_FILES_IN_${value}":
      command => "cp -R /tmp/${wso2esb_bundle_name}/* /opt/${value}/.",
      cwd     => '/opt',
      creates => "/opt/${value}/bin/wso2server.sh",
      user  => "${wso2_user_name}",
      group  => "${wso2_group_name}",
      timeout => 0,
    }

  }

}