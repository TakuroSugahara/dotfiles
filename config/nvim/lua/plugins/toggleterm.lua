require("toggleterm").setup{
  shading_factor = '100',
  direction = 'float',
  float_opts = {
    width = function()
      return math.ceil(vim.o.columns * 0.75)
    end,
    height = function()
      return math.ceil(vim.o.lines * 0.80)
    end,
    -- FIXME: 使いたいが、うまくいかない
    -- winblend = 3,
  },
}
