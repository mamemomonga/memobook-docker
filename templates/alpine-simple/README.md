# Alpile-Linux 実行環境サンプル

Alpine Linuxの基本イメージにローカルタイムの変更、gosuのインストール、appユーザの追加を行い、何もしないサーバを起動します。

config.env にイメージやコンテナ名、共通で使うdocker run のオプションなどを設定します。

### コンテナのビルド (build)

	$ scripts/build

### 単発実行シェル (run -it --rm)

--rm オプションは処理が終わったら自分自身のコンテナを削除します。

	$ scripts/run-sh 
	$ scripts/run-sh -c 'id'

### 起動 (stop, rm, run)

	$ scripts/ctrl up

### 動作中コンテナにrootユーザで入る(exec)

	$ scripts/exec-root
	$ scripts/exec-root -c 'id'

### 動作中コンテナにappユーザで入る(exec)

	$ scripts/exec-app
	$ scripts/exec-app -c 'id'

### 終了 (stop, rm)

	$ scripts/ctrl down

