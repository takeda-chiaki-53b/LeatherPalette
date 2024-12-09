module.exports = {
  content: [
    './app/views/**/*.html.erb',
    './app/helpers/**/*.rb',
    './app/assets/stylesheets/**/*.css',
    './app/javascript/**/*.js'
  ],
  plugins: [require("daisyui")],

  theme: {
    extend: {
      colors: {
        'darkgray':'#333333',
        'beige':'#dbd1c7',
        'mocha':'#847366',
        'darkbrown':'#5f534a',
        'orange':'#d69b71'
      },
      fontfamily: {
        'noto':['Noto Serif JP', 'serif'],
        'shippori-mincho':['Shippori Mincho', 'serif'],
        'zen-300':['Zen Kaku Gothic New', 'sans-serif'],
        'zen-400':['Zen Kaku Gothic New', 'sans-serif'],
      },
    }
  }
}
