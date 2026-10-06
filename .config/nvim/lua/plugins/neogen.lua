return {
  "danymat/neogen",
  -- dependencies = { "L3MON4D3/LuaSnip" },
  opts = {
    -- snippet_engine = "luasnip",
    enabled = true,
    languages = {
      python = {
        template = {
          annotation_convention = "google_docstrings",
        },
      },
    },
  },
  keys = {
    { "<leader>cg", "<cmd>Neogen<CR>", desc = "Generate Docstring (Neogen)" },
  },
}
