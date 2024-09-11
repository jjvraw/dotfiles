return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	config = function()
		require("nvim-treesitter.configs").setup({

			-- A list of parser names, or "all" (the five listed parsers should always be installed)
			ensure_installed = {
				"c",
				"lua",
				"vim",
				"vimdoc",
				"query",
				"java",
				"python",
			},

			-- Install parsers synchronously (only applied to `ensure_installed`)
			sync_install = false,

			-- Automatically install missing parsers when entering buffer
			-- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
			auto_install = true,
			highlight = {
				enable = true,
			},
			indent = {
				enable = true,
				disable = { "mojo" },
			},
		})

		-- Only register Python for Mojo if Mojo parser is not available
		if not pcall(vim.treesitter.language.require_language, "mojo") then
			vim.treesitter.language.register("python", "mojo")

			-- Disable Python indentation for Mojo files
			vim.api.nvim_create_autocmd("FileType", {
				pattern = "mojo",
				callback = function()
					vim.bo.indentexpr = ""
					vim.bo.autoindent = false
					vim.bo.smartindent = false

					-- Remap Enter to just insert a newline in insert mode
					vim.api.nvim_buf_set_keymap(0, "i", "<CR>", "<CR>", { noremap = true, silent = true })
				end,
			})
		end
	end,
}
