import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="product-select"
export default class extends Controller {
  static targets = ["products"]

  // 投稿画面で使用
  onChange(event) {
    const brandAdminId = event.target.value

    // ブランドが未選択の場合、商品セレクトボックスを初期化
    if (!brandAdminId) {
      this.productsTarget.innerHTML = "<option value=''>ブランドを選択</option>"
      return
    }

    this.updateProducts(brandAdminId) // 商品一覧を更新するメソッドを呼び出す。（イベントが発火した時の値を取得＝セレクトボックスの値）
  }

  updateProducts(brandAdminId) {
    fetch(`/posts/${brandAdminId}/product_select.json`)
    .then(response => response.json())
    .then(data => {
      if (data.length === 0) {
        // 登録商品がない場合
        this.productsTarget.innerHTML = "<option value=''>登録商品なし</option>"
      } else {
        // 登録商品がある場合
        let options = data.map(product => `<option value="${product.id}">${product.product_name}</option>`)
        this.productsTarget.innerHTML = options.join("")
      }
    })
  }


  // 検索画面で使用
  brandChange(event) {
    const brandAdminId = event.target.value

    // ブランドが未選択の場合、商品セレクトボックスを初期化
    if (!brandAdminId) {
      this.productsTarget.innerHTML = "<option value=''>ブランドを選択</option>"
      return
    }

    this.changeProducts(brandAdminId) // 商品一覧を更新するメソッドを呼び出す。（イベントが発火した時の値を取得＝セレクトボックスの値）
  }

  changeProducts(brandAdminId) {
    console.log("商品検索メソッド呼び出しの確認!!!")
    fetch(`/searches/${brandAdminId}/product_select.json`)
    .then(response => response.json())
    .then(data => {
      if (data.length === 0) {
        // 登録商品がない場合
        this.productsTarget.innerHTML = "<option value=''>登録商品なし</option>"
      } else {
        // 登録商品がある場合
        let options = data.map(product => `<option value="${product.id}">${product.product_name}</option>`)
        this.productsTarget.innerHTML = options.join("")
      }
    })
  }
}
