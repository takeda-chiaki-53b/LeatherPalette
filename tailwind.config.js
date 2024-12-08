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
        'beige': '#e6ddd5',
      },
      fontfamily: {
        'noto': ['Noto Serif JP', 'serif'],
        'shippori-mincho':['Shippori Mincho', 'serif']
      },
    }
  }
}
