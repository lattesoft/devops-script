i=1;
for PVC_NAME in "$@"
do

  export PVC_PATH="/var/lib/longhorn/replicas"
  export PCV_NAME_ARR=(${PVC_NAME//;/ })
  export TARGET_PVC=${PCV_NAME_ARR[0]}
  export SOURCE_PVC=${PCV_NAME_ARR[1]}
  export TARGET_PATH="$PVC_PATH/$TARGET_PVC"
  export SOURCE_PATH="$PVC_PATH/$SOURCE_PVC"

  echo "****************** Starting for replacing $TARGET_PVC with $SOURCE_PVC ******************"

  echo "Copying backup: $TARGET_PVC"
  cp -r $TARGET_PATH "${TARGET_PATH}-backup"

  echo "Deleting: $TARGET_PVC"
  rm -rf $TARGET_PATH

  echo "Replacing $TARGET_PVC with $SOURCE_PVC"
  cp -r $SOURCE_PATH $TARGET_PATH

  echo "=================== End scrpit for replacing $TARGET_PVC with $SOURCE_PVC ==================="

  i=$((i + 1));
done