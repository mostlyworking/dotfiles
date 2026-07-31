local cache_file = vim.fn.expand("~/.cache/nvim_theme")
local f = io.open(cache_file, "r")
local current_theme = "rose-pine"

if f then
  local saved_theme = f:read("*a")
  if saved_theme and saved_theme ~= "" then
    current_theme = saved_theme:gsub("%s+", "")
  end
  f:close()
end

return {
  -- The Themes
  { "maxmx03/solarized.nvim" },
  { "sainnhe/gruvbox-material" },
  { "rebelot/kanagawa.nvim" },
  { "catppuccin/nvim", name = "catppuccin" },
  { "sainnhe/everforest" },
  { "Everblush/nvim", name = "everblush" },
  { "rose-pine/neovim", name = "rose-pine" },
  { "vague-theme/vague.nvim" },
  { "https://codeberg.org/juanmilkah/anticuus.nvim" },
  { "DanVicenteIhanus/cobaltnext.nvim", name = "cobaltnext" },
  { "vague-theme/vague.nvim", name = "vague" },
  { "idr4n/github-monochrome.nvim", name = "monochrome" },
  { "ronisbr/nano-theme.nvim", name = "nano-theme" },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = current_theme,
    },
  },
}
