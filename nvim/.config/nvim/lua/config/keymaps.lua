-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]], { desc = "Exit Terminal Mode" })
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(event)
    local opts = { buffer = event.buf, desc = "Go to Definition (Vertical Split)" }

    -- Option A: Mnemonic (Vertical Definition)
    vim.keymap.set("n", "<leader>vd", function()
      vim.cmd("vsplit")
      vim.lsp.buf.definition()
    end, opts)

    -- Option B: Tmux style
    vim.keymap.set("n", "<leader>%", function()
      vim.cmd("vsplit")
      vim.lsp.buf.definition()
    end, opts)
  end,
})
