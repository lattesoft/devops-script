## Variables
package="Install jenkins"
while test $# -gt 0; do
  case "$1" in
    -h|--help)
      echo "$package - attempt to capture frames"
      echo " "
      echo "$package [options] application [arguments]"
      echo " "
      echo "options:"
      echo "-h, --help                                    show brief help"
      echo "-f, --docker-file=Dockerfile                  specify a docker file name"
      echo "-i, --image-name=IMAGE_NAME                   specify an image name"
      echo "-c, --container-name=CONTAINER_NAME           specify a container name"
      echo "-p, --port=PORT                               specify a container port"
      echo "-d, --domain=DOMAIN_NAME                      specify a domain name"
      echo "-sn, --server-name=SERVER_NAME                specify a server name"
      echo "-cz, --cloudflare-zone=ZONE_ID                specify a CloudFlare zone ID"
      echo "-ct, --cloudflare-token=TOKEN                 specify a CloudFlare token"
      echo "-cdt, --cloudflare-dns-type=DNS_TYPE          specify a CloudFlare DNS type"
      echo "-cdc, --cloudflare-dns-content=DNS_CONTENT    specify a CloudFlare DNS type"
      echo "-e, --env=ENV_FILE                            specify a environment variables file"
      echo "-l, --link=LINK_CONTAINER                     specify a container to link network"
      echo "-bmem, --build-memory=MEMORY                  specify a memory to build image"
      echo "-bcpus, --build-cpus=CPUS                     specify the cpus to build image"
      echo "-rmem, --run-memory=MEMORY                  specify a memory to run image"
      echo "-rcpus, --run-cpus=CPUS                     specify the cpus to run image"

      exit 0
      ;;
    -f)
      shift
      if test $# -gt 0; then
        export DOCKER_FILE=$1
      else
        echo "no docker file specified"
        exit 1
      fi
      shift
      ;;
    --docker-file*)
      export DOCKER_FILE=`echo $1 | sed -e 's/^[^=]*=//g'`
      shift
      ;;
    -i)
      shift
      if test $# -gt 0; then
        export IMAGE_NAME=$1
      else
        echo "no image name specified"
        exit 1
      fi
      shift
      ;;
    --image-name*)
      export IMAGE_NAME=`echo $1 | sed -e 's/^[^=]*=//g'`
      shift
      ;;
    -c)
      shift
      if test $# -gt 0; then
        export CONTAINER_NAME=$1
      else
        echo "no container name specified"
        exit 1
      fi
      shift
      ;;
    --container-name*)
      export CONTAINER_NAME=`echo $1 | sed -e 's/^[^=]*=//g'`
      shift
      ;;
    -p)
      shift
      if test $# -gt 0; then
        export PORT=$1
      else
        echo "no port specified"
        exit 1
      fi
      shift
      ;;
    --port*)
      export PORT=`echo $1 | sed -e 's/^[^=]*=//g'`
      shift
      ;;
    -d)
      shift
      if test $# -gt 0; then
        export DOMAIN=$1
      else
        echo "no domain name specified"
        exit 1
      fi
      shift
      ;;
    --domain*)
      export DOMAIN=`echo $1 | sed -e 's/^[^=]*=//g'`
      shift
      ;;
    -cz)
      shift
      if test $# -gt 0; then
        export CLOUDFLARE_ZONE=$1
      else
        echo "no cloudflare zone specified"
        exit 1
      fi
      shift
      ;;
    --cloudflare-zone*)
      export CLOUDFLARE_ZONE=`echo $1 | sed -e 's/^[^=]*=//g'`
      shift
      ;;
    -ct)
      shift
      if test $# -gt 0; then
        export CLOUDFLARE_TOKEN=$1
      else
        echo "no cloudflare token specified"
        exit 1
      fi
      shift
      ;;
    --cloudflare-token*)
      export CLOUDFLARE_TOKEN=`echo $1 | sed -e 's/^[^=]*=//g'`
      shift
      ;;
    -cdt)
      shift
      if test $# -gt 0; then
        export CLOUDFLARE_DNS_TYPE=$1
      else
        echo "no cloudflare DNS type specified"
        exit 1
      fi
      shift
      ;;
    --cloudflare-dns-type*)
      export CLOUDFLARE_DNS_TYPE=`echo $1 | sed -e 's/^[^=]*=//g'`
      shift
      ;;
    -cdc)
      shift
      if test $# -gt 0; then
        export CLOUDFLARE_DNS_CONTENT=$1
      else
        echo "no cloudflare DNS type specified"
        exit 1
      fi
      shift
      ;;
    --cloudflare-dns-content*)
      export CLOUDFLARE_DNS_CONTENT=`echo $1 | sed -e 's/^[^=]*=//g'`
      shift
      ;;
    -sn)
      shift
      if test $# -gt 0; then
        export SERVER_NAME=$1
      else
        echo "no server name specified"
        exit 1
      fi
      shift
      ;;
    --server-name*)
      export SERVER_NAME=`echo $1 | sed -e 's/^[^=]*=//g'`
      shift
      ;;
    -e)
      shift
      if test $# -gt 0; then
        export ENVIRONMENT_FILE=$1
      else
        echo "no server name specified"
        exit 1
      fi
      shift
      ;;
    --env*)
      export ENVIRONMENT_FILE=`echo $1 | sed -e 's/^[^=]*=//g'`
      shift
      ;;
    -l)
      shift
      if test $# -gt 0; then
        export LINK_CONTAINER=$1
      else
        echo "no container name specified"
        exit 1
      fi
      shift
      ;;
    --link*)
      export LINK_CONTAINER=`echo $1 | sed -e 's/^[^=]*=//g'`
      shift
      ;;
    -bmem)
      shift
      if test $# -gt 0; then
        export BUILD_MEMORY=$1
      else
        echo "no build memory specified"
        exit 1
      fi
      shift
      ;;
    --build-memory*)
      export BUILD_MEMORY=`echo $1 | sed -e 's/^[^=]*=//g'`
      shift
      ;;
    -bcpus)
      shift
      if test $# -gt 0; then
        export BUILD_CPUS=$1
      else
        echo "no build cpus specified"
        exit 1
      fi
      shift
      ;;
    --build-cpus*)
      export BUILD_CPUS=`echo $1 | sed -e 's/^[^=]*=//g'`
      shift
      ;;
      
    -rmem)
      shift
      if test $# -gt 0; then
        export RUN_MEMORY=$1
      else
        echo "no run memory specified"
        exit 1
      fi
      shift
      ;;
    --run-memory*)
      export RUN_MEMORY=`echo $1 | sed -e 's/^[^=]*=//g'`
      shift
      ;;
    -rcpus)
      shift
      if test $# -gt 0; then
        export RUN_CPUS=$1
      else
        echo "no build cpus specified"
        exit 1
      fi
      shift
      ;;
    --run-cpus*)
      export RUN_CPUS=`echo $1 | sed -e 's/^[^=]*=//g'`
      shift
      ;;
      
      
    *)
      break
      ;;
  esac
