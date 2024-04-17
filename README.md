# photo_app

アップロードした写真を一覧で確認できるアプリケーションです。

## 環境構築

環境構築に Docker を使用するため PC 上に無い場合は適宜インストールしてください。

1. 環境変数の設定

アプリケーションで環境変数を読み込むため、以下のコマンドを実行し、環境変数ファイルを作成してください。

```sh
cp env.development.template .env.development
```

作成後、以下の環境変数をご自身の OAuth アプリ情報を基に変更してください。

```
OAUTH_CLIENT_ID=your_oauth_client_id
OAUTH_CLIENT_SECRET=your_oauth_client_secret
OAUTH_HOST=http://localhost:3001
```

2. アプリケーションを起動する

```sh
docker compose up -d
```

コンテナが立ち上がったらブラウザで http://localhost:3000 にアクセスします。
ログイン画面が表示されれば正常に動作しています。

### 動作確認方法

[seed データ](./db/seeds.rb)でユーザー情報を DB に登録しているため、seed の情報を基にログインし、写真のアップロードやアップロードした写真の確認ができます。