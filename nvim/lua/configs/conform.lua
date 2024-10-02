local options = {
  formatters_by_ft = {
    lua = { "stylua" },

    javascript = { "biome" },
    javascriptreact = { "biome" },
    typescript = { "biome" },
    typescriptreact = { "biome" },

    css = { "prettierd" },
    html = { "prettierd" },
    json = { "biome" },
    jsonc = { "biome" },

    sh = { "shfmt" },
    python = { "black" },
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
