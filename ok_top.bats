#!/usr/bin/env bats

load helpers

function teardown(){
        swarm_manage_cleanup
        stop_docker
}

@test "docker top: display the running processes of a container" {
        #create
        start_docker 1
        swarm_manage
        
        run docker_swarm run -d --name test_container busybox sleep 500
        [ "$status" -eq 0 ]
        #make sure container is running
        run docker_swarm ps -l
        [ "${#lines[@]}" -eq 2 ]
        [[ "${lines[1]}" == *"Up"* ]]
        
        run docker_swarm top test_container
        [ "$status" -eq 0 ]
        [[ "${lines[0]}" == *"UID"* ]]
}
