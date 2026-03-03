return {
    {
        "sainnhe/gruvbox-material",
        lazy = false,
        priority = 1000,
        config = function()
            -- Set gruvbox-material options before loading
            vim.g.gruvbox_material_background = "medium" -- soft, medium, hard
            vim.g.gruvbox_material_foreground = "material" -- material, mix, original
            vim.g.gruvbox_material_enable_italic = true
            vim.g.gruvbox_material_enable_bold = true
            vim.g.gruvbox_material_better_performance = true
            vim.g.gruvbox_material_transparent_background = 1 -- 0, 1, or 2

            vim.cmd.colorscheme("gruvbox-material")

            -- Make background transparent (matching your previous config)
            vim.api.nvim_set_hl(0, "Normal", { bg = "NONE", ctermbg = "NONE" })
            vim.api.nvim_set_hl(0, "NormalFloat", { bg = "NONE", ctermbg = "NONE" })
        end,
    },
}
