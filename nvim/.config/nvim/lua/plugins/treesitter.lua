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
                disable = { "c", "cpp", "tablegen" },
            },
        })
    end,
}
