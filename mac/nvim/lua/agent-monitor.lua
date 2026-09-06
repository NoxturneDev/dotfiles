-- Agent change monitor: auto-refresh quickfix from git diffs
-- Usage: :AgentQfRefresh to manually refresh
-- Auto-refreshes every 5 seconds when enabled
-- Monitors the current working directory's git repo

local M = {}
local timer = nil
local qf_file = '/tmp/agent-changes.qf'

-- Parse quickfix file format: path:line:text
local function parse_qf_file()
  local items = {}
  if vim.fn.filereadable(qf_file) ~= 1 then
    return items
  end

  local lines = vim.fn.readfile(qf_file)
  for _, line in ipairs(lines) do
    local path, lnum, text = line:match('^(.+):(%d+):(.*)$')
    if path and lnum then
      table.insert(items, {
        filename = path,
        lnum = tonumber(lnum),
        text = text,
      })
    end
  end
  return items
end

-- Refresh quickfix with current repo's changes
function M.refresh()
  -- Get current working directory
  local cwd = vim.fn.getcwd()

  -- Run aggregation script with current directory
  vim.fn.system('agent-changes-qf ' .. vim.fn.shellescape(cwd))

  -- Parse and set quickfix
  local items = parse_qf_file()
  if #items > 0 then
    vim.fn.setqflist({}, 'r', {
      title = 'Agent Changes (' .. vim.fn.fnamemodify(cwd, ':t') .. ')',
      items = items,
    })
    vim.notify(string.format('Agent changes: %d entries loaded', #items), vim.log.levels.INFO)
  else
    vim.fn.setqflist({}, 'r', {
      title = 'Agent Changes (' .. vim.fn.fnamemodify(cwd, ':t') .. ')',
      items = {},
    })
    vim.notify('No agent changes detected', vim.log.levels.INFO)
  end
end

-- Start auto-refresh timer
function M.start_auto_refresh(interval_ms)
  interval_ms = interval_ms or 5000

  if timer then
    timer:stop()
  end

  timer = vim.uv.new_timer()
  timer:start(interval_ms, interval_ms, vim.schedule_wrap(function()
    M.refresh()
  end))

  vim.notify(string.format('Agent Qf auto-refresh started (%dms interval)', interval_ms), vim.log.levels.INFO)
end

-- Stop auto-refresh timer
function M.stop_auto_refresh()
  if timer then
    timer:stop()
    timer = nil
  end
  vim.notify('Agent Qf auto-refresh stopped', vim.log.levels.INFO)
end

-- Toggle auto-refresh
function M.toggle_auto_refresh()
  if timer then
    M.stop_auto_refresh()
  else
    M.start_auto_refresh()
  end
end

-- Open quickfix window with agent changes
function M.open()
  M.refresh()
  vim.cmd('copen')
end

return M
