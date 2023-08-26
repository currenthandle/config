local M = {}

M.format = function()
    local current_file = vim.fn.expand('%:p')

    -- Save the buffer to disk.
    vim.cmd('write')
    
    -- Format the file on disk using prettierd.
    local result = vim.fn.system('prettierd ' .. current_file, vim.api.nvim_buf_get_lines(0, 0, -1, false))
    
    if vim.v.shell_error == 0 then
        vim.api.nvim_buf_set_lines(0, 0, -1, false, vim.fn.split(result, '\n'))
    else
        print("Error formatting with prettierd")
    end
end

vim.cmd([[
  augroup PrettierdAutogroup
    autocmd!
    autocmd BufWritePre *.ts,*.tsx lua require'prettierd'.format()
  augroup END
]])

return M
