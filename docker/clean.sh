echo ">> Cleaning unused images" &&
docker 2>/dev/null 1>&2 rmi `docker images -f "dangling=true" -q` || true