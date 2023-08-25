local M = {}

M.format = function()
  local bufname = vim.fn.expand('%:p')  -- Get full path of the current buffer
  vim.cmd(string.format('silent !pnpm prettier --write %s', bufname))
  vim.cmd('edit')  -- Reload the buffer to reflect changes
end

vim.cmd([[
  augroup PrettierAutogroup
    autocmd!
    autocmd BufWritePre *.ts,*.tsx,*.js,*.jsx,*.html,*.json,*.css,*.scss,*.md lua require'prettier'.format()
  augroup END
]])

return M
