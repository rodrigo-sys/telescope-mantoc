# telescope-mantoc

A telescope extension to navigate the table of content of man pages

![demo](https://github.com/user-attachments/assets/eee1cb47-032a-40b9-a82b-b21d42d38de9)

## installation
using [folke/lazy.nvim](https://github.com/folke/lazy.nvim)
```lua
  {
    'rodrigo-sys/telescope-mantoc',
    dependencies = { "nvim-telescope/telescope.nvim" }
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

I recommend to use the ascending sorting strategy
```vim
:Telescope mantoc sorting_strategy=ascending
```

#### Todo
- [x] add demo
- [ ] implement telescope setup
- [ ] share in social media
