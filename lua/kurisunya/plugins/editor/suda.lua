PicoPack.register({
  PicoPack.url.gh("lambdalisue/suda.vim"),
  init = function() vim.g.suda_smart_edit = 1 end,
  event = PicoPack.event.VeryLazy,
})
