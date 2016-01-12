class activemq (
  $bundle_name = undef,
  $server_name = undef,
  $user_name   = undef,
  $group_name  = undef
  ) {

  if $bundle_name {
    fail ("Parameter bundle_name is mandatory.")
  }
  if $server_name {
    fail ("Parameter server_name is mandatory.")
  }
  if $user_name {
    fail ("Parameter user_name is mandatory.")
  }
  if $group_name {
    fail ("Parameter group_name is mandatory.")
  }
  
}