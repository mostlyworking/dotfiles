return {
  "Vigemus/iron.nvim",
  config = function()
    local iron = require("iron.core")
    local common = require("iron.fts.common")

    iron.setup({
      config = {
        scratch_repl = false,

        repl_definition = {
          python = {
            command = { "ipython", "--no-autoindent" },
            format = common.bracketed_paste_python,
            block_dividers = { "# %%", "#%%" },
            env = { PYTHON_BASIC_REPL = "1" },
          },
        },

        -- Open as a standard Neovim buffer
        repl_open_cmd = "enew",
      },

      keymaps = {
        send_motion = "<leader>rm",
        visual_send = "<leader>rv",
        send_file = "<leader>rf",
        send_line = "<leader>rl",
        send_paragraph = "<leader>rp",
        send_until_cursor = "<leader>ru",
        send_code_block = "<leader>rc",
        send_code_block_and_move = "<leader>rn",
        cr = "<leader>r<cr>",
        interrupt = "<leader>r<space>",
        exit = "<leader>rq",
        clear = "<leader>rx",
      },

      highlight = {
        italic = true,
      },
      ignore_blank_lines = true,
    })

    vim.api.nvim_create_autocmd("TermOpen", {
      callback = function(args)
        vim.bo[args.buf].buflisted = true

        vim.keymap.set("n", "<S-h>", "<cmd>bprevious<cr>", { buffer = args.buf, silent = true })
        vim.keymap.set("n", "<S-l>", "<cmd>bnext<cr>", { buffer = args.buf, silent = true })
      end,
    })
  end,

  keys = {
    { "<leader>rs", "<cmd>IronRepl<cr>", desc = "Start REPL" },
    { "<leader>rr", "<cmd>IronRestart<cr>", desc = "Restart REPL" },
    { "<leader>rF", "<cmd>IronFocus<cr>", desc = "Focus REPL" },
    { "<leader>rh", "<cmd>IronHide<cr>", desc = "Hide REPL" },
  },
}
