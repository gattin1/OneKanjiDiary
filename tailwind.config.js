module.exports = {
  content: [
    './app/views/**/*.html.erb',
    './app/helpers/**/*.rb',
    './app/assets/stylesheets/**/*.css',
    './app/javascript/**/*.js'
  ],
  plugins: [require("daisyui")],
  daisyui: {
    themes: false, // デフォルトテーマを無効にする
  },

  theme: {
    extend: {
      fontFamily: {
        yuji: ['Yuji Mai', 'serif'],
        zen: ['Zen Old Mincho', 'serif'],
      },
      screens: {
        'xs': '410px', // 400pxのカスタムブレイクポイントを追加
      },
    }
  }
}
