return {
    -- Statusline
    {
        "nvim-lualine/lualine.nvim",
        event = "VeryLazy",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        opts = function()
            local colors = {
                bg = "",
                fg = "",
                yellow = "#ECBE7B",
                cyan = "#008080",
                darkblue = "#081633",
                green = "#98be65",
                orange = "#FF8800",
                violet = "#a9a1e1",
                magenta = "#c678dd",
                blue = "#51afef",
                red = "#ec5f67",
            }

            local conditions = {
                buffer_not_empty = function()
                    return vim.fn.empty(vim.fn.expand("%:t")) ~= 1
                end,
                hide_in_width = function()
                    return vim.fn.winwidth(0) > 80
                end,
                check_git_workspace = function()
                    local filepath = vim.fn.expand("%:p:h")
                    local gitdir = vim.fn.finddir(".git", filepath .. ";")
                    return gitdir and #gitdir > 0 and #gitdir < #filepath
                end,
            }

            local config = {
                options = {
                    icons_enabled = true,
                    component_separators = "",
                    section_separators = "",
                    theme = {
                        normal = { c = { fg = colors.fg, bg = colors.bg } },
                        inactive = { c = { fg = colors.fg, bg = colors.bg } },
                    },
                    globalstatus = true,
                },
                sections = {
                    lualine_a = {},
                    lualine_b = {},
                    lualine_y = {},
                    lualine_z = {},
                    lualine_c = {
                        {
                            function()
                                return ""
                            end,
                            color = function()
                                local mode_color = {
                                    n = colors.red,
                                    i = colors.green,
                                    v = colors.blue,
                                    [""] = colors.blue,
                                    V = colors.blue,
                                    c = colors.magenta,
                                    no = colors.red,
                                    s = colors.orange,
                                    S = colors.orange,
                                    [""] = colors.orange,
                                    ic = colors.yellow,
                                    R = colors.violet,
                                    Rv = colors.violet,
                                    cv = colors.red,
                                    ce = colors.red,
                                    r = colors.cyan,
                                    rm = colors.cyan,
                                    ["r?"] = colors.cyan,
                                    ["!"] = colors.red,
                                    t = colors.red,
                                }
                                return { fg = mode_color[vim.fn.mode()] }
                            end,
                            padding = { right = 1 },
                        },
                        {
                            "filename",
                            cond = conditions.buffer_not_empty,
                            color = { fg = colors.blue, gui = "bold" },
                        },
                        {
                            "filetype",
                            padding = { left = 1, right = 0 },
                            colored = true,
                            icon_only = true,
                        },
                        {
                            function()
                                return "%="
                            end,
                        },
                    },
                    lualine_x = {
                        { "progress", color = { fg = colors.fg, gui = "bold" } },
                        {
                            "diagnostics",
                            sources = { "nvim_diagnostic" },
                            symbols = { error = " ", warn = " ", info = " " },
                            diagnostics_color = {
                                color_error = { fg = colors.red },
                                color_warn = { fg = colors.yellow },
                                color_info = { fg = colors.cyan },
                            },
                        },
                        {
                            "branch",
                            icon = "",
                            color = { fg = colors.green, gui = "bold" },
                        },
                    },
                },
                inactive_sections = {
                    lualine_a = {},
                    lualine_b = {},
                    lualine_c = { "filename" },
                    lualine_x = { "location" },
                    lualine_y = {},
                    lualine_z = {},
                },
            }

            return config
        end,
    },

    -- File icons: load at startup and run setup so icons are available for
    -- lualine, nvim-tree, etc. Requires a Nerd Font in the terminal/GUI.
    {
        "nvim-tree/nvim-web-devicons",
        lazy = false,
        config = function()
            require("nvim-web-devicons").setup({})
        end,
    },
}
