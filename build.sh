set -e

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

function log_errors(){
    echo "Logging errors"
    container_ids=$(docker ps -qf "name=${BDD_CLIENT}")
    if [[ ! -z "$container_ids" ]]
    then
        docker logs ${SERVICE} > service_log.log
        docker logs ${BDD_CLIENT} > client_log.log
        echo "Error Logs Created in Workspace"
    else
    echo "${BDD_CLIENT} is not running."
    fi
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

# function verifyDBRunning {
#     isRunning=false
#     tries=60
#     while [[ "$isRunning" == "false" && "$tries" -ne 1 ]]
#     do
#         echo "Number of tries left: $tries"
#         if [[ "$(docker logs $DB | grep finished)" ]];
#             then
#                 echo "DB is running"
#                 sleep 1
#                 isRunning=true
#             else
#                 echo "DB is not running"
#                 sleep 1
#                 tries=`expr $tries - 1`

#         fi
#     done
# }

function run_tests {
    echo "called with param: $1"
    cleanup
    
    echo "Create network: $NETWORK"
    docker network create --driver bridge $NETWORK

    # echo "Step 2 - Build mock-ims....."
    # docker build -t $MOCK_IMS -f tests/bdd/mock/Dockerfile  tests/bdd/mock
    
    echo "Step 4 - Build DB...."
    docker build -t $DB db

    # echo "Step 5 - Run mock-ims....."
    # docker run -d --name $MOCK_IMS --network $NETWORK $MOCK_IMS

    echo "Step 6 - Run DB....."
    docker run -d --name $DB -p 1433:1433 --network $NETWORK $DB 
    
    echo "Sleep for 5 seconds and to wait for DB running"
    sleep 5

    echo "Step 7 - Build service in bdd mode....."
    docker build . -t $SERVICE
    # -f tests/bdd/service/Dockerfile .

    echo "Step 8 - Run service....."
    docker run -d -p 8081:8081 --name $SERVICE --network $NETWORK $SERVICE
    
    # echo "Step 9 - Build client-bdd....."
    # docker build -t $BDD_CLIENT -f tests/bdd/client/Dockerfile  --build-arg service=$SERVICE tests/bdd/client/

    # echo "Sleep for 5 seconds and then verify DB is running"
    # sleep 5
    # verifyDBRunning
    
    # echo "Step 10 - Run client-bdd....."
    # docker run  --name $BDD_CLIENT  --volume $(pwd)/coverage:/coverage --network $NETWORK $BDD_CLIENT $1
}

# don't clean up if you pass 'local' as an argument
if [ "$1" != "local" ]; then
    trap cleanup EXIT SIGHUP SIGINT SIGTERM
fi

time run_tests $1