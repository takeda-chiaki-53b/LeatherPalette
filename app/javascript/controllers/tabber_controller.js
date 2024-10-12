import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["tab_menu", "content"] //HTMLの中でこのクラスが管理する要素の名前

  tab_menuClick(event) {
    event.preventDefault() // デフォルトの動作(ページのリロードやスクロール位置のリセット)を防ぐ
    const tab_menus = this.tab_menuTargets // メニューバー全体の要素
    const current = event.currentTarget // クリックしたメニューバーの要素（現在地）
    const currentIndex = tab_menus.indexOf(current) // クリックしたメニューバーのインデックス番号
    const contents = this.contentTargets // コンテンツ全体の要素

    // 初期化（全てのタブを非アクティブにし、コンテンツを隠す）
    tab_menus.forEach((tab_menu, index) => {
      tab_menu.classList.remove("active-tab", "text-blue-600", "border-b-2", "border-blue-600", "dark:text-blue-500", "dark:border-blue-500")
      tab_menu.classList.add("not-active", "text-gray-500", "border-b-2", "border-transparent", "hover:text-gray-600", "hover:border-gray-300", "dark:hover:text-gray-300")
      contents[index].classList.add("hidden")
    })
    // tab_menusの中にある全てのタブメニューに対して、ひとつずつ処理を行う
    // 現在のタブからactive-tabクラスを削除
    // 取り除いたクラスの代わりにnot-activeクラスを追加
    // 現在のタブに対応するコンテンツを隠す


    // クリックしたタブをアクティブにし、対応するコンテンツを表示する
    current.classList.remove("not-active", "text-gray-500", "border-b-2", "border-transparent", "hover:text-gray-600", "hover:border-gray-300", "dark:hover:text-gray-300")
    current.classList.add("active-tab", "text-blue-600", "border-b-2", "border-blue-600", "dark:text-blue-500", "dark:border-blue-500")
    contents[currentIndex].classList.remove("hidden")
    // 現在選択されているタブ（current）から、not-activeクラスを削除する
    // 現在のタブにactive-tabクラスを追加してアクティブである（選択されている）ことを示す
    // 現在選択されているタブに対応するコンテンツを表示するための処理
  }
}