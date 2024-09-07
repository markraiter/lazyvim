local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  spec = {
    -- add LazyVim and import its plugins
    { "LazyVim/LazyVim", import = "lazyvim.plugins" },
    -- import/override with your plugins
    { import = "plugins" },
    -- {
    --   "rebelot/kanagawa.nvim",
    --   config = function()
    --     require("kanagawa").setup({
    --       -- You can customize the theme settings here
    --     })
    --     vim.cmd.colorscheme("kanagawa")
    --   end,
    -- },
    {
      "projekt0n/github-nvim-theme",
      config = function()
        require("github-theme").setup({
          -- Дополнительные настройки для темы можно добавить здесь
        })
        vim.cmd.colorscheme("github_dark_default") -- Активируем GitHub Dark Default тему

        -- Настройка lualine для использования темы GitHub
        require("lualine").setup({
          options = {
            theme = "auto", -- Устанавливаем тему lualine в стиле GitHub
          },
        })
      end,
    },
    {
      "nvim-lualine/lualine.nvim",
      opts = {
        options = {
          theme = {
            normal = {
              a = { fg = "#ffffff", bg = "#d7af5f", gui = "bold" },
              b = { fg = "#ffffff", bg = "#444444" },
              c = { fg = "#ffffff", bg = "#303030" },
            },
            insert = {
              a = { fg = "#ffffff", bg = "#87af5f", gui = "bold" },
              b = { fg = "#ffffff", bg = "#444444" },
              c = { fg = "#ffffff", bg = "#303030" },
            },
            visual = {
              a = { fg = "#ffffff", bg = "#af5f87", gui = "bold" },
              b = { fg = "#ffffff", bg = "#444444" },
              c = { fg = "#ffffff", bg = "#303030" },
            },
            replace = {
              a = { fg = "#ffffff", bg = "#af5f5f", gui = "bold" },
              b = { fg = "#ffffff", bg = "#444444" },
              c = { fg = "#ffffff", bg = "#303030" },
            },
            command = {
              a = { fg = "#ffffff", bg = "#5f87af", gui = "bold" },
              b = { fg = "#ffffff", bg = "#444444" },
              c = { fg = "#ffffff", bg = "#303030" },
            },
            inactive = {
              a = { fg = "#aaaaaa", bg = "#303030" },
              b = { fg = "#aaaaaa", bg = "#303030" },
              c = { fg = "#aaaaaa", bg = "#303030" },
            },
          },
        },
        sections = {
          lualine_a = { "mode" },
          lualine_b = { "branch" },
          lualine_c = { "filename" },
          lualine_x = { "encoding", "fileformat", "filetype" },
          lualine_y = { "progress" },
          lualine_z = { "location" },
        },
      },
    },
    {
      "neovim/nvim-lspconfig",
      opts = {
        setup = {
          rust_analyzer = function()
            return true -- Prevent nvim-lspconfig from setting up rust_analyzer
          end,
        },
      },
    },
    {
      "nvim-neo-tree/neo-tree.nvim",
      config = function()
        require("neo-tree").setup({
          filesystem = {
            filtered_items = {
              hide_dotfiles = false, -- Show other dotfiles
              hide_gitignored = false, -- Show files ignored by .gitignore
              hide_by_name = { ".git" }, -- Hide only the .git folder
            },
          },
        })
      end,
    },
  },
  defaults = {
    -- By default, only LazyVim plugins will be lazy-loaded. Your custom plugins will load during startup.
    -- If you know what you're doing, you can set this to `true` to have all your custom plugins lazy-loaded by default.
    lazy = false,
    -- It's recommended to leave version=false for now, since a lot the plugin that support versioning,
    -- have outdated releases, which may break your Neovim install.
    version = false, -- always use the latest git commit
    -- version = "*", -- try installing the latest stable version for plugins that support semver
  },
  -- install = { colorscheme = { "tokyonight", "habamax" } },
  checker = {
    enabled = true, -- check for plugin updates periodically
    notify = false, -- notify on update
  }, -- automatically check for plugin updates
  performance = {
    rtp = {
      -- disable some rtp plugins
      disabled_plugins = {
        "gzip",
        -- "matchit",
        -- "matchparen",
        -- "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})
