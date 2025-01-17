module.exports = {
  content: [
    './app/views/**/*.html.erb',
    './app/helpers/**/*.rb',
    './app/assets/stylesheets/**/*.css',
    './app/javascript/**/*.js'
  ],
  plugins: [require("daisyui")],

  daisyui: {
    themes: [
      {
        mytheme: {
          "neutral": "#f3eae1", //　画像選択のボタン
          "base-100": "#fafafa", // フォームの入力エリア
        },
      },
    ],
    // ダークモードをオフ
    darkTheme: false
  },

  theme: {
    extend: {
      colors: {
        'darkgray':'#333333', // topアプリ名
        'beige':'#dbd1c7', // 背景
        'mocha':'#938073', // topアプリ名の上のフレーズ
        'darkbrown':'#5f534a', // テキスト全版
        'light_orange':'#E6CCB585', // top見てみるボタン
        'orange':'#fdba74', // top見てみるボタン
        'natural':'#f3eae1', // ヘッダーロゴ枠、ボタンテキスト
        'gray1':'#e5e5e5', // 削除ボタン
        'gray2':'#a3a3a3', // 削除ボタンホバー
      },
    }
  }
}
