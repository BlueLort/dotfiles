
local extract_selection = {}
-- The dream:
-- vnoremap <silent> * :<C-u>call VisualSelection('', '')<CR>/<C-R>=@/<CR><CR>
-- function! VisualSelection(direction, extra_filter) range
--     let l:saved_reg = @"
--     execute "normal! vgvy"
--     let l:pattern = escape(@", "\\/.*'$^~[]")
--     let l:pattern = substitute(l:pattern, "\n$", "", "")
--     if a:direction == 'gv'
--         call CmdLine("Ack '" . l:pattern . "' " )
--     elseif a:direction == 'rg'
--         call CmdLine("Rg '" . l:pattern . "' " )
--     elseif a:direction == 'replace'
--         call CmdLine("%s" . '/'. l:pattern . '/')
--     endif
--     let @/ = l:pattern
--     let @" = l:saved_reg
-- endfunction


--- Get the region between two marks and the start and end positions for the region
---
--@param mark1 Name of mark starting the region
--@param mark2 Name of mark ending the region
--@param options Table containing the adjustment function, register type and selection mode
--@return region region between the two marks, as returned by |vim.region|
--@return start (row,col) tuple denoting the start of the region
--@return finish (row,col) tuple denoting the end of the region
local function get_marked_region(mark1, mark2, options)
  local bufnr = 0
  local adjust = options.adjust or function(pos1, pos2)
    return pos1, pos2
  end
  local regtype = options.regtype or vim.fn.visualmode()
  local selection = options.selection or (vim.o.selection ~= 'exclusive')

  local pos1 = vim.fn.getpos(mark1)
  local pos2 = vim.fn.getpos(mark2)
  pos1, pos2 = adjust(pos1, pos2)

  local start = { pos1[2] - 1, pos1[3] - 1 + pos1[4] }
  local finish = { pos2[2] - 1, pos2[3] - 1 + pos2[4] }

  -- Return if start or finish are invalid
  if start[2] < 0 or finish[1] < start[1] then return end

  local region = vim.region(bufnr, start, finish, regtype, selection)
  return region, start, finish
end

--- Get the current visual selection as a string
---
--@return selection string containing the current visual selection
function extract_selection.get_visual_selection()
  local bufnr = 0
  local visual_modes = {
    v = true,
    V = true,
    -- [t'<C-v>'] = true, -- Visual block does not seem to be supported by vim.region
  }

  -- Return if not in visual mode
  if visual_modes[vim.api.nvim_get_mode().mode] == nil then return end

  local options = {}
  options.adjust = function(pos1, pos2)
    if vim.fn.visualmode() == "V" then
      pos1[3] = 1
      pos2[3] = 2^31 - 1
    end

    if pos1[2] > pos2[2] then
      pos2[3], pos1[3] = pos1[3], pos2[3]
      return pos2, pos1
    elseif pos1[2]==pos2[2] and pos1[3] > pos2[3] then
      return pos2, pos1
    else
      return pos1, pos2
    end
  end

  local region, start, finish = get_marked_region('v', '.', options)

  -- Compute the number of chars to get from the first line,
  -- because vim.region returns -1 as the ending col if the
  -- end of the line is included in the selection
  local lines =
    vim.api.nvim_buf_get_lines(bufnr, start[1], finish[1] + 1, false)
  local line1_end
  if region[start[1]][2] - region[start[1]][1] < 0 then
    line1_end = #lines[1] - region[start[1]][1]
  else
    line1_end = region[start[1]][2] - region[start[1]][1]
  end

  lines[1] = vim.fn.strpart(lines[1], region[start[1]][1], line1_end, true)
  if start[1] ~= finish[1] then
    lines[#lines] =
      vim.fn.strpart(
        lines[#lines],
        region[finish[1]][1],
        region[finish[1]][2] - region[finish[1]][1]
      )
  end
  return table.concat(lines)
end


local function visual_selection_range()
  local _, csrow, cscol, _ = unpack(vim.fn.getpos("'<"))
  local _, cerow, cecol, _ = unpack(vim.fn.getpos("'>"))
  if csrow < cerow or (csrow == cerow and cscol <= cecol) then
    return csrow - 1, cscol - 1, cerow - 1, cecol
  else
    return cerow - 1, cecol - 1, csrow - 1, cscol
  end
end

local function escape_all_special_characters(str)
  return string.gsub(str, "([%[%]%&%!%/%.%^%*%$%\\%\n])", "\\%1")
end

local function escape_special_characters(str)
  return string.gsub(str, "([%/%\\])", "\\%1")
end


local function find_selection(findChar)
  local selection = extract_selection.get_visual_selection()
  local escaped_selection = escape_all_special_characters(selection)
  vim.api.nvim_input(vim.api.nvim_replace_termcodes("<esc>" .. findChar .. escaped_selection .. "<CR>", true, true, true))
  -- vim.cmd("let @/='" .. escapedSelection .. "'")
  -- vim.cmd("norm n")
end

function extract_selection.FindNextSelection()
  find_selection("/")
end

function extract_selection.FindPreviousSelection()
  find_selection("?")
  vim.api.nvim_input("n")
end


function extract_selection.ReplaceSelection()
  local selection = extract_selection.get_visual_selection()
  local escaped_selection = escape_all_special_characters(selection)
  local semi_escaped_selection = escape_special_characters(selection)
  vim.api.nvim_input(vim.api.nvim_replace_termcodes("<esc>:%s/".. escaped_selection .. "/" .. semi_escaped_selection, true, true, true))
end

function extract_selection.GrepSelection()
  local selection = extract_selection.get_visual_selection()
  local escaped_selection = escape_all_special_characters(selection)
  escaped_selection = string.gsub(escaped_selection, "%'", "\\'")
  vim.api.nvim_input(vim.api.nvim_replace_termcodes("<esc>:grep /".. escaped_selection .. "/ **", true, true, true))
end

function extract_selection.FindStringSelection()
  local selection = extract_selection.get_visual_selection()
  require'telescope.builtin'.live_grep{search=selection, default_text=selection}
end

return extract_selection
