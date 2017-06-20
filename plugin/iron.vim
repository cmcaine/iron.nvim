nnoremap <silent> <Plug>(iron-send-motion)
      \ :<c-u>let b:iron_cursor_pos = winsaveview()<CR>:<c-u>set opfunc=IronSendMotion<CR>g@
vnoremap <silent> <Plug>(iron-send-motion)
      \ :<c-u>let b:iron_cursor_pos = winsaveview()<CR>:<c-u>call IronSendMotion('visual')<CR>

"Call previous command again
nnoremap <silent> <Plug>(iron-repeat-cmd) :call IronSend("\u001b\u005b\u0041")<CR>
nnoremap <silent> <Plug>(iron-cr)         :call IronSend("")<CR> " <CR> to force execution of command
nnoremap <silent> <Plug>(iron-interrupt)  :call IronSend("\u0003")<CR> " <c-c> to interrupt command
nnoremap <silent> <Plug>(iron-exit)       :call IronSend("\u0004")<CR> " <c-d> to exit iron
nnoremap <silent> <Plug>(iron-clear)      :call IronSend("\u000C")<CR> " <c-l> to clear screen

if !hasmapto('<Plug>(iron-send-motion)')
  if maparg('c','n') ==# ''
    nmap ctr <Plug>(iron-send-motion)
  endif
  if maparg('c','v') ==# ''
    vmap ctr <Plug>(iron-send-motion)
  endif
endif

if !hasmapto('<Plug>(iron-repeat-cmd)')
  if maparg('c','n') ==# ''
    nmap cp <Plug>(iron-repeat-cmd)
  endif
endif

function! IronWatchFile(fname, command) abort
  augroup IronWatch
    exec "autocmd BufWritePost ".a:fname." call IronSend('".a:command."')"
  augroup END
endfunction

function! IronUnwatchFile(fname) abort
  autocmd! IronWatch BufWritePost a:fname
endfunction

command! -nargs=* IronWatchCurrentFile call IronWatchFile(expand('%'), <q-args>)
command! -nargs=* IronUnwatchCurrentFile call IronUnwatchFile(expand('%'))
