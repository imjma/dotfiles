augroup filetypedetect
  " Go (Google)
  autocmd FileType go let b:coc_pairs_disabled = ['<']
  au FileType go set noexpandtab
  au FileType go set shiftwidth=4
  au FileType go set softtabstop=4
  au FileType go set tabstop=4

  au FileType gitconfig set noexpandtab
  au FileType gitconfig set shiftwidth=2
  au FileType gitconfig set softtabstop=2
  au FileType gitconfig set tabstop=2
augroup END
