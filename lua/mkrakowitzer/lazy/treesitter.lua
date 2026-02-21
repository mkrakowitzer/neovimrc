return {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    build = ":TSUpdate",
    config = function()
        local ensure_installed = {
            "vimdoc", "javascript", "typescript", "c", "lua", "rust",
            "jsdoc", "bash", "go", "templ",
        }

        local treesitter_parsers = require("nvim-treesitter.parsers")
        local templ_parser = {
            install_info = {
                url = "https://github.com/vrischmann/tree-sitter-templ.git",
                files = { "src/parser.c", "src/scanner.c" },
                branch = "master",
            },
        }
        if type(treesitter_parsers.get_parser_configs) == "function" then
            treesitter_parsers.get_parser_configs().templ = templ_parser
        else
            treesitter_parsers.templ = templ_parser
        end
        vim.treesitter.language.register("templ", "templ")

        local has_legacy_configs, treesitter_configs = pcall(require, "nvim-treesitter.configs")
        if has_legacy_configs then
            treesitter_configs.setup({
                ensure_installed = ensure_installed,
                sync_install = false,
                auto_install = true,
                indent = { enable = true },
                highlight = {
                    enable = true,
                    additional_vim_regex_highlighting = { "markdown", "json" },
                },
            })
            return
        end

        local has_new_api, treesitter = pcall(require, "nvim-treesitter")
        if not has_new_api then
            return
        end

        treesitter.setup({})
        local installed = {}
        for _, lang in ipairs(treesitter.get_installed()) do
            installed[lang] = true
        end
        local missing = {}
        for _, lang in ipairs(ensure_installed) do
            if not installed[lang] then
                table.insert(missing, lang)
            end
        end
        if #missing > 0 and #vim.api.nvim_list_uis() > 0 then
            vim.schedule(function()
                treesitter.install(missing)
            end)
        end

        local group = vim.api.nvim_create_augroup("mkrakowitzer_treesitter", { clear = true })
        vim.api.nvim_create_autocmd("FileType", {
            group = group,
            callback = function(args)
                if not pcall(vim.treesitter.start, args.buf) then
                    return
                end
                vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
            end,
        })
    end
}
