

docker image --tag essential .

### bash

	> docker run --name test01 -it essential:latest /bin/bash
	# cd /root
	# touch aaaa
	# exit

	> docker start -ai test01
	# cd /root
	# ls aaa
	# exit

	docker stop test01
	docker rm test01

