---
title: "Refactoring Using Neovim"
date: 2024-04-25T23:30:26-03:00
draft: false
---

This post is about how you can use Neovim to have refactoring tooling inspired in [Refactoring and your tooling](https://quii.gitbook.io/learn-go-with-tests/go-fundamentals/install-go#refactoring-and-your-tooling) from [Learn Go with tests](https://quii.gitbook.io/learn-go-with-tests).

## Extract/Inline

I am using [refactoring.nvim](https://github.com/ThePrimeagen/refactoring.nvim) plugin.

### Extract Variable

```lua
vim.keymap.set("x", "<leader>rv", function() require('refactoring').refactor('Extract Variable') end)
```

You need to select the part of your code that you want to extract to a variable and then press `<leader>rv`.

More about extract variable: https://refactoring.guru/extract-variable

### Inline Variable

```lua
vim.keymap.set({ "n", "x" }, "<leader>ri", function() require('refactoring').refactor('Inline Variable') end)
```

It's the inverse of extract variable. It will remove the variable and replace it with its value.

### Extract Method

```lua
vim.keymap.set("x", "<leader>re", function() require('refactoring').refactor('Extract Function') end)
```

## Rename

Here my goal is to rename symbols accross the codebase. It is possible to achieve this using Language Server Protocol as demonstrated by [mjlbach](https://github.com/mjlbach) in [this issue comment](https://github.com/neovim/nvim-lspconfig/issues/995#issuecomment-873471945) if the LSP support it.

I am using lsp-zero with default keymaps. To rename I need to use the `F2` key.
For go using go using gopls it is working to rename accross the codebase.

```lua
local lsp = require("lsp-zero")

lsp.on_attach(function(client, bufnr) lsp.default_keymaps({buffer = bufnr}) end)
```

## Format

I am using lsp-zero:

```lua
local lsp = require("lsp-zero")

lsp.format_on_save({servers = {["gopls"] = {'go'}}})
```

## Testing

I am using [vim-test](https://github.com/vim-test/vim-test) plugin to run tests.

```lua
vim.cmd([[
let g:test#echo_command = 0

let test#python#runner = 'pytest'

if exists('$TMUX')
  let g:test#preserve_screen = 1
  let g:test#strategy = 'vimux'
endif

nmap <silent> <leader>t :TestNearest<CR>
nmap <silent> <leader>T :TestFile<CR>
nmap <silent> <leader>a :TestSuite<CR>
nmap <silent> <leader>l :TestLast<CR>
nmap <silent> <leader>g :TestVisit<CR>
]])
```

## View Function Signature

I am using LSP for that, when I am in a function I can press `K` to see the 
function signature and when I am writing a function I can see the signature of
the function I am calling.

## View Function Definition

I am using LSP for that, when I am in a function I can press `gd` to go to the definition of the function. 
I can use `Ctrl-o` to go back.

## Find Usage of a Symbol

I am using LSP for that, when I am in a symbol I can press `gr` to see the usages of the symbol.
