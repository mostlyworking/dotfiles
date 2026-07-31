return {
  "mfussenegger/nvim-lint",
  opts = {
    linters = {
      ["markdownlint-cli2"] = {
        -- Force the linter to use our global config file
        args = { "--config", vim.fn.expand("~/.markdownlint.json"), "--" },
      },
    },
  },
}
