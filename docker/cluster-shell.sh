#!/bin/sh

if ! docker container ls | grep -q cluster-vim; then
	echo "Cluster-shell is not running. Starting it now..."
	make -C ~/local/share/cluster_vim > /dev/null
	echo "done."
fi

docker exec -it -w /root cluster-vim /bin/zsh