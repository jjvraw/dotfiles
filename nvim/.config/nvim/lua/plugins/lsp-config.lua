return {
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = {
					"lua_ls",
					"jdtls",
					"pyright",
					"clangd",
					"ltex",
				},
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		config = function()
			-- The nvim-cmp almost supports LSP's capabilities so You should advertise it to LSP servers..
			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			local lspconfig = require("lspconfig")

			lspconfig.lua_ls.setup({
				capabilities = capabilities,
			})
			lspconfig.jdtls.setup({
				capabilities = capabilities,
			})
			lspconfig.pyright.setup({
				capabilities = capabilities,
			})
			lspconfig.clangd.setup({
				capabilities = capabilities,
			})
			lspconfig.ltex.setup({
				capabilities = capabilities,
				on_attach = function(client, bufnr)
					require("ltex_extra").setup({
						load_langs = { "en-GB" },
						init_check = true,
						path = ".ltex",
						log_level = "warn",
					})
				end,
				settings = {
					ltex = {
						language = "en-GB",
						enabled = { "latex", "tex", "bib" },
						checkFrequency = "edit",
						additionalRules = {
							enablePickyRules = true,
						},
					},
				},
			})
			lspconfig.hls.setup({
				capabilities = capabilities,
				cmd = { os.getenv("HOME") .. "/.ghcup/bin/haskell-language-server-wrapper", "--lsp" },
				filetypes = { "haskell", "lhaskell" },
				root_dir = lspconfig.util.root_pattern(
					"*.cabal",
					"stack.yaml",
					"cabal.project",
					"package.yaml",
					"hie.yaml"
				),
			})
			lspconfig.mojo.setup({
				capabilities = capabilities, -- Eh, for later.. assumabily
			})

			local function conditional_format()
				if vim.bo.filetype == "mojo" then
					vim.cmd("w")
					vim.fn.system("mojo format " .. vim.fn.expand("%:p"))
					vim.cmd("e")
				else
					vim.lsp.buf.format({ async = true })
				end
			end

			local configs = require("lspconfig.configs")
			if not configs.tblgen_lsp_server then
				configs.tblgen_lsp_server = {
					default_config = {
						cmd = {
							"~/Git/llvm-project/build/bin/tblgen-lsp-server",
							"--tablegen-compilation-database=" .. vim.fn.getcwd() .. "/tablegen_compile_commands.yml",
						},
						filetypes = { "tablegen" },
						root_dir = lspconfig.util.root_pattern(".git", "tablegen_compile_commands.yml"),
					},
				}
			end
			lspconfig.tblgen_lsp_server.setup({
				capabilities = capabilities,
			})

			vim.keymap.set("n", "<leader>gf", conditional_format, { noremap = true, silent = true })
			vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
			vim.keymap.set("n", "gD", vim.lsp.buf.declaration)
			vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
			vim.keymap.set("n", "gi", vim.lsp.buf.implementation)
			vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, {})
			vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})
			vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, {})
			vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename)
		end,

		vim.diagnostic.config({
			virtual_text = true,
			signs = true,
			underline = true,
			update_in_insert = false,
			severity_sort = true,
		}),
	},
}
