import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["tab_menu", "content"]

  tab_menuClick(event) {
    event.preventDefault() // デフォルトの動作(ページのリロードやスクロール位置のリセット)を防ぐ
    const tab_menus = this.tab_menuTargets // メニューバー全体の要素
    const current = event.currentTarget // クリックしたメニューバーの要素（現在地）
    const currentIndex = tab_menus.indexOf(current) // クリックしたメニューバーのインデックス番号
    const contents = this.contentTargets // コンテンツ全体の要素

    // 初期化（全てのタブを非アクティブにし、コンテンツを隠す）
    tab_menus.forEach((tab_menu, index) => {
      tab_menu.classList.remove("is-active", "active-tab", "text-blue-600", "border-blue-600")
      tab_menu.classList.add("not-active", "text-gray-500", "border-transparent")
      contents[index].classList.add("hidden")
    })

    // クリックしたタブをアクティブにし、対応するコンテンツを表示する
    current.classList.remove("not-active", "text-gray-500", "border-transparent")
    current.classList.add("is-active", "active-tab", "text-blue-600", "border-blue-600")
    contents[currentIndex].classList.remove("hidden") // クリックした要素のコンテンツを表示する

    // ホバーのスタイルを選択時に無効にする
    tab_menus.forEach(tab_menu => {
      if (!tab_menu.classList.contains("is-active")) {
        tab_menu.classList.add("hover:text-blue-600", "hover:border-blue-600")
      }
    })
  }
}