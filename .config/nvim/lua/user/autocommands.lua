--[[ TODO: understand how to write lua autocommands
vim.api.nvim_create_autocmd( {"User", "VimtexEventInitPost"}, {
    command = "call vimtex#compiler#start()"
})
--]]

vim.cmd [[
  augroup _vimtex
      au!
      au User VimtexEventInitPost call vimtex#compiler#start()
  augroup END

  augroup _git
    au!
    au FileType gitcommit setlocal wrap
    au FileType gitcommit setlocal spell
  augroup end

  augroup _markdown
    au!
    au FileType markdown setlocal wrap
    au FileType markdown setlocal spell
  augroup end

  augroup _info_pages
    au!
    au FileType help,lspinfo,qf,vim,checkhealth nnoremap <silent> <buffer> q :close<CR> 
    au FileType lspinfo,qf,vim,checkhealth nnoremap <silent> <buffer> <Esc> :close<CR> 
  augroup end

  augroup _binary
    au! 
    au BufReadPre   *.bin,*.exe,*.out let &bin=1
    au BufReadPost  *.bin,*.exe,*.out if &bin | %!xxd
    au BufReadPost  *.bin,*.exe,*.out set ft=xxd | endif
    au BufWritePre  *.bin,*.exe,*.out if &bin | %!xxd -r
    au BufWritePre  *.bin,*.exe,*.out endif
    au BufWritePost *.bin,*.exe,*.out if &bin | %!xxd
    au BufWritePost *.bin,*.exe,*.out set nomod | endif
  augroup end

  augroup _nasm
    au!
    au BufRead,BufNewFile *.inc,*.asm set filetype=nasm
  augroup end

  augroup _leave
    au!
    au BufLeave * silent! wall
  augroup END

]]
