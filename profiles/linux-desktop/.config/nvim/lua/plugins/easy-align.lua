return {
  "junegunn/vim-easy-align",
  event = { "BufReadPost", "BufNewFile", "VeryLazy" },
  keys = {
    {
      "ga",
      "<Plug>(EasyAlign)",
      mode = { "n", "x" },
      desc = "[easyalign] EasyAlign",
    },
  },
}
