return {
  -- format
  {
    "stevearc/conform.nvim",
    event = "BufWritePre", -- uncomment for format on save
    opts = require "configs.conform",
  },

  -- lsp
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },

  -- install lsp plugins
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        -- lua stuff
        "lua-language-server",
        "stylua",

        -- web dev stuff
        "biome",
        "css-lsp",
        "deno",
        "dockerfile-language-server",
        "eslint_d",
        "html-lsp",
        "json-lsp",
        "prisma-language-server",
        "prettierd",
        "tailwindcss-language-server",
        "typescript-language-server",
        "yamlfmt",

        -- python stuff
        "pyright",
        "ruff",

        -- shell
        "shfmt",
        "shellcheck",
        "bash-language-server",
      },
    },
  },

  -- install ts plugins
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "css",
        "bash",
        "dart",
        "dockerfile",
        "html",
        "javascript",
        "json",
        "lua",
        "markdown",
        "markdown_inline",
        "prisma",
        "python",
        "scss",
        "toml",
        "tsx",
        "typescript",
        "vim",
        "yaml",
      },

      highlight = {
        enable = true,
      },

      indent = {
        enable = true,
      },

      autotag = {
        enable = true,
        enable_rename = true,
        enable_close = true,
        enable_close_on_slash = true,
        filetypes = {
          "javascript",
          "javascriptreact",
          "typescript",
          "typescriptreact",
          "html",
          "svelte",
          "vue",
          "markdown",
        },
      },

      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "gnn",
          node_incremental = "grn",
          scope_incremental = "grc",
          node_decremental = "grm",
        },
      },
    },
    dependencies = {
      {
        "windwp/nvim-ts-autotag",
        config = function()
          require "nvim-ts-autotag"
        end,
      },
    },
  },

  -- smooth scroll
  {
    "karb94/neoscroll.nvim",
    keys = { "<C-d>", "<C-u>" },
    config = function()
      require "neoscroll"
    end,
  },

  -- dim inactive windows
  {
    "andreadev-it/shade.nvim",
    config = function()
      require("shade").setup {
        exclude_filetypes = { "NvimTree" },
      }
    end,
  },

  -- pretty diagnostics panel
  {
    "folke/trouble.nvim",
    cmd = { "Trouble", "TodoTrouble" },
    dependencies = {
      {
        "folke/todo-comments.nvim",
        opts = {},
      },
    },
    config = function()
      require "trouble"
    end,
  },

  -- file/word search
  {
    "nvim-telescope/telescope.nvim",
    opts = {
      extensions_list = { "fzf", "terms", "nerdy", "media" },

      extensions = {
        media = {
          backend = "ueberzug",
        },
      },
    },

    dependencies = {
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
      "2kabhishek/nerdy.nvim",
      "dharmx/telescope-media.nvim",
    },
  },

  "NvChad/nvcommunity",

  { import = "nvcommunity.editor.telescope-undo" },
}
