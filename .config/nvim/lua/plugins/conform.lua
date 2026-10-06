return {
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    opts = {
      formatters_by_ft = {
        python = { "ruff", lsp_format = "fallback" },
        sh = { "shfmt" },
        lua = { "stylua" },
      },
      formatters = {
        shfmt = {
          append_args = { "-i", "2", "-ci" },
        },
      },
      -- format_on_save = {
      --   timeout_ms = 1000,
      --   lsp_format = "fallback",
      --   },
    },
  },
}
