class rtail::install_and_run {

  Exec {
    path => ['/usr/bin', '/bin', '/usr/sbin', '/usr/local/bin']
  }

  # Solve the 'nodejs-legacy' issue:
  # http://stackoverflow.com/questions/21168141/can-not-install-packages-using-node-package-manager-in-ubuntu
  
  $packages = ['nodejs', 'nodejs-legacy', 'npm']
  package {
    $packages: ensure => installed
  } ->

  exec { 'INSTALL_RTAIL':  
    command  => 'npm install -g rtail',
    creates  => "/usr/local/bin/rtail",
   # user     => "${wiremock_user_name}",
   # group    => "${wiremock_group_name}"
  } ->

  file { "COPY_INITD_RTAIL":
    path => "/etc/init.d/rtail",
    owner  => root,
    group  => root,
    mode   => 755,
    source => "/vagrant/provision/wso2-stack-srv/puppet/modules/rtail/files/rtail"
  } ->

  file { "CREATE_FOLDER_RTAIL": 
    path => "/opt/rtail",
    ensure => directory,
    owner  => "vagrant",
    group  => "vagrant",
    mode   => 0644
  } ->

  service { "ENABLE_SERVICE_RTAIL":
    name   => "rtail",
    ensure => true,
    enable => true
  } -> 

  file { "COPY_INITD_RTAILSENDLOGS":
    path => "/etc/init.d/rtailsendlogs",
    owner  => root,
    group  => root,
    mode   => 755,
    source => "/vagrant/provision/wso2-stack-srv/puppet/modules/rtail/files/rtailsendlogs"
  } -> 

  service { "ENABLE_SERVICE_RTAILSENDLOGS":
    name   => "rtailsendlogs",
    ensure => true,
    enable => true
  }

}