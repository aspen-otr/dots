return {
    {
        "morhetz/gruvbox",
        lazy = false,
        priority = 1000,
        config = function()
            vim.opt.background = "dark"
            vim.cmd [[ colorscheme gruvbox ]]
        end
    },
    {
        "Shatur/neovim-ayu",
        lazy = false,
        priority = 1000,
        -- config = function()
        --     vim.opt.background = "dark"
        --     require("ayu").setup { mirage = true }
        --     vim.cmd [[ colorscheme ayu ]]
        -- end
    }
}
