# LeatherPalette(レザーパレット)
サービスURL : https://www.leatherpalette.com/
![](/assets/images/ogp.png)

## ■サービス概要
革製品のエイジング(経年変化)写真やメンテナンス方法の共有・検索ができるサービスです。

「LeatherPalette(レザーパレット)」は、
革製品の写真と一緒に、アイテム情報(ブランド名、商品名、使用年数、カラーの系統)やお手入れ情報を記録・共有することができます。
公開された投稿はアイテム情報を基に条件を絞って検索することができます。
<br>革製品の購入を検討しているユーザーには、購入前に革の個体差やエイジングの進み方、ケア方法を知ることができるツールとして、
<br>製品愛用者は自慢のコレクションの変化を記録し、他ユーザーとのエイジングの違いを楽しめるツールとなります。

## ■ サービス開発の背景
私は、革製品の製造販売会社でEC業務やInstagram運用を行っていた経験があります。
<br>革の変化やケア方法の問い合わせを受けた際、過去の投稿やブログ記事を引用してご案内する事も多々ありましたが、適切なものを探し出す事の難しさ感じていました。
またこの問い合わせの要因には、お客様にとってもブログのアーカイブから自分の求めている情報に辿り着くのが困難で、Instagramはハッシュタグの設定や検索の入力内容によって結果にばらつきがあり、求めている情報を正確に取得しにくい弱点がある事も関係していました。
<br>しかし、弱点はあるにせよ、Instagramの投稿やお客様同士のコメントのやり取りに合わせて受注が動くことも多く、視覚的な訴求や、他者の商品に関する情報が手に入る場があることは大きな効果を生むことも実感していたため、
<br>**消費者にとって必要な情報が取得しやすく、革製品で最初に気になる不安ポイント(変化や扱い方)について消費者自身で気軽に解決できるサービスを提供したい**と考え、このWebサービスを開発しました。

## ■ 機能紹介
### ログインせずに使用可能な機能
| 投稿一覧・詳細の閲覧 | 投稿検索 |
| ---- | ---- |
|![Image]() | ![Image]() |
| TOPページから投稿一覧画面へ遷移できます。<br>詳細画面では各投稿のアイテム情報やお手入れ情報を閲覧できます。 | TOPページから検索画面へ遷移し、希望の条件を選択肢から選びます。<br>公開されている投稿の「アイテム情報」を検索対象とし、一致する投稿がある場合、結果画面に表示されます。 |

### 新規登録の入口(画面)別に権限を自動付与
| 一般ユーザーの登録入口 | ブランド用の登録入口 |
| ---- | ---- |
|![Image]() | ![Image]() |
| 新規登録画面からは、入力またはGoogleログインを使用して登録ができます。<br>この画面からの登録の場合、「一般ユーザー」の権限付与となります。 | 新規登録画面下部の「ブランド登録入口」からブランド新規登録画面に遷移し登録した場合、「ブランド」の権限付与となります。<br>ブランド権限のみの追加機能が使用できるようになります。 |


### ログイン後に使用可能な機能(一般ユーザー、ブランド権限共通)
| 投稿作成 | 非公開・下書き保存 | お気に入り登録 |
| ---- | ---- | ---- |
|![Image]() | ![Image]() | ![Image]() |
| 画像、キャプション、アイテム情報、お手入れ情報の登録が可能です。 | 投稿のステータスを非公開、下書き保存にした場合はマイページから閲覧できます。 | 投稿一覧または投稿詳細画面でお気に入りに登録ができます。<br>また、お気に入りに登録した投稿を一覧で確認できます。 |

| マイページ | 登録情報の編集 |
| ---- | ---- |
|![Image]() | ![Image]() |
| 登録済のユーザー名・アバター画像と、自分の投稿をステータス別で確認できます。 | ユーザー情報の編集、パスワード変更、アカウント削除を行えます。 |

### ログイン後に使用可能な機能(ブランド権限のみの追加機能)
| 商品情報の登録 | 登録済商品一覧 |
| ---- | ---- |
|![Image]() | ![Image]() |
| 商品名、商品画像の登録が可能です。 | 登録した商品は一覧で確認できます。 |

| 投稿作成画面、詳細画面での表示(自動で反映) | 検索画面で選択肢に表示(自動で反映) |
| ---- | ---- |
|![Image]() | ![Image]() |
| ユーザー名(＝ブランド名)と商品名は、投稿作成画面の「アイテム情報」で選択肢に表示され、<br>全ユーザーが投稿作成時に選択・登録できるようになります。<br>アイテム情報に登録された場合、投稿詳細ページでは商品画像も一緒に表示されます。 | 検索画面でもブランド名と商品名が検索条件の選択肢に表示されます。 |


## ■ 使用技術
| カテゴリ | 技術 |
|  ---  |  ---  |
| フロントエンド | Ruby on Rails 7.2.2.1(Hotwire/Turbo/Stimulus) / TailwindCSS / DaisyUI / Javascript |
| バックエンド | Ruby on Rails 7.2.2.1 (Ruby 3.2.3 ) |
| データベース | PostgreSQL |
| インフラ | Render.com / AmazonS3 |
| 開発環境 | Docker |
| 認証 | Sorcery / Googleログイン |

## ■ 画面遷移図 #後で修正
https://www.figma.com/design/jnOgeZSlBRqvVxVc4GKm6W/%E3%82%A2%E3%83%97%E3%83%AA%E9%96%8B%E7%99%BA?node-id=15-2&t=7VhAFGoEFCTfJDu4-1

## ■ ER図
[![Image from Gyazo](https://i.gyazo.com/f94c2e4a9a939b23e871d92d4f3c14ad.png)](https://gyazo.com/f94c2e4a9a939b23e871d92d4f3c14ad)