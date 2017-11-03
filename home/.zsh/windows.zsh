#echo 'hoge'
#if [ ! -d "/c" ] || [ ! "$(ls -A /c)" ]; then
#  echo "Requiring root password to $(tput setaf 6)mount --bind /mnt/c /c$(tput sgr 0)"
#  sudo mkdir -p /c
#  sudo mount --bind /mnt/c /c
#fi
#
## Change from /mnt/c/... to /c/...
#if [[ "$(pwd | cut -c -7)" == "/mnt/c/" ]]; then
#  cd "$(pwd | cut -c 5-)"
#fi
#
## Provide docker for bash and docker-compose
#docker() {
#  docker.exe "$@"
#}
export DOCKER_HOST='tcp://0.0.0.0:2375'
