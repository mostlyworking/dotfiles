return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        pyright = { enabled = false },
        basedpyright = { enabled = false },
        jedi_language_server = { enabled = false },

        ty = {
          on_new_config = function(config, root_dir)
            local function exists(path)
              return vim.uv.fs_stat(path) ~= nil
            end

            local function is_tool_only_uv_project(dir)
              local path = dir .. "/pyproject.toml"
              local file = io.open(path, "r")
              if not file then
                return false
              end

              local contents = file:read("*a")
              file:close()
              return contents:find("package%s*=%s*false") ~= nil
            end

            local function git_root(start_dir)
              local result = vim.system(
                { "git", "-C", start_dir, "rev-parse", "--show-toplevel" },
                { text = true }
              ):wait()

              if result.code ~= 0 then
                return nil
              end

              return vim.trim(result.stdout)
            end

            local function highest_uv_project(start_dir)
              local repo_root = git_root(start_dir)
              local highest = nil
              local dir = start_dir

              while dir do
                if
                  exists(dir .. "/pyproject.toml")
                  and exists(dir .. "/uv.lock")
                  and not is_tool_only_uv_project(dir)
                then
                  highest = dir
                end

                if dir == repo_root then
                  break
                end

                local parent = vim.fs.dirname(dir)
                if parent == dir then
                  break
                end
                dir = parent
              end

              return highest
            end

            local project = highest_uv_project(root_dir)
            if project then
              config.cmd = { "uv", "run", "--project", project, "ty", "server" }
            else
              config.cmd = { "ty", "server" }
            end
          end,
        },
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
            root_dir = lspconfig.util.root_pattern(
              "pyproject.toml",
              "setup.py",
              "setup.cfg",
              "requirements.txt",
              "Pipfile"
            ),
            single_file_support = true,
          },
        }
      end
    end,
  },
}
