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
    if (files && files[0]) {
    const reader = new FileReader() // 変数readerをFileReaderオブジェクトとして定義。非同期にファイルを読み込むことができる

    // 変数readerにファイル読み込みが完了した(onload)場合に、実行される関数。(e)はイベントオブジェクト。
    reader.onload = (e) => {
        preview.innerHTML = `<img src="${e.target.result}" style="max-width: ${width}px; max-height: ${height}px;">`;
        }

    reader.readAsDataURL(files[0])
    }
  }
}
