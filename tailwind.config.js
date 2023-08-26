/** @type {import('tailwindcss').Config} */
module.exports = {
  content: ["./hugo_stats.json"],
  plugins: [require("@tailwindcss/typography")],
};
