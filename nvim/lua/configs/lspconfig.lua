require("nvchad.configs.lspconfig").defaults()

local servers = {
  "cssls",
  "dartls",
  "dockerls",
  "eslint",
  "html",
  "jsonls",
  "prismals",
  "pyright",
  "ruff",
  "tailwindcss",
  "ts_ls",
}
vim.lsp.enable(servers)

-- read :h vim.lsp.config for changing options of lsp servers
