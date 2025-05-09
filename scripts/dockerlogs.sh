#!/bin/bash
# https://stackoverflow.com/questions/38094715/tail-stdout-from-multiple-docker-containers

if [ $# -eq 0 ]; then
   echo "Usage: $(basename "$0") containerid ..."
   exit 1
fi

pids=()
cleanup()
{
   kill "${pids[@]}"
}

trap cleanup EXIT

while [ $# -ne 0 ]
do
    (docker logs -f -t --tail=10 "$1"|sed -e "s/^/$1: /")&
    pids+=($!)
    shift
done
wait
