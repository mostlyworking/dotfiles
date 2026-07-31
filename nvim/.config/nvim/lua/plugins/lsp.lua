return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        pyright = { enabled = false },
        basedpyright = { enabled = false },
        jedi_language_server = { enabled = false },

        ty = {},
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      -- Register ty LSP config before lspconfig tries to set up servers.
      -- ty is too new to have a built-in config in lspconfig.
      local lspconfig = require("lspconfig")
      if not lspconfig.configs["ty"] then
        lspconfig.configs["ty"] = {
          default_config = {
            cmd = { "ty", "server" },
            filetypes = { "python" },
            root_dir = lspconfig.util.root_pattern("pyproject.toml", "setup.py", "setup.cfg", "requirements.txt", "Pipfile"),
            single_file_support = true,
          },
        }
      end
    end,
  },
}
