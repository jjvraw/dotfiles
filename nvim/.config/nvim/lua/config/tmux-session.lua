local function get_session_filename()
  local session_id = vim.fn.system('tmux display-message -p "#{session_id}"')
  session_id = session_id:gsub('\n', ''):gsub('^%$', '')
  local window_index = vim.fn.system('tmux display-message -p "#{window_index}"')
  window_index = window_index:gsub('\n', '')
  local pane_index = vim.fn.system('tmux display-message -p "#{pane_index}"')
  pane_index = pane_index:gsub('\n', '')
  return vim.fn.getcwd() .. '/.TmuxNvimSession-' .. session_id .. '-' .. window_index .. '-' .. pane_index .. '.vim'
end

local function start_tmux_session()
  if vim.env.TMUX_PANE then
    local session_file = get_session_filename()
    if vim.fn.filereadable(session_file) == 1 then
      vim.cmd('source ' .. session_file)
      vim.notify('Loaded session: ' .. session_file)
    end
    vim.cmd('Obsession ' .. session_file)
    vim.notify('Saving session to: ' .. session_file)
    -- Reload buffers to fix syntax highlighting
    vim.defer_fn(function()
      vim.cmd("bufdo if !empty(expand('%')) | e | endif")
    end, 100)
  end
end

if vim.env.TMUX then
  vim.api.nvim_create_autocmd('VimEnter', {
    nested = true,
    callback = start_tmux_session,
  })
end
