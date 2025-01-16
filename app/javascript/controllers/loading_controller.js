import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="loading"
export default class extends Controller {
  static targets = ["button", "modal"];

  connect() {
    this.modalTarget.classList.add("hidden"); // 初期状態では非表示
  }

  showLoading(event) {
    event.preventDefault(); // 通常の送信を防ぐ
    this.buttonTarget.disabled = true; // ボタンを無効化
    this.modalTarget.classList.remove("hidden"); // モーダルを表示

    // 少し遅延させてフォームを送信
    setTimeout(() => {
      this.buttonTarget.form.submit(); // フォームを送信
    }, 100); // 100ミリ秒遅延
  }
}
