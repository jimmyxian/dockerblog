#!/usr/bin/env bats

load helpers

function teardown(){
        swarm_manage_cleanup
        stop_docker
}

@test "swarm delete image should return success" {
        start_docker 1
        swarm_manage
        run docker_swarm pull busybox
        [ "$status" -eq 0 ]
        
        run docker_swarm rmi busybox
        [ "$status" -eq 0 ]
        
        run docker_swarm images
        [ "$status" -eq 0 ]
        [ "${#lines[@]}" -eq 1 ]
        
        run docker -H ${HOST[0]} images
        [ "$status" -eq 0 ]
        [ "${#lines[@]}" -eq 1 ]
}
