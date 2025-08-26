--- REGULAR OPTIONS ---

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.tabstop = 4
vim.opt.expandtab = false

vim.opt.wrap = false

vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.hlsearch = false

vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.opt.termguicolors = true

--- KEYMAPS ---

vim.keymap.set("n", ";", ":") -- convenience

vim.keymap.set("n", "<leader>n", ":bn<CR>", { silent = true })
vim.keymap.set("n", "<leader>p", ":bp<CR>", { silent = true })

--- TEPMLATES ---
--- Blog post: https://zignar.net/2024/11/20/template-files-for-nvim/
vim.api.nvim_create_autocmd("BufNewFile", {
  group = vim.api.nvim_create_augroup("templates", { clear = true }),
  desc = "Load template file",
  callback = function(args)
    local home = os.getenv("HOME")
    -- fnamemodify with `:t` gets the tail of the file path: the actual filename
    -- See :help fnamemodify
    local fname = vim.fn.fnamemodify(args.file, ":t")
    local tmpl = home .. "/.config/nvim/templates/" .. fname ..".tpl"
    -- fs_stat is used to check if the file exists
    if vim.uv.fs_stat(tmpl) then
      -- See :help :read
      -- 0 is the range:
      -- This reads as: "Insert the file <tmpl> below the specified line (0)"
      vim.cmd("0r " .. tmpl)
    else
        -- fnamemodify with `:e` gets the filename extension
      local ext = vim.fn.fnamemodify(args.file, ":e")
      tmpl = home .. "/.config/nvim/templates/" .. ext ..".tpl"
      if vim.uv.fs_stat(tmpl) then
        vim.cmd("0r " .. tmpl)
      end
    end
  end
})

--- LAZY NVIM ---
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
    if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
        { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
        { out, "WarningMsg" },
        { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    spec = {
        { import = "plugins" },
    },
    checker = { enabled = true },
})
