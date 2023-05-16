require('plugins')

local set = vim.opt
local api = vim.api

set.background = 'light'
api.nvim_command [[colorscheme NeoSolarized]]
set.termguicolors = true

set.ts = 2
set.expandtab = true
set.shiftwidth = 2
set.autoindent = true
set.smartindent = true
set.list = true
set.listchars = 'tab:··'
set.number = true
set.hlsearch = false
set.laststatus = 0
set.clipboard = 'unnamedplus'

-- Netrw
-- Inspired by:
-- https://vonheikemen.github.io/devlog/tools/using-netrw-vim-builtin-file-explorer/
-- https://shapeshed.com/vim-netrw/#nerdtree-like-setup
vim.g.netrw_banner = 0
vim.g.netrw_liststyle = 3
vim.g.netrw_altv = 1
vim.g.netrw_winsize = 25
vim.api.nvim_set_keymap(
  "n",
  "<leader>da",
  ":Lexplore %:p:h<CR>",
  { noremap = true }
)

vim.api.nvim_set_keymap(
  "n",
  "<leader>dd",
  ":Lexplore<CR>",
  { noremap = true }
)

-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap=true, silent=true }
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)
  vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format { async = true } end, bufopts)
end

local lsp_flags = {
  -- This is the default in Nvim 0.7+
  debounce_text_changes = 150,
}


local capabilities = require('cmp_nvim_lsp').default_capabilities()

local lspconfig = require('lspconfig')

lspconfig['tsserver'].setup{
    on_attach = on_attach,
    flags = lsp_flags,
    capabilities = capabilities,
}
lspconfig['eslint'].setup{
    on_attach = on_attach,
    flags = lsp_flags,
    capabilities = capabilities,
}
lspconfig['pylsp'].setup{
    on_attach = on_attach,
    flags = lsp_flags,
    capabilities = capabilities,
    settings = {
      pylsp = {
        plugins = {
          pylint = {
            enabled = false
          },
          pylsp_mypy = {
            enabled = true,
          },
          autopep8 = {
            enabled = false
          },
          yapf = {
            enabled = false
          },
        }
      }
    }
}
lspconfig['terraformls'].setup{
    on_attach = on_attach,
    flags = lsp_flags,
    capabilities = capabilities,
}

-- nvim-cmp setup
local cmp = require 'cmp'
cmp.setup {
  mapping = cmp.mapping.preset.insert({
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      else
        fallback()
      end
    end, { 'i', 's' }),
  }),
  sources = {
    { name = 'nvim_lsp' },
  },
}

-- fzf
vim.cmd([[
command! RecursiveGFiles call fzf#run(fzf#wrap({'source': 'git ls-files --cached --recurse-submodules & git ls-files --exclude-standard --others'}))
command! CtrlP execute (len(system("git rev-parse"))) ? ':Files' : ':RecursiveGFiles'
map <C-p> :CtrlP<CR>

let $FZF_DEFAULT_OPTS = '--bind alt-a:select-all'

func s:fnameescape(key, val)
  return fnameescape(a:val)
endfunc
function! s:populate_arg_list(lines)
  execute 'args ' . join(map(a:lines, function('s:fnameescape')), ' ')
endfunction

let g:fzf_action = {
  \ 'ctrl-l': function('s:populate_arg_list'),
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit'
  \}
]])

-- gitgutter
set.updatetime = 100
set.signcolumn = 'yes'
