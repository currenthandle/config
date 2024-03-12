return {
  {
    "numToStr/Comment.nvim",
    config = function()
      require("Comment").setup({
        pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
      })
    end,
    opts = {},
  },
  {
    "JoosepAlviste/nvim-ts-context-commentstring",
    config = function()
      -- Set skip_ts_context_commentstring_module to speed up loading
      vim.g.skip_ts_context_commentstring_module = true

      -- Plugin setup with specific configuration
      require("ts_context_commentstring").setup({
        -- Disable autocmd if desired
        enable_autocmd = false,
      })
    end,
  },
}
