## Voice Cloud

#### URL
http://voicecloud.work

#### 概要
声で繋がるSNSサービスです。
誰かが投稿した「私が考えたセリフを読み上げてほしい」  
「この文章を朗読してください」等の、「お題」に対し、  
そのお題に沿った内容で録音した音声ファイルを投稿し共有出来ます。  
また、プロフィールページではサンプルボイスの設定なども出来、  
自信のプロフィールとして他の人に共有することも出来ます。  
他のSNSなどのように「お題」「ボイス投稿」に対するいいね・コメント・ユーザーに対するフォロー機能も備えています。

開発環境と本番環境にDocker、インフラにAWSを利用しています。

### 使用言語
Ruby 2.6.6, Rails 6.1.3  
JavaScript(Vue.js), HTML5, TailwindCSS

### 使用技術
AWS(VPC, EC2, RDS, Route53)  
Docker, docker-compose  
PostgresQL  
Rspec  
Nginx  
Git

### ER図


## サービス構成図


## 機能
### 認証機能(devise)
- 新規登録、ログイン、ログアウト
  - 名前、メールアドレス、パスワード必須。ログイン時はメールアドレス、パスワードのみでログイン可能。

### お題投稿機能
### ボイス投稿機能
### いいね(ボイス)、コメント(ボイス)、お気に入り(お題)機能
### フォロー機能
- フォロー、アンフォロー機能
- フォロー、フォロワー一覧表示
### テスト
- Rspecで150以上


## 今後の改善点
### 機能面
- 検索機能の実装
- 
### デザイン面
- エラー、インフォメッセージのデザイン改善
