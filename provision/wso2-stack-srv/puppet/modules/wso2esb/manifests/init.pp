class wso2esb (
  $wso2esb_bundle_name = undef,
  $wso2esb_server_name = undef,
  $wso2_user_name      = undef,
  $wso2_group_name     = undef
  ) {

  if $wso2esb_bundle_name {
    fail ("Parameter wso2esb_bundle_name is mandatory.")
  }
  if $wso2esb_server_name {
    fail ("Parameter wso2esb_server_name is mandatory.")
  }
  if $wso2_user_name {
    fail ("Parameter wso2_user_name is mandatory.")
  }
  if $wso2_group_name {
    fail ("Parameter wso2_group_name is mandatory.")
  }
  
}