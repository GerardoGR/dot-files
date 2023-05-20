vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]])

-- Taken from: https://github.com/wbthomason/packer.nvim#bootstrapping
local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim' -- Packer can manage itself

  use 'overcache/NeoSolarized'
  use 'airblade/vim-gitgutter'
  use 'tpope/vim-commentary'

  use 'tpope/vim-fugitive'

  use 'neovim/nvim-lspconfig'
  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-nvim-lsp'
  local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
  use({
      "jose-elias-alvarez/null-ls.nvim",
      config = function()
          local null_ls = require('null-ls')
          null_ls.setup({
              sources = {
                  null_ls.builtins.formatting.trim_whitespace,
                  null_ls.builtins.formatting.trim_newlines,

                  null_ls.builtins.diagnostics.cfn_lint,

                  null_ls.builtins.formatting.eslint_d,

                  null_ls.builtins.diagnostics.pylint.with({
                      -- Using asdf-python introduces a lot of lag, hence the timeout
                      timeout = 10000,
                  }),
                  null_ls.builtins.formatting.black,
                  null_ls.builtins.formatting.isort,

                  null_ls.builtins.diagnostics.hadolint,

                  null_ls.builtins.formatting.terraform_fmt,

                  null_ls.builtins.formatting.rustfmt,
              },
              on_attach = function(client, bufnr)
                  if client.supports_method("textDocument/formatting") then
                      vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
                      vim.api.nvim_create_autocmd("BufWritePre", {
                          group = augroup,
                          buffer = bufnr,
                          callback = function()
                            vim.lsp.buf.format({
                                filter = function(client)
                                    return client.name == "null-ls"
                                end,
                                bufnr = bufnr,
                            })
                          end,
                      })
                  end
              end,
              debug = true,
          })
      end,
      requires = { "nvim-lua/plenary.nvim" },
  })

  use {
    'nvim-telescope/telescope.nvim', tag = '0.1.1',
    requires = { 'nvim-lua/plenary.nvim', 'nvim-telescope/telescope-fzf-native.nvim' }
  }

  if packer_bootstrap then
    require('packer').sync()
  end
end)
