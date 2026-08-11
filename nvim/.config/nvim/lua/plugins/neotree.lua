return {
  "nvim-neo-tree/neo-tree.nvim",
  opts = {
    sources = { "filesystem" },
    default_source = "filesystem",
    source_selector = {
      winbar = false,
      statusline = false,
    },
    enable_diagnostics = false,
    enable_git_status = true,
    enable_modified_markers = false,
    enable_opened_markers = false,
    enable_refresh_on_write = false,
    filesystem = {
      scan_mode = "shallow",
      bind_to_cwd = false,
      follow_current_file = { enabled = false },
      use_libuv_file_watcher = true,
      filtered_items = {
        visible = true,
        hide_dotfiles = false,
        hide_gitignored = false,
        hide_by_name = {},
      },
    },
    event_handlers = {
      {
        event = "neo_tree_buffer_enter",
        handler = function()
          local state = require("neo-tree.sources.manager").get_state_for_window()
          if state and state.path then
            local root = vim.fn.fnamemodify(state.path, ":t")
            vim.wo.winbar = "  " .. root
          end
        end,
      },
    },
  },
}
