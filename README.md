# sinatra-lesson-memo
Sinatraの学習用に作成したメモアプリです。

## requirement
- Ruby: 2.7.1
- Yarn: 1.22.4
- PostgreSQL: 11.6

※これ以下のバージョンでも動くとは思います

## setup
### DB
```
$ psql
# CREATE ROLE root PASSWORD 'root';
# CREATE DATABASE sinatra_lesson_memo_development OWNER root;

- DB指定してテーブルを作成
# exit
$ psql -U root -d sinatra_lesson_memo_development
# CREATE TABLE memos (id SERIAL, title VARCHAR(50), content TEXT);
```

### 実行
1. `$ sh setup.sh` を実行してください（初回のみ） ※DBのロールやパスワードを変更した場合は、合わせて`.env`を編集してください
1. `$ ruby myapp.rb` を実行してください
1. `http://localhost:4567/` にアクセスするとメモアプリが利用できます
