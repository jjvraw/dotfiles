local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("vim-options")
require("lazy").setup("plugins")

-- For tmux auto window renaming
if vim.env.TMUX then
  vim.api.nvim_create_augroup("tmux", { clear = true })
  vim.api.nvim_create_autocmd({"BufReadPost", "FileReadPost", "BufNewFile", "FocusGained"}, {
    group = "tmux",
    callback = function()
      local filename = vim.fn.expand("%:t")
      if filename == "" then
        -- We're likely in a directory view (like netrw or oil.nvim)
        local dir_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
        vim.fn.system("tmux rename-window " .. vim.fn.shellescape(dir_name))
      else
        vim.fn.system("tmux rename-window " .. vim.fn.shellescape(filename))
      end
    end
  })
  vim.api.nvim_create_autocmd("VimLeave", {
    group = "tmux",
    callback = function()
      local dir_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
      vim.fn.system("tmux rename-window " .. vim.fn.shellescape(dir_name))
    end
  })
end
