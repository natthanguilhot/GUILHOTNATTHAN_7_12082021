module.exports = {
  mode: 'jit',
  purge: ['./index.html', './src/**/*.{vue,js,ts,jsx,tsx}'],
  darkMode: 'class', // or 'media' or 'class'
  theme: {
    extend: {},
    colors: {
      default: '#FD2D01',
    },
  },
  variants: {
    extend: {},
  },
  plugins: [],
}
