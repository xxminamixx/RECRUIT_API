#リクルートAPIを用いたアプリ開発スケジュール  

##6月21日  
スケジュール作成  
実機デバッグ環境構築  
ホーム画面作成  


- [x] リクルートAPIによるアプリ開発のスケジュールを作成  
- [x] iPhone実機デバッグ方法調査  
- [x] iPhone実機デバッグ環境構築  
- [x] ホーム画面のUI作成→NavigationControllerと接続  
- [x] ホームボタンの都道府県検索ボタンから都道府県選択画面への接続  


##6月22日  
ホーム画面作成  
都道府県選択画面作成   

- [x] API通信のリクエスト作成 
- [x] リクエストの送信
- [x] レスポンスを受け取る  
- [x] レスポンスをCellに反映  
- [x] 都道府県一覧画面へ反映  

##6月23日  
検索結果画面作成  

- [x] 選択された都道府県でAPI通信のリクエスト作成  
- [x] リクエストの送信  
- [x] レスポンスを受信しエンティティに保存  
- [x] レスポンスをセルに反映  
- [x] 検索結果画面にお店の一覧を表示  

##6月24日  
詳細画面作成  

- [x] 詳細をEnthityから取得し、表示する  

##6月27日  
お気に入り画面作成  

- [x] 検索結果画面と詳細画面にお気に入りボタンを配置  
- [x] お気に入りボタンが押された時そのお店をManegerを介して保存  
- [x] お気に入り画面でデータベースのデータを参照し一覧表示  
- [x] 詳細画面のお気に入り機能実装  
- [x] 一覧画面のお気に入り機能実装
- [x] お気に入りステータス表示  

##6月28日  
タブバーとナビゲーションコントローラーの作成  

- [x] 遷移先の画面から前ページ、次ページへ遷移  
- [x] ホームボタンでホームへ遷移  
- [x] お気に入りボタンでお気に入り画面へ遷移  
- [x] 設定ボタンで設定画面へ遷移  

##6月29日  
設定画面作成  
確認画面作成  

- [x] 設定画面のお気に入り全削除ボタンを押した時、確認画面がモーダル  
- [x] 確認画面でお気に入り全削除ボタンを押しだ時、データベース内のデータ削除  

NavigationControllerのItem設定  

- [x] 各画面のタイトルを設定  
- [x] TabBarのItem名設定  
- [x] TabBarのアイコン設定  

##6月30日  

- [x] アプリアイコン設定  
- [x] 検索件数を設定するViewの作成  
- [x] 検索件数設定に伴うフェッチャーの修正  
- [x] アプリバージョン表示画面の作成  
  
##7月1日  
テスト  
バグ修正  
デザイン調整  

- [ ] 実機テスト  
- [ ] バグ修正  
- [ ] デザイン修正  
  
## 7月6日  
- [x] 単体テスト項目作成  
- [x] TableViewをAutoLayoutで調整   
- [x] 単体テスト  
- [ ] バグ修正  
  
## 7月7日 
- [x] 削除確定画面をUIAlertControllerで実装  
- [ ] 一覧画面、お気に入り画面のセルの高さを可変に変更 
  
## 7月8日  
- [ ] メモリリーク確認  
- [ ] メモリリーク処理
- [ ] iPadなど他の端末でもレイアウトの崩れがないように変更  
  
## 7月11日  
- [ ] XMLのパースをできるライブラリをCocoaPodsでインストール  
- [ ] XMLのパースライブラリを用いてフェッチャークラスを書き換え  
- [ ] クーポン情報取得処理  
- [ ] セルの高さをクーポンがあったら可変にする  
  
## 7月12日  
- [ ] フェッチャー読み込み後の動作をDelegateではなくBlocksで実装   
- [ ] API通信のリクエスト作成 
- [ ] リクエストの送信
- [ ] レスポンスを受け取る  
- [ ] レスポンスをCellに反映  
- [ ] ジャンル一覧画面へ反映  
  
## 7月13日  
- [ ] SVProgressHUDをCocoaPodsを使ってインストール 
- [ ] SVProgressHUDを使ってお気に入りした時のインジケータ表示処理  