return {
    {
        "nvim-tree/nvim-web-devicons",
        lazy = true
    },
    {
        "echasnovski/mini.icons",
        lazy = true
    },
    {
        "folke/snacks.nvim",
        lazy = false,
        priority = 1000,
        opts = {
            explorer = { enabled = true },
            git = { enabled = true },
            health = { enabled = true },
            input = { enabled = true },
            notifier = { enabled = true },
            picker = { enabled = true },
            statuscolumn = { enabled = true },
        }
    }
}
