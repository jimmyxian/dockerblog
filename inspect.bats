#!/usr/bin/env bats

load helpers

function teardown(){
        swarm_manage_cleanup
        stop_docker
}

@test " docker inspect the running container should return success" {
        start_docker 1
        swarm_manage
        #run container
        run docker_swarm run -d --name exec_container ubuntu:latest sleep 100
        [ "$status" -eq 0 ]
        #make sure container is up
        run docker_swarm ps -l
        [[ "${#lines[@]}" -eq 2 ]]
        [[ "${#lines[1]}" ==  *"Up"* ]]
        #inspect
        run docker_swarm inspect exec_container
        [ "$status" -eq 0 ]
        [[ "${#lines[1]}" ==  *"AppArmorProfile"* ]]
}
