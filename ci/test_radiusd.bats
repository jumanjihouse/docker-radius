# BATS runs teardown() after each @test.
teardown() {
  docker rm -f radiusd.service &> /dev/null || :
}

# BATS runs setup() before each @test.
setup() {
  docker run -d -t -p 1812:1812/udp --cpu-shares 512 -m 100m --read-only --name radiusd.service jumanjiman/radiusd -f -l stdout
  radiusd_ip=$(docker inspect --format '{{ .NetworkSettings.IPAddress }}' radiusd.service)
}

@test "radiusd container is running" {
  run docker ps --format '{{ .Names }}'
  [[ ${status} -eq 0 ]]
  [[ ${output} =~ 'radiusd.service' ]]
}

@test "radiusd container has an ip address" {
  [[ -n ${radiusd_ip} ]]
}

@test "radiusd responds to status message authenticator" {
  run docker run --rm jumanjiman/radclient -f /root/status_message ${radiusd_ip}:1812 status testing123
  [[ ${output} =~ 'Received Access-Accept' ]]
}

@test "radiusd authenticates user from raddb" {
  run docker run --rm -t jumanjiman/radclient -f /root/test.conf ${radiusd_ip}:1812 auth testing123
  [[ ${output} =~ 'Received Access-Accept' ]]
}

@test "radiusd container log is meaningful" {
  sleep 2
  run docker logs radiusd.service
  [[ ${output} =~ 'Ready to process requests' ]]
}
