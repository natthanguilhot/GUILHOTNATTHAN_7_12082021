module.exports = {
  mode: 'jit',
  purge: ['./index.html', './src/**/*.{vue,js,ts,jsx,tsx}'],
  darkMode: 'class', // or 'media' or 'class'
  theme: {
    extend: {
      colors: {
        primary: '#FD2D01',
        secondary: '#FFD7D7',
      },
    },
  },
  variants: {
    extend: {},
  },
  plugins: [],
}
