return {
  {
    "benomahony/uv.nvim",
    ft = "python", 
    opts = {
      auto_activate_venv = true,
      picker_integration = true,
    },
    keys = {
      { "<leader>xr", "<cmd>UVRunFile<cr>", desc = "Run current file (uv)" },
      { "<leader>xe", "<cmd>UVAutoActivateToggle<cr>", desc = "Toggle UV Auto-activate" },
      { "<leader>xa", "<cmd>UVAdd<cr>", desc = "Add package (uv)" },
      { "<leader>xs", ":UVRunSelection<cr>", mode = "v", desc = "Run selection (uv)" },
    },
  },
}
