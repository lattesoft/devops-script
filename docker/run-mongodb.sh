DB_NAME="$1"
PORT="$2"
USERNAME="$3"
PASSWORD="$4"

docker 2>/dev/null 1>&2 stop $DB_NAME || true
docker 2>/dev/null 1>&2 rm $DB_NAME || true 

echo ">> Running database container" &&
docker run -p $PORT:27017 -d \
	-v /var/db/mongo/$DB_NAME:/data/db \
    -e MONGO_INITDB_ROOT_USERNAME=$USERNAME \
    -e MONGO_INITDB_ROOT_PASSWORD=$PASSWORD \
    --name $DB_NAME --restart always mongo