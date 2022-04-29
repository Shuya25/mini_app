# README
# mini app
I'm currently working hard!
現在、鋭意製作中。

## 使い方

リポジトリを手元にクローン
その後、次のコマンドで必要になる RubyGems 等をインストール

```
$ gem install bundler -v 2.3.5
$ bundle _2.3.5_ config set --local without 'production'
$ bundle _2.3.5_ install
$ yarn install --check-files
```

その後、データベースへのマイグレーションを実行

```
$ rails db:migrate
```

最後に、テストを実行してうまく動いているかどうか確認

```
$ rails test
```

テストが無事に通ったら、Railsサーバーを立ち上げる

```
$ rails server
```

その他必要なものをインストール
```
$ brew install imagemagick
```
