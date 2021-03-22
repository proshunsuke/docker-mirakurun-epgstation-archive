個人サーバー用に設定内容を変更したリポジトリ。v2ブランチからnijikaブランチを切っている。

# docker-mirakurun-epgstation

[Mirakurun](https://github.com/Chinachu/Mirakurun) + [EPGStation](https://github.com/l3tnun/EPGStation) の Docker コンテナ

## 前提条件

- Docker, docker-compose の導入が必須
- ホスト上の pcscd は停止する
- チューナーのドライバが適切にインストールされていること

## インストール手順

```sh
git clone git@github.com:proshunsuke/docker-mirakurun-epgstation.git
cd docker-mirakurun-epgstation
make setup/mirakurun

#チャンネル設定
vim mirakurun/conf/channels.yml

#コメントアウトされている restart や user の設定を適宜変更する
vim docker-compose.yml
```

## 起動

```sh
make start
```

mirakurun の EPG 更新を待ってからブラウザで http://DockerHostIP:8888 へアクセスし動作を確認する

## 更新

### すべてを更新

```shell
make update
```

### mirakurunとdbを更新

```shell
make update/mirakurun
```

### epgstationを更新

```shell
make update/epgstation
```

## 停止

```sh
make stop
```

## コンテナの削除

```shell
make down
```

## イメージ含め全削除

```shell
make down/all
```

## 設定

### Mirakurun

* ポート番号: 40772

### EPGStation

* ポート番号: 8888
* ポート番号: 8889

### 各種ファイル保存先

* 録画データ

```./recorded```

* サムネイル

```./epgstation/thumbnail```

* 予約情報と HLS 配信時の一時ファイル

```./epgstation/data```

* EPGStation 設定ファイル

```./epgstation/config```

* EPGStation のログ

```./epgstation/logs```

## v1からの移行について

[docs/migration.md](docs/migration.md)を参照
