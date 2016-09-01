# docker run の -e と --link についてのメモ

--linkをつけると環境変数で指定したコンテナのEXPOSEなポートと起動時の環境変数を知ることができる

ひとつめのコンテナ

	$ docker run \
	  --name sv1 \
	  -d \
	  -p 18888:8888 \
	  -e HOGEHOGE=MOGUMOGU \
	  busybox \
	  sh -c 'while true; do sleep 1; done'

	$ docker exec sv1 env

	PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
	HOSTNAME=188664d9c2a6
	HOGEHOGE=MOGUMOGU
	HOME=/root

ふたつめのコンテナ

	$ docker run \
	  --name sv2 \
	  -d \
	  --link sv1:s1 \
	  busybox \
	  sh -c 'while true; do sleep 1; done'
	
	$ docker exec sv2 env

	PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
	HOSTNAME=a0a7be75a51e
	S1_PORT=tcp://172.17.0.2:8888
	S1_PORT_8888_TCP=tcp://172.17.0.2:8888
	S1_PORT_8888_TCP_ADDR=172.17.0.2
	S1_PORT_8888_TCP_PORT=8888
	S1_PORT_8888_TCP_PROTO=tcp
	S1_NAME=/sv2/s1
	S1_ENV_HOGEHOGE=MOGUMOGU
	HOME=/root

停止と削除

	docker stop sv1; docker rm sv1; docker stop sv2; docker rm sv2
