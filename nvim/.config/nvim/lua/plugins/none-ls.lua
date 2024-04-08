return {
	"nvimtools/none-ls.nvim",
	config = function()
		local null_ls = require("null-ls")

		null_ls.setup({
			sources = {
				null_ls.builtins.formatting.stylua,
                null_ls.builtins.formatting.clang_format,
                null_ls.builtins.formatting.google_java_format.with({
                    extra_args = function()
                        return {"--tab-width", "4"}
                    end
                }),
            },
		})

		vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})

	end,
}
