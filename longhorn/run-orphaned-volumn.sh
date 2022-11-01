rm -rf mongodb_result.text
touch mongodb_result.text
i=1;
for PVC_NAME in "$@"
do

  export PVC_PATH="/var/lib/longhorn/replicas"
  export VOLUME_PATH="$PVC_PATH/$PVC_NAME"

  echo "****************** Starting for $PVC_NAME ******************"

  export VOLUME_SIZE=$(jq .Size $VOLUME_PATH/volume.meta)

  echo "Geting info: $PVC_NAME"
  echo "Volume Size: $VOLUME_SIZE"
  echo "Running docker container..."
  docker run --name $PVC_NAME -d -v /dev:/host/dev -v /proc:/host/proc -v $VOLUME_PATH:/volume --privileged longhornio/longhorn-engine:v1.1.1 launch-simple-longhorn $PVC_NAME $VOLUME_SIZE
  echo "Docker container has created: $PVC_NAME"
  sleep 10
  echo "Mounting path..."
  mkdir /var/mnt/$PVC_NAME -p
  mount /dev/longhorn/$PVC_NAME /var/mnt/$PVC_NAME
  ls /var/mnt/$PVC_NAME
  echo "New volume path has mounted: /var/mnt/$PVC_NAME"
  export DB_CONFIG_FILE_PATH="/var/mnt/$PVC_NAME/data/automation-mongod.conf"
  echo "Checking mongodb config file: $DB_CONFIG_FILE_PATH"
  if [[ -f "$DB_CONFIG_FILE_PATH" ]]; then
    echo "$DB_CONFIG_FILE_PATH exists."
    echo "****************** Starting for $PVC_NAME ******************" >> result.text
    cat $DB_CONFIG_FILE_PATH >> result.text
    echo "=================== End scrpit for $PVC_NAME ===================" >> result.text
  fi

  echo "=================== End scrpit for $PVC_NAME ==================="

  i=$((i + 1));
done