done



## Generating new port
IS_RANDOM_PORT_EMPTY=false
GET_RANDOM_PORT() {
  RANDOM_PORT=$(shuf -i 2000-65000 -n 1)
  RUNNING_PORT=$(sudo /usr/bin/lsof -t -i:$RANDOM_PORT)
  echo Random port: $RANDOM_PORT.
  if [ -z "$RUNNING_PORT" ]
  then
    echo Port $RANDOM_PORT is empty.
    IS_RANDOM_PORT_EMPTY=true
  fi
}

GET_RANDOM_PORT
while [ "$IS_RANDOM_PORT_EMPTY" = false ]; do
   echo $RANDOM_PORT is running. Generating new port.
   GET_RANDOM_PORT
done

if [ -n "$DOCKER_FILE" ]; then
  DOCKER_FILE=Dockerfile
	echo ">> Dockerfile is $DOCKER_FILE."
fi


## Build Docker
echo ">> Building image" &&
BUILD_IMAGE_CMD='docker build -f $DOCKER_FILE -t $IMAGE_NAME .'

if [ -n "$BUILD_MEMORY" ] && [ -n "$BUILD_CPUS" ]
then
  eval $BUILD_IMAGE_CMD " --cpuset-cpus=$BUILD_CPUS --memory=$BUILD_MEMORY"
