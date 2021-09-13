require("telescope").setup {
  defaults = {
    -- Your defaults config goes in here
  },
  pickers = {
    -- Your special builtin config goes in here
    buffers = {},
    find_files = {
      theme = "dropdown",
      previewers= true
    }
  },
  extensions = {
    -- Your extension config goes in here
  }
}
