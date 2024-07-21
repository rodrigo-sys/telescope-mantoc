local pickers = require "telescope.pickers"
local finders = require "telescope.finders"
local conf = require("telescope.config").values
local actions = require "telescope.actions"
local action_state = require "telescope.actions.state"

local function get_toc()
  -- borrowed from:
  -- https://github.com/neovim/neovim/blob/2a24d0a4357d24d6edbd454ab2465abf460467db/runtime/lua/man.lua#L760

  local fn = vim.fn

  ---@type {lnum:integer, text:string}[]
  local toc = {}

  local lnum = 2
  local last_line = fn.line('$') - 1
  local section_title_re = vim.regex([[^\%( \{3\}\)\=\S.*$]])
  local flag_title_re = vim.regex([[^\s\+\%(+\|-\)\S\+]])

  while lnum and lnum < last_line do
    local text = fn.getline(lnum)
    if section_title_re:match_str(text) then
      -- if text is a section title
      toc[#toc + 1] = {
        lnum = lnum,
        text = text,
      }
    elseif flag_title_re:match_str(text) then
      -- if text is a flag title. we strip whitespaces and prepend two
      -- spaces to have a consistent format in the loclist.
      toc[#toc + 1] = {
        lnum = lnum,
        text = '  ' .. fn.substitute(text, [[^\s*\(.\{-}\)\s*$]], [[\1]], ''),
      }
    end
    lnum = fn.nextnonblank(lnum + 1)
  end

  -- print(vim.inspect(toc))
  return toc
end

local function mantoc(opts)
  opts = opts or {}
  pickers.new(opts, {
    prompt_title = "Man TOC",
    finder = finders.new_table {
      results = get_toc(),
      entry_maker = function(entry)
        return {
          lnum = entry.lnum,
          ordinal = entry.text,
          display = entry.text,
        }
      end
    },
    sorter = conf.generic_sorter(opts),
    attach_mappings = function(prompt_bufnr)
      actions.select_default:replace(function()
        actions.close(prompt_bufnr)
        local selection = action_state.get_selected_entry()

        vim.api.nvim_win_set_cursor(0, {selection.lnum, 1})
        -- vim.print(vim.inspect(selection))
      end)
      return true
    end,
  }):find()
end

-- print(vim.inspect(get_toc()))

return mantoc
