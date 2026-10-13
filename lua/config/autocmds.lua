vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('config-highlight-yank', { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

-- Keep filename-based TeX/Markdown rules and their original event timing.
vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
  pattern = { '*.tex' },
  callback = function()
    vim.bo.filetype = 'tex'
    vim.opt_local.spell = true
    vim.opt_local.spelllang = 'en_gb'
    vim.opt_local.shiftwidth = 4
    vim.opt_local.tabstop = 4
    vim.opt_local.expandtab = true
  end,
})

vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
  pattern = { '*.md' },
  callback = function()
    vim.opt_local.spell = true
    vim.opt_local.spelllang = 'en_gb'
  end,
})
