個人サーバー用に設定内容を変更したリポジトリ。本家v2ブランチからnijikaブランチを切っている。

# docker-mirakurun-epgstation

[Mirakurun](https://github.com/Chinachu/Mirakurun) + [EPGStation](https://github.com/l3tnun/EPGStation) の Docker コンテナ

<img src="https://user-images.githubusercontent.com/3148511/112107472-50dded00-8bf2-11eb-972b-f5b149e51716.png" width="1000">

## 環境

### サーバー

* Raspberry Pi: Raspberry Pi 4 Model B Rev 1.1
* OS: Raspbian GNU/Linux 10 (buster)
* Linux Kernel: Linux 5.10.17-v7l+ armv7l GNU/Linux

### チューナー

* PX-S1UD V2.0
* DTV02-1T1S-U

### カードリーダー

* SCR3310/v2.0

### リバースプロキシのためのwebサーバー

* nginx

## 事前準備

### dockerのインストール

```shell
curl -sSL https://get.docker.com | sh
```

### docker-composeのインストール

aptのリポジトリでは古いバージョンがインストールされてしまうのでpipを使用する

```shell
pip3 install -U docker-compose
echo 'export PATH=$PATH:$HOME/.local/bin' >> ~/.bashrc
```

### ドライバのインストール

以下の通りに行う

* https://github.com/nns779/px4_drv

## インストール手順

```sh
git clone https://github.com/proshunsuke/docker-mirakurun-epgstation.git
cd docker-mirakurun-epgstation
make setup/mirakurun
```

## 起動

```sh
make start
```

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
