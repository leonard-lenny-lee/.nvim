return {
  check = function()
    vim.health.start 'Personal Neovim configuration'
    if vim.fn.has 'nvim-0.11.3' == 1 then
      vim.health.ok('Neovim ' .. tostring(vim.version()))
    else
      vim.health.warn 'Use Neovim 0.11.3 or newer: this is the installed nvim-lspconfig minimum.'
    end
    if vim.fn.has 'nvim-0.12' == 1 then
      vim.health.warn 'Review the Treesitter migration and mini.ai mappings in README.md before updating plugins.'
    end
    for _, executable in ipairs { 'git', 'make', 'unzip', 'rg' } do
      if vim.fn.executable(executable) == 1 then
        vim.health.ok('Found ' .. executable)
      else
        vim.health.warn('Missing ' .. executable)
      end
    end
  end,
}
