class activemq::copy_files (
  $server_name_array = $server_name_array,
  $bundle_name = $bundle_name,
  $user_name = $user_name,
  $group_name = $group_name
  ) { 

  Exec {
    path => ['/usr/bin', '/bin', '/usr/sbin']
  }
 
  $server_name_array.each |$value| {

    file { "CREATE_FOLDER_${value}": 
      path => "/opt/${value}",
      ensure => directory,
      owner  => "${user_name}",
      group  => "${group_name}",
      mode   => 0644
    } ->

    exec { "COPY_UNTARGZIPPED_FILES_IN_${value}":
      command => "cp -R /tmp/${bundle_name}/* /opt/${value}/.",
      cwd     => '/opt',
      creates => "/opt/${value}/bin/activemq.sh",
      user  => "${user_name}",
      group  => "${group_name}",
      timeout => 0
    }

  }

}