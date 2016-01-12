class wso2esb {

  class { '::wso2esb::unzip_bundle':
    wso2esb_bundle_name => 'wso2esb-4.8.1',
    wso2_user_name => 'vagrant',
    wso2_group_name => 'vagrant'
  } ->

  class { '::wso2esb::copy_files':
    wso2esb_server_name_array => ['wso2esb01a', 'wso2esb02a'],
    wso2esb_bundle_name => 'wso2esb-4.8.1',
    wso2_user_name => 'vagrant',
    wso2_group_name => 'vagrant'
  } ->

  class { '::wso2esb::setup_carbon':
    wso2esb_server_name_array => ['wso2esb01a', 'wso2esb02a'],
  } ->

  class { '::wso2esb::delete_temps':
    wso2esb_bundle_name => 'wso2esb-4.8.1',
    wso2_user_name => 'vagrant',
    wso2_group_name => 'vagrant'
  } 

}

class wso2am {

  class { '::wso2am::unzip_bundle':
    wso2_bundle_name => 'wso2am-1.8.0',
    wso2_user_name => 'vagrant',
    wso2_group_name => 'vagrant'
  } -> 

  class { '::wso2am::copy_files':
    wso2_server_name_array => ['wso2am02a'],
    wso2_bundle_name => 'wso2am-1.8.0',
    wso2_user_name => 'vagrant',
    wso2_group_name => 'vagrant'
  } -> 

  class { '::wso2am::setup_carbon':
    wso2_server_name_array => ['wso2am02a'],
  } -> 

  class { '::wso2am::delete_temps':
    wso2_bundle_name => 'wso2am-1.8.0',
    wso2_user_name => 'vagrant',
    wso2_group_name => 'vagrant'
  } 

}

class wso2dss {

  class { '::wso2dss::unzip_bundle':
    wso2_bundle_name => 'wso2dss-3.5.0',
    wso2_user_name => 'vagrant',
    wso2_group_name => 'vagrant'
  } -> 

  class { '::wso2dss::copy_files':
    wso2_server_name_array => ['wso2dss01a'],
    wso2_bundle_name => 'wso2dss-3.5.0',
    wso2_user_name => 'vagrant',
    wso2_group_name => 'vagrant'
  } -> 

  class { '::wso2dss::setup_carbon':
    wso2_server_name_array => ['wso2dss01a'],
  } -> 

  class { '::wso2dss::delete_temps':
    wso2_bundle_name => 'wso2dss-3.5.0',
    wso2_user_name => 'vagrant',
    wso2_group_name => 'vagrant'
  } 

}

class wso2greg {

  class { '::wso2greg::unzip_bundle':
    wso2_bundle_name => 'wso2greg-5.1.0',
    wso2_user_name => 'vagrant',
    wso2_group_name => 'vagrant'
  } -> 

  class { '::wso2greg::copy_files':
    wso2_server_name_array => ['wso2greg01a'],
    wso2_bundle_name => 'wso2greg-5.1.0',
    wso2_user_name => 'vagrant',
    wso2_group_name => 'vagrant'
  } -> 

  class { '::wso2greg::setup_carbon':
    wso2_server_name_array => ['wso2greg01a'],
  } -> 

  class { '::wso2greg::delete_temps':
    wso2_bundle_name => 'wso2greg-5.1.0',
    wso2_user_name => 'vagrant',
    wso2_group_name => 'vagrant'
  } 

}

class activemq {

  class { '::activemq::untargzip_bundle':
    bundle_name => 'apache-activemq-5.12.1-bin.tar.gz',
    user_name => 'vagrant',
    group_name => 'vagrant'
  } -> 

  class { '::activemq::copy_files':
    server_name_array => ['activemq'],
    bundle_name => 'apache-activemq-5.12.1',
    user_name => 'vagrant',
    group_name => 'vagrant'
  } -> 

  class { '::activemq::setup_broker':
    server_name_array => ['activemq'],
  } -> 

  class { '::activemq::delete_temps':
    bundle_name => 'apache-activemq-5.12.1',
    user_name => 'vagrant',
    group_name => 'vagrant'
  } 

}

class wso2esb490 {

  class { '::wso2esb490::unzip_bundle':
    wso2_bundle_name => 'wso2esb-4.9.0',
    wso2_user_name => 'vagrant',
    wso2_group_name => 'vagrant'
  } -> 

  class { '::wso2esb490::copy_files':
    wso2_server_name_array => ['wso2esb490'],
    wso2_bundle_name => 'wso2esb-4.9.0',
    wso2_user_name => 'vagrant',
    wso2_group_name => 'vagrant'
  } -> 

  class { '::wso2esb490::setup_carbon':
    wso2_server_name_array => ['wso2esb490'],
  } -> 

  class { '::wso2esb490::delete_temps':
    wso2_bundle_name => 'wso2esb-4.9.0',
    wso2_user_name => 'vagrant',
    wso2_group_name => 'vagrant'
  } 

}

class wiremock { 

  class { '::wiremock::set_wiremock': 
    wiremock_bundle_name => 'wiremock-1.57-standalone.jar',
    wiremock_server_name => 'wiremock',
    wiremock_user_name => 'vagrant',
    wiremock_group_name => 'vagrant'
 } 

}

class rtail { 

  class { '::rtail::install_and_run': 
    #server_name_array => ['wso2am02a', 'wso2esb01a', 'wso2esb02a', 'wso2dss01a', 'wso2greg01a'],
    #rtail_ip_address => '10.0.2.15',
    #rtail_port_http => '8181',
    #rtail_port_udp => '9191'
 }

}

file { '/home/vagrant/.bashrc':
	source => '/vagrant/provision/wso2-stack-srv/puppet/files/bashrc',
}

host {
  # Hostnames of WSO2 instances
  'wso2am02a': ip => '127.0.0.1';
  'wso2esb01a': ip => '127.0.0.1';
  'wso2esb02a': ip => '127.0.0.1';
  'wso2dss01a': ip => '127.0.0.1';
  'wso2greg01a': ip => '127.0.0.1';
  'wiremock': ip => '127.0.0.1';

  # Other hostnames ('f1' is front tier node 1, 'b1' is back tier node 1)
  'amb1': ip => '127.0.0.1';
  'esbf1': ip => '127.0.0.1';
  'esbb1': ip => '127.0.0.1';
  'dssf1': ip => '127.0.0.1';
  'grf1': ip => '127.0.0.1';  

  # Virtual hostnames
  'wso2am02-vip': ip => '127.0.0.1';
  'wso2esb01-vip': ip => '127.0.0.1';
  'wso2esb02-vip': ip => '127.0.0.1';
  'wso2dss01-vip': ip => '127.0.0.1';
  'wso2greg01-vip': ip => '127.0.0.1';

  # Other virtual hostname  ('f-vip' is front tier LB node, 'b-vip' is back tier LB node)
  'amb-vip': ip => '127.0.0.1';
  'esbf-vip': ip => '127.0.0.1';
  'esbb-vip': ip => '127.0.0.1';
  'dssf-vip': ip => '127.0.0.1';
  'gregf-vip': ip => '127.0.0.1';  
}

# '/home/vagrant/_downloads' symlink created to load and share external files
file { "CREATING_SYMLINK_TO_DOWNLOADS":
  path   => '/home/vagrant/_downloads',
  ensure => 'link',
  target => '/vagrant/_downloads',
}

include wso2esb
include wso2am
include wso2dss
include wso2greg
include wiremock
include rtail
include activemq
include wso2esb490
