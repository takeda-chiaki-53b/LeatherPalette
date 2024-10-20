import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="search"
export default class extends Controller {
  static targets = ["condition"] //HTMLの中でこのクラスが管理する要素の名前

  // ページが読み込まれたときに各ボタンを押したときの詳細条件を非表示にする
  connect() {
    this.conditionTargets.forEach((element) => {
      element.classList.add("hidden")
    })
  }

  // 検索方法を選択したときの処理
  select(event) {
    event.preventDefault() // デフォルトの動作をキャンセル

    const selected = event.currentTarget.dataset.condition
    // 押されたボタンのデータ属性から選択された条件を取得
    // currentTargetは、イベントが発生した要素のこと

    // すべての条件を非表示にする
    this.conditionTargets.forEach((element) => {
      element.classList.add("hidden")
    })
    // this.conditionTargetsで先に定義した「condition」ターゲットの要素をすべて取得し、forEachは、それぞれの要素に対して処理を行う
    // element.classList.add("hidden")ですべての条件要素にhiddenクラスを追加して非表示にしている


    // 選択された条件だけを表示する
    const targetElement = this.conditionTargets.find((element) =>
      element.dataset.condition === selected
    )
    // findメソッドを使って、選択された条件に合った要素を探しマッチする要素が見つかると、targetElementに格納される
    // 条件が選択されたものと一致するかをチェック。datasetは、HTMLのデータ属性にアクセスするための方法。

    if (targetElement) {
      targetElement.classList.remove("hidden")
    }
    // 見つかった要素からhiddenクラスを削除して、その要素を表示するようにしている


    // すべてのボタンからactiveクラスを削除
    this.element.querySelectorAll('[data-action="click->search#select"]').forEach((button) => {
      button.classList.remove("active", "bg-[#fdba74]")
    })

    // 選択されたボタンにactiveクラスを追加
    event.currentTarget.classList.add("active", "bg-[#fdba74]")
  }
}
