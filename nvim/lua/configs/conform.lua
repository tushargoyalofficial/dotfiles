local options = {
  formatters_by_ft = {
    lua = { "stylua" },

    javascript = { "biome" },
    javascriptreact = { "biome" },
    typescript = { "biome" },
    typescriptreact = { "biome" },

    css = { "biome" },
    html = { "biome" },
    json = { "biome" },
    jsonc = { "biome" },

    sh = { "shfmt" },
    python = {
      "isort",
      "ruff_fix",
      "ruff_format",
    },
    dart = { "dart_format" },
    yaml = { "yamlfmt" },
  },

  format_on_save = {
    -- These options will be passed to conform.format()
    timeout_ms = 500,
    lsp_fallback = true,
  },
}

return options
