alias d='docker'

dockercleanrepo(){
    docker images --no-trunc --format '{{.ID}} {{.Repository}}' \
    | grep "$@" | awk '{ print $1 }' | xargs -t docker rmi
}
