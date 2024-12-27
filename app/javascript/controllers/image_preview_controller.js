import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="image-preview"
export default class extends Controller {
  static targets = ["input", "preview", "existing"]

  previewImage() {
    const input = this.inputTarget // htmlの画像読込の要素
    const preview = this.previewTarget // htmlのプレビューを表示させる要素
    const files = input.files // ユーザーが選択したファイル
    const width = this.data.get('width')　// htmlで指定した画像の幅
    const height = this.data.get('height')　// htmlで指定した画像の高さ
    const existing = this.existingTarget　// キャッシュや登録済の画像を表示する要素

    // 既存の画像を非表示にする
    if (existing) {
      existing.style.display = 'none';
    }

    // filesは<input type="file"> 要素で選択されているファイルのリスト
    // filesは空でもFileListオブジェクトは存在するのでtrueとなる
    // files[0]はfilesリストの最初の要素を示している。
    // 「ユーザーが少なくとも1つのファイルを選択していて、それにアクセスできる状態である」という条件文
    if (files && files[0]) {
    const reader = new FileReader() // 変数readerをFileReaderオブジェクトとして定義。非同期にファイルを読み込むことができる

    // 変数readerにファイル読み込みが完了した(onload)場合に、実行される関数。(e)はイベントオブジェクト。
    reader.onload = (e) => {
        preview.innerHTML = `<img src="${e.target.result}" style="max-width: ${width}px; max-height: ${height}px;">`;
        }
        // previewのターゲット要素にHTMLを追加する
        // e.target.resultには読み込んだファイルの内容が含まれており、これはBase64エンコーディングされたデータURLの形式で提供される
        // このデータURLを画像のsrc属性に設定することで、ブラウザ上に画像を直接表示することが可能になる
    reader.readAsDataURL(files[0])
    // readerに対してreadAsDataURLメソッドを使う
    // readAsDataURLメソッドはfileの内容を読み込み、データURLとして返す(Base64エンコーディングされた文字列)メソッド
    // ユーザーがfilesからファイルを選択した時、そのファイルはfiles配列の0番目に格納されるので内容を非同期に読み込み、その内容をデータURLとして保持
    // 読み込みが完了すると、FileReader オブジェクトの onload イベントが発火
    // 読み込まれたファイルのデータは e.target.result を通じてアクセス可能になる
    }
  }
}
