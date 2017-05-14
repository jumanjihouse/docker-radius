@test "radiusd container is running" {
  run docker ps --format '{{ .Names }}'
  [[ ${status} -eq 0 ]]
  [[ ${output} =~ 'radiusd' ]]
}

@test "radiusd responds to status message authenticator" {
  run docker-compose run status
  [[ ${output} =~ 'Received Access-Accept' ]]
}

@test "radiusd authenticates user from raddb" {
  run docker-compose run auth
  [[ ${output} =~ 'Received Access-Accept' ]]
}

@test "radiusd container log is meaningful" {
  run docker-compose logs radiusd
  [[ ${output} =~ 'Ready to process requests' ]]
}
