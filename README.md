# telescope-mantoc

## installation
### [folke/lazy.nvim](https://github.com/folke/lazy.nvim)
```lua
  {
    'rodrigo-sys/telescope-mantoc',
    dependencies = { "nvim-telescope/telescope.nvim"
  }
```

## setup
```lua
require('telescope').load_extension('mantoc')
```

## usage
```vim
:Telescope mantoc
```

maps

``` lua
vim.keymap.set('n', '<leader>m', ':Telescope mantoc')
```
