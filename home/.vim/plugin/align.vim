function! s:align_args()
  AlignCtrl p0P0 ,\@<=\s
  Align
endfunction

command! AlignArgs call s:align_args()
