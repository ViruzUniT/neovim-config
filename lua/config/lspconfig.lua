local lspconfig = require('lspconfig')
require("mason-lspconfig").setup({
    ensure_installed = {
        "lua_ls",
        "clangd",
        -- "clang-format",
    }
})

local on_attach = function (_, _)
    --group = vim.api.nvim_create_augroup('UserLspConfig', {})
    --callback = function(ev)
        -- Enable completion triggered by <c-x><c-o>
        vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

        -- Buffer local mappings.
        -- See `:help vim.lsp.*` for documentation on any of the below functions
        local opts = {} -- {buffer = ev.buf}
        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration,
                       {opts, desc = "Goto Declaration"})
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition,
                       {opts, desc = "Goto Definition"})
        vim.keymap.set('n', 'K', vim.lsp.buf.hover,
                       {opts, desc = "Hover"})
        vim.keymap.set('n', '<leader>gi', vim.lsp.buf.implementation,
                       {opts, desc = "Goto Implementation"})
        vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help,
                       {opts, desc = "Singnature Help"})
        -- vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, { opts })
        -- vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, { opts })
        vim.keymap.set('n', '<leader>wl', function()
            print(vim.inspect(vim.lsp.buf.list_workleader_folders()))
        end, {opts, desc = "List Workleader Folders"})
        vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition,
                       {opts, desc = "Goto Type Definition"})
        vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename,
                       {opts, desc = "Rename"})
        vim.keymap.set({'n', 'v'}, '<leader>ca', vim.lsp.buf.code_action,
                       {opts, desc = "Code Action"})
        vim.keymap.set('n', 'gr', vim.lsp.buf.references,
                       {opts, desc = "Show References"})
        vim.keymap.set('n', '<leader>f',
                       function() vim.lsp.buf.format {async = true} end,
                       {opts, desc = "Format"})
    --end
end

lspconfig.lua_ls.setup{
    on_attach = on_attach
}
require'lspconfig'.clangd.setup {}

--vim.cmd("LspStart")

-- vim.api.nvim_create_autocmd('LspAttach', {
--     group = vim.api.nvim_create_augroup('UserLspConfig', {}),
--     callback = function(ev)
--         -- Enable completion triggered by <c-x><c-o>
--         vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

--         -- Buffer local mappings.
--         -- See `:help vim.lsp.*` for documentation on any of the below functions
--         local opts = {buffer = ev.buf}
--         vim.keymap.set('n', 'gD', vim.lsp.buf.declaration,
--                        {buffer = ev.buf, desc = "Goto Declaration"})
--         vim.keymap.set('n', 'gd', vim.lsp.buf.definition,
--                        {buffer = ev.buf, desc = "Goto Definition"})
--         vim.keymap.set('n', 'K', vim.lsp.buf.hover,
--                        {buffer = ev.buf, desc = "Hover"})
--         vim.keymap.set('n', '<leader>gi', vim.lsp.buf.implementation,
--                        {buffer = ev.buf, desc = "Goto Implementation"})
--         vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help,
--                        {buffer = ev.buf, desc = "Singnature Help"})
--         -- vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, { buffer = ev.buf })
--         -- vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, { buffer = ev.buf })
--         vim.keymap.set('n', '<space>wl', function()
--             print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
--         end, {buffer = ev.buf, desc = "List Workspace Folders"})
--         vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition,
--                        {buffer = ev.buf, desc = "Goto Type Definition"})
--         vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename,
--                        {buffer = ev.buf, desc = "Rename"})
--         vim.keymap.set({'n', 'v'}, '<space>ca', vim.lsp.buf.code_action,
--                        {buffer = ev.buf, desc = "Code Action"})
--         vim.keymap.set('n', 'gr', vim.lsp.buf.references,
--                        {buffer = ev.buf, desc = "Show References"})
--         vim.keymap.set('n', '<space>f',
--                        function() vim.lsp.buf.format {async = true} end,
--                        {buffer = ev.buf, desc = "Format"})
--     end
-- })

local cmp = require 'cmp'

local function border(hl_name)
    return {
        {"╭", hl_name}, {"─", hl_name}, {"╮", hl_name}, {"│", hl_name},
        {"╯", hl_name}, {"─", hl_name}, {"╰", hl_name}, {"│", hl_name}
    }
end

cmp.setup({
    snippet = {
        -- REQUIRED - you must specify a snippet engine
        expand = function(args)
            -- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
            require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
            -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
            -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
        end
    },
    window = {
        -- completion = cmp.config.window.bordered(),
        completion = {scrollbar = false},
        documentation = {
            border = border "CmpDocBorder",
            winhighlight = "Normal:CmpDoc"
        }
        -- documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
        ["<C-p>"] = cmp.mapping.select_prev_item(),
        ["<C-n>"] = cmp.mapping.select_next_item(),
        ["<C-d>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.close(),
        ["<CR>"] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Insert,
            select = true
        },
        ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif require("luasnip").expand_or_jumpable() then
                vim.fn.feedkeys(vim.api.nvim_replace_termcodes(
                                    "<Plug>luasnip-expand-or-jump", true, true,
                                    true), "")
            else
                fallback()
            end
        end, {"i", "s"}),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif require("luasnip").jumpable(-1) then
                vim.fn.feedkeys(vim.api.nvim_replace_termcodes(
                                    "<Plug>luasnip-jump-prev", true, true, true),
                                "")
            else
                fallback()
            end
        end, {"i", "s"})
    }),
    sources = cmp.config.sources({
        --{name = 'nvim_lsp'}, {name = 'vsnip'} -- For vsnip users.
          { name = 'buffer' }, -- For luasnip users.
          { name = 'luasnip' }, -- For luasnip users.
          { name = 'path' }, -- For luasnip users.
        -- { name = 'ultisnips' }, -- For ultisnips users.
        -- { name = 'snippy' }, -- For snippy users.
    }, {{name = 'buffer'}})
})

-- Set configuration for specific filetype.
cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
        {name = 'git'} -- You can specify the `git` source if [you were installed it](https://github.com/petertriho/cmp-git).
    }, {{name = 'buffer'}})
})

--[[ -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline({'/', '?'}, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {{name = 'buffer'}}
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({{name = 'path'}}, {{name = 'cmdline'}})
}) ]]

-- Set up lspconfig.
local capabilities = require('cmp_nvim_lsp').default_capabilities()
-- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
require('lspconfig')['<YOUR_LSP_SERVER>'].setup {capabilities = capabilities}
