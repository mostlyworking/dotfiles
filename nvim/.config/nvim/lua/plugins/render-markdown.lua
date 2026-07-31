return {
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    build = function()
      -- This triggers the plugin's internal install script
      vim.fn["mkdp#util#install"]()
    end,
  }
}
