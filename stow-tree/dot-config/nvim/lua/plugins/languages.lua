return {
    {
        "elkowar/yuck.vim",
    },
    {
        "lervag/vimtex",
        config = function()
            vim.g.vimtex_view_method = "zathura"
        end
    },
	{
		"gpanders/nvim-parinfer"
	},
	{
		"kaarmu/typst.vim",
		ft = "typst",
		lazy = false,
		config = function()
			vim.g.typst_pdf_viewer = "zathura"
		end
	}
}
