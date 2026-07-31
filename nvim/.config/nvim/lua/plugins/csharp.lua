return {
  -- 1. Configure Mason to use the custom Roslyn registry
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      opts.registries = {
        "github:mason-org/mason-registry",
        "github:Crashdummyy/mason-registry", -- The custom registry for Roslyn
      }
    end,
  },

  -- 2. Add the Roslyn.nvim plugin
  {
    "seblyng/roslyn.nvim",
    ft = "cs",
    opts = {
      -- "auto" will use default Neovim filewatching
      filewatching = "auto",
      -- Add Razor support as per the documentation
      extensions = {
        razor = { enabled = true },
      },
    },
    config = function(_, opts)
      require("roslyn").setup(opts)

      -- 3. Configure LSP settings (Inlay hints, CodeLens, etc.)
      -- Note: This uses the standard Neovim LSP config interface
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          if client and client.name == "roslyn" then
            -- Enable Inlay Hints if you like them
            if vim.lsp.inlay_hint then
              vim.lsp.inlay_hint.enable(true, { bufnr = args.buf })
            end
          end
        end,
      })

      -- Set specific Roslyn settings
      -- This matches the vim.lsp.config block from the docs
      local lsp_config = {
        settings = {
          ["csharp|inlay_hints"] = {
            csharp_enable_inlay_hints_for_implicit_object_creation = true,
            csharp_enable_inlay_hints_for_implicit_variable_types = true,
          },
          ["csharp|code_lens"] = {
            dotnet_enable_references_code_lens = true,
          },
        },
      }

      -- Apply settings to roslyn via the newer Neovim LSP API
      -- (This replaces the old manual vim.lsp.config call)
      require("roslyn").setup(vim.tbl_deep_extend("force", opts, lsp_config))
    end,
  },
}
