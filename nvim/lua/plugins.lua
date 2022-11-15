vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]])

return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim' -- Packer can manage itself
 
  use 'Tsuzat/NeoSolarized.nvim'
  use 'airblade/vim-gitgutter'
  use 'tpope/vim-commentary'

  use 'tpope/vim-fugitive'
  use 'junegunn/fzf'
  use 'junegunn/fzf.vim'

  use 'neovim/nvim-lspconfig'
  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-nvim-lsp'
  local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
  use({
      "jose-elias-alvarez/null-ls.nvim",
      config = function()
          require("null-ls").setup({
              sources = {
                  require("null-ls").builtins.diagnostics.cfn_lint,

                  require("null-ls").builtins.formatting.eslint_d,
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
end)
