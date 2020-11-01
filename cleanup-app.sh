

SERVICE="bhaskar_customer_service"
DB="bhaskar-db-service"
NETWORK="bhaskar_customer_network"

cleanup_network() {
    echo "Cleaning up network: $NETWORK"
    if docker network ls | grep $NETWORK
    then
        echo "found network: $NETWORK"
        docker network rm $NETWORK
   else
        echo "Network not found."
    fi
}

stop_containers(){
    echo "Step1 Stopping any zombie containers..." #before network remove
    declare -a arr=($SERVICE $DB) 
    for i in "${arr[@]}"
    do
        echo "Removing $i ......"
        container_id=$(docker ps -aqf "name=$i")
        if [[ ! -z "$container_id" ]]
        then
            echo "Container found: " $container_id
            docker rm -f $container_id
        else
            echo "No container found for: $i" 
        fi        
    done
}

function cleanup {
    status="$?"
    if [ "$status" != "0" ];
    then
        log_errors
    fi
    stop_containers
    cleanup_network
}

cleanup