if exists("b:did_ftplugin_python")
  finish
endif


let b:did_ftplugin_python=1

NeoBundle 'davidhalter/jedi-vim'
python  sys.path.insert(0, '/home/zakuro9715/Dropbox/products/web/codearena/lib/python3.4/site-packages')
