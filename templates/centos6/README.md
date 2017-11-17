# CentOS6

CentOS6で待機するだけのサーバを作成します

### コンテナのビルド

	$ scripts/build

### 実行後削除するコンテナでシェル実行

	$ scripts/run-sh 
	$ scripts/run-sh -c 'id'

### コンテナ起動

	$ scripts/ctrl up

### 動作中コンテナにrootユーザで入る

	$ scripts/exec-root
	$ scripts/exec-root -c 'id'

### 動作中コンテナにappユーザで入る

	$ scripts/exec-app
	$ scripts/exec-app -c 'id'

### コンテナ終了

	$ scripts/ctrl down