elif [ -n "$BUILD_MEMORY" ]
then
  eval $BUILD_IMAGE_CMD " --memory=$BUILD_MEMORY"
elif [ -n "$BUILD_CPUS" ]
then
  eval $BUILD_IMAGE_CMD " --cpuset-cpus=$BUILD_CPUS"
else
  eval $BUILD_IMAGE_CMD
fi

echo ">> Building image" &&
docker 2>/dev/null 1>&2 stop $CONTAINER_NAME || true &&
docker 2>/dev/null 1>&2 rm $CONTAINER_NAME || true && 
echo ">> Running container" &&
if [ -n "$ENVIRONMENT_FILE" ] && [ -n "$LINK_CONTAINER" ]
then
  docker run -p $RANDOM_PORT:$PORT -d --name $CONTAINER_NAME --env-file $ENVIRONMENT_FILE --link $LINK_CONTAINER --restart always $IMAGE_NAME
elif [ -n "$LINK_CONTAINER" ]
then
  docker run -p $RANDOM_PORT:$PORT -d --name $CONTAINER_NAME --link $LINK_CONTAINER --restart always $IMAGE_NAME
elif [ -n "$ENVIRONMENT_FILE" ]
then
  docker run -p $RANDOM_PORT:$PORT -d --name $CONTAINER_NAME --env-file $ENVIRONMENT_FILE --restart always $IMAGE_NAME
else
  docker run -p $RANDOM_PORT:$PORT -d --name $CONTAINER_NAME --restart always $IMAGE_NAME
fi

sudo bash -c "$(wget -q -O - https://raw.githubusercontent.com/lattesoft/devops-script/main/docker/clean.sh)"


## Nginx Setup
if [ -n "$DOMAIN" ]; then
	echo ">> Domain name is $DOMAIN."
  if [ -n "$SERVER_NAME" ] 
  then
    echo ">> Server name: $SERVER_NAME"
  else
    echo ">> Server name: $DOMAIN"
    SERVER_NAME=$DOMAIN
  fi
  IFS="," read -a SERVER_NAME_ARRAY <<< $SERVER_NAME
  IFS="," read -a CLOUDFLARE_ZONE_ARRAY <<< $CLOUDFLARE_ZONE
  for (( i=0; i<=${#SERVER_NAME_ARRAY[@]}; i++ )); do
      if [ -n "${SERVER_NAME_ARRAY[$i]}" ]; then
        sudo bash -c "$(wget -q -O - https://raw.githubusercontent.com/lattesoft/devops-script/main/util/nginx-generate-config.sh)" '' --domain=${SERVER_NAME_ARRAY[$i]} --server-name=${SERVER_NAME_ARRAY[$i]} --port=$RANDOM_PORT

        if [ -n "$CLOUDFLARE_ZONE" ] && [ -n "$CLOUDFLARE_TOKEN" ] && [ -n "$CLOUDFLARE_DNS_TYPE" ] && [ -n "$CLOUDFLARE_DNS_CONTENT" ]; then
          echo ">> Updating cloudflare."
            echo ">> Updating DNS ${SERVER_NAME_ARRAY[$i]}"
            sudo bash -c "$(wget -q -O - https://raw.githubusercontent.com/lattesoft/devops-script/main/util/cloudflare-update-dns.sh)" '' --cloudflare-zone=${CLOUDFLARE_ZONE_ARRAY[$i]} --cloudflare-token=$CLOUDFLARE_TOKEN --domain=${SERVER_NAME_ARRAY[$i]} --cloudflare-dns-type=$CLOUDFLARE_DNS_TYPE --cloudflare-dns-content=$CLOUDFLARE_DNS_CONTENT --cloudflare-dns-ttl=120 --cloudflare-dns-proxied=false
            echo ">> Generating ssl ${SERVER_NAME_ARRAY[$i]}"
            sudo bash -c "$(wget -q -O - https://raw.githubusercontent.com/lattesoft/devops-script/main/util/certbot-generate-cert.sh)" '' --domain=${SERVER_NAME_ARRAY[$i]}
        fi
      fi
  done
fi
