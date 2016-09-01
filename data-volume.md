# docker データコンテナとデータボリューム

* データコンテナはデータを永続的に保持するための方法
* コンテナは停止した状態で使うので、一番小型なbusyboxのイメージを使う
* --volumes-from でそのコンテナのボリュームをマウントできる

データコンテナの作成

	$ docker create \
		-v /data \
		-v /var/lib/mysql \
		--name datavol \
		busybox

ローカルに置かれる場所を念のためチェック

	$ docker inspect datavol | jq '.[0].Mounts'

	[
	  {
	    "Name": "8148f5a87635be0c2c3f543511205839869cd921d92e35626ddb289de6bd4319",
	    "Source": "/data/docker/volumes/8148f5a87635be0c2c3f543511205839869cd921d92e35626ddb289de6bd4319/_data",
	    "Destination": "/data",
	    "Driver": "local",
	    "Mode": "",
	    "RW": true,
	    "Propagation": ""
	  },
	  {
	    "Name": "d774bbc4e4819337ffc04e893d9ad445d8a1341c55cbf56c1eec22196a85a575",
	    "Source": "/data/docker/volumes/d774bbc4e4819337ffc04e893d9ad445d8a1341c55cbf56c1eec22196a85a575/_data",
	    "Destination": "/var/lib/mysql",
	    "Driver": "local",
	    "Mode": "",
	    "RW": true,
	    "Propagation": ""
	  }
	]

データにアクセスするコンテナを作成

	$ docker run --volumes-from datavol -it --rm busybox
	/ # touch /aaa
	/ # touch /data/bbb
	/ # touch /var/lib/mysql/ccc
	/ # exit

新しいコンテナで再度チェック

	$ docker run --volumes-from datavol -it --rm busybox

	/ # ls /aaa
	ls: /aaa: No such file or directory

	/ # ls /data/bbb
	/data/bbb

	/ # ls /var/lib/mysql/ccc
	/var/lib/mysql/ccc

	/ # exit

データボリュームコンテナを削除するときは -v オプションをつける。つけないとファイルが残存する。

	$ docker rm -v datavol

