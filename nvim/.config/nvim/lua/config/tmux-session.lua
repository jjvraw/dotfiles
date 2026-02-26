local function get_session_filename()
	local session_id = vim.fn.system('tmux display-message -p "#{session_id}"')
	session_id = session_id:gsub("\n", ""):gsub("^%$", "")
	local window_index = vim.fn.system('tmux display-message -p "#{window_index}"')
	window_index = window_index:gsub("\n", "")
	local pane_index = vim.fn.system('tmux display-message -p "#{pane_index}"')
	pane_index = pane_index:gsub("\n", "")
	local session_dir = vim.fn.expand("~/.local/share/nvim/tmux-sessions")
	vim.fn.mkdir(session_dir, "p")
	local cwd = vim.fn.getcwd():gsub("/", "_")
	return session_dir .. "/" .. cwd .. "-" .. session_id .. "-" .. window_index .. "-" .. pane_index .. ".vim"
end

if vim.env.TMUX then
	vim.api.nvim_create_autocmd({ "BufWritePost", "BufEnter" }, {
		callback = function()
			if vim.env.TMUX_PANE then
				local session_file = get_session_filename()
				vim.cmd("mksession! " .. session_file)
			end
		end,
	})
end
