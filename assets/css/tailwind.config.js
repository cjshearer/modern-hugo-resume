/** @type {import('tailwindcss').Config} */
const tailwindConfig = {
  content: ["./layouts/**/*.html"],
  plugins: [require("@tailwindcss/typography")()],
  theme: {
    extend: {},
  },
  variants: {},
};

module.exports = tailwindConfig;
