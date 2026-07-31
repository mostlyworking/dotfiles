return {
  "nvim-treesitter/nvim-treesitter-context",
  enabled = true,
  opts = {
    max_lines = 1,
    min_window_height = 0,
    line_numbers = true,
    multiline_threshold = 5,
    trim_scope = "outer",

    custom_by_bufname = function(bufname)
      if string.match(bufname, "list://") or string.match(bufname, "snacks") then
        return false
      end
      return true
    end,
  },
}
