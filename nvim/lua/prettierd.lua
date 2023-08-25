local M = {}

M.format = function()
  vim.cmd('silent %!cat % | prettierd %')
end

vim.cmd([[
  augroup PrettierdAutogroup
    autocmd!
    autocmd BufWritePre *.ts,*.tsx lua require'prettierd'.format()
  augroup END
]])

return M
