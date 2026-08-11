return {
  -- 1. Iron.nvim: The actual REPL engine that runs your code side-by-side
  {
    "Vigemere/iron.nvim",
    keys = {
      { "<leader>is", "<cmd>IronRepl<cr>", desc = "Start REPL" },
      { "<leader>ir", "<cmd>IronRestart<cr>", desc = "Restart REPL" },
      { "<leader>if", "<cmd>IronFocus<cr>", desc = "Focus REPL" },
    },
    opts = {
      config = {
        repl_definition = {
          python = {
            -- Use 'uv run' so it always uses your local project environment
            command = { "uv", "run", "python3" },
          },
        },
        -- Opens the REPL in a vertical split on the right
        repl_open_cmd = "vertical botright 80vsplit",
      },
      -- Automatically close the terminal when the REPL finishes
      should_close_on_exit = true,
      -- Don't highlight the terminal cursor to keep it clean
      ignore_blank_lines = true,
    },
  },

  -- 2. NotebookNavigator: The cell manager (# %%)
  {
    "GCBallesteros/NotebookNavigator.nvim",
    keys = {
      { "]h", function() require("notebook-navigator").move_cell "d" end, desc = "Next cell" },
      { "[h", function() require("notebook-navigator").move_cell "u" end, desc = "Prev cell" },
      { "<leader>X", function() require("notebook-navigator").run_cell() end, desc = "Run cell" },
      { "<leader>x", function() require("notebook-navigator").run_and_move() end, desc = "Run and move" },
    },
    dependencies = {
      "nvim-mini/mini.comment",
      "hkupty/iron.nvim", 
      "anuvyklack/hydra.nvim",
    },
    event = "VeryLazy",
    config = function(_, opts)
      local nn = require("notebook-navigator")
      nn.setup(opts)
    end,
    opts = {
      -- Tell it to use iron.nvim instead of molten
      repl_provider = "iron",
      -- Setting this to nil prevents the 'report_start' error you saw earlier
      activate_hydra_keys = nil, 
      show_hydra_hint = false,
    },
  },

  -- 3. Highlighting: Makes the # %% cell markers stand out visually
  {
    "nvim-mini/mini.hipatterns",
    event = "VeryLazy",
    opts = function()
      local nn = require("notebook-navigator")
      return {
        highlighters = {
          cells = nn.minihipatterns_spec, -- Adds background color to cell lines
        },
      }
    end,
  },
}
