return {
  'dmtrKovalenko/fff.nvim',
  build = function()
    -- this will download prebuild binary or try to use existing rustup toolchain to build from source
    -- (if you are using lazy you can use gb for rebuilding a plugin if needed)
    require('fff.download').download_or_build_binary()
  end,
  opts = {
    preview = {
      enabled = true,
      show_file_info = false,
    },
    debug = {
      enabled = true,
      show_scores = true,
    },
  },
  lazy = false,
  keys = {
    {
      '<leader>f',
      function()
        require('fff').find_files()
      end,
      desc = 'FFFind files',
    },
  },
}
