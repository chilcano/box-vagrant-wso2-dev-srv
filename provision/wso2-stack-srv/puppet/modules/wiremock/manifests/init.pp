class wiremock (
  $wiremock_bundle_name = undef,
  $wiremock_server_name = undef,
  $wiremock_user_name   = undef,
  $wiremock_group_name  = undef
  ) {

  if $wiremock_bundle_name {
    fail ("Parameter wiremock_bundle_name is mandatory.")
  }
  if $wiremock_server_name {
    fail ("Parameter wiremock_server_name is mandatory.")
  }
  if $wiremock_user_name {
    fail ("Parameter wiremock_user_name is mandatory.")
  }
  if $wiremock_group_name {
    fail ("Parameter wiremock_group_name is mandatory.")
  }

}