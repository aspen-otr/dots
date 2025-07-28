return {
    {
        "andymass/vim-matchup"
    },
    {
        "hrsh7th/nvim-cmp",
        event = "InsertEnter",
        dependencies = {
            "neovim/nvim-lspconfig",
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-cmdline",
            "hrsh7th/cmp-vsnip",
            "hrsh7th/vim-vsnip",
        },
        config = function()
            local cmp = require("cmp")
            cmp.setup {
                snippet = {
                    expand = function(args)
                        vim.fn["vsnip#anonymous"](args.body)
                    end
                },
                mapping = cmp.mapping.preset.insert({
                    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                    ["<C-f>"] = cmp.mapping.scroll_docs(4),
                    ["<C-Space>"] = cmp.mapping.complete(),
                    ["<C-e>"] = cmp.mapping.abort(),
                    ["<CR>"] = cmp.mapping.confirm({ select = true }),
                }),
                sources = cmp.config.sources(
                    {
                        { name = "nvim_lsp" },
                        { name = "vsnip" }
                    },
                    {
                        { name = "buffer" }
                    }
                )

            }

            local cmp_ap = require("nvim-autopairs.completion.cmp")
            cmp.event:on("confirm_done", cmp_ap.on_confirm_done())
        end
    },
    {
        "neovim/nvim-lspconfig",
        config = function()
            -- STOLEN FROM Rishabh672003/Neovim
            vim.api.nvim_create_autocmd("LspAttach", {
                callback = function(ev)
                    local bufnr = ev.buf
                    local client = vim.lsp.get_client_by_id(ev.data.client_id)
                    if not client then
                        return
                    end

                   if client.server_capabilities.completionProvider then
                       vim.bo[bufnr].omnifunc = "v:lua.vim.lsp.omnifunc"
                   end
                   if client.server_capabilities.definitionProvider then
                       vim.bo[bufnr].tagfunc = "v:lua.vim.lsp.tagfunc"
                   end

                   client.server_capabilities.semanticTokensProvider = nil

                   local keymap = vim.keymap.set
                   local lsp = vim.lsp
                   local opts = { silent = true }
                   local function opt(desc, others)
                       return vim.tbl_extend("force", opts, { desc = desc }, others or {})
                   end
                   keymap("n", "gd", lsp.buf.definition, opt("Go to definition"))
                   keymap("n", "gi", function() lsp.buf.implementation({ border = "single" })  end, opt("Go to implementation"))
                   keymap("n", "gr", lsp.buf.references, opt("Show References"))
                   keymap("n", "gl", vim.diagnostic.open_float, opt("Open diagnostic in float"))
                   keymap("n", "<C-k>", lsp.buf.signature_help, opts)
                   pcall(vim.keymap.del, "n", "K", { buffer = ev.buf })
                   keymap("n", "K", function() lsp.buf.hover({ border = "single", max_height = 30, max_width = 120 }) end, opt("Toggle hover"))
                   keymap("n", "<Leader>lF", vim.cmd.FormatToggle, opt("Toggle AutoFormat"))
                   keymap("n", "<Leader>lI", vim.cmd.Mason, opt("Mason"))
                   keymap("n", "<Leader>lS", lsp.buf.workspace_symbol, opt("Workspace Symbols"))
                   keymap("n", "<Leader>la", lsp.buf.code_action, opt("Code Action"))
                   keymap("n", "<Leader>lh", function() lsp.inlay_hint.enable(not lsp.inlay_hint.is_enabled({})) end, opt("Toggle Inlayhints"))
                   keymap("n", "<Leader>li", vim.cmd.LspInfo, opt("LspInfo"))
                   keymap("n", "<Leader>ll", lsp.codelens.run, opt("Run CodeLens"))
                   keymap("n", "<Leader>lr", lsp.buf.rename, opt("Rename"))
                   keymap("n", "<Leader>ls", lsp.buf.document_symbol, opt("Doument Symbols"))
                   keymap("n", "<Leader>dn", function() vim.diagnostic.jump({ count = 1, float = true }) end, opt("Next Diagnostic"))
                   keymap("n", "<Leader>dp", function() vim.diagnostic.jump({ count =-1, float = true }) end, opt("Prev Diagnostic"))
                   keymap("n", "<Leader>dq", vim.diagnostic.setloclist, opt("Set LocList"))
                   keymap("n", "<Leader>dv", function()
                       vim.diagnostic.config({ virtual_lines = not vim.diagnostic.config().virtual_lines })
                   end, opt("Toggle diagnostic virtual_lines"))
               end,
           })
            vim.lsp.config("rust_analyzer", {
                autoformat = false,
                ["rust-analyzer"] = {
                    check = { command = "clippy" }
                }
            })
            vim.lsp.enable("rust_analyzer")
        end,
    }
}
