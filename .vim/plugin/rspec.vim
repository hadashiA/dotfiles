"
" rspec, rspec support on vim(gvim,vim)
" 
" Seasons<keisuke@hata.biz>
"
"-----------------------------------------------------------------------------------------------------------------
" <リリースノート>
"-----------------------------------------------------------------------------------------------------------------
" 1.0.2 => スクリプトファイルのパスにスペースが含まれている時に実行できていなかったバグを修正。
"
" 1.0.1 => hasでwin32とlinuxの切り替えを実装
"
" 1.0.0 => とりあえずリリース
"
"-----------------------------------------------------------------------------------------------------------------
" <説明>
"-----------------------------------------------------------------------------------------------------------------
" specのコマンドをファイルに書き出し、copenでvimに取り込む事で、
" vimで快適にrspecを楽しんでもらうためのものです。
" 
" xxxx_spec.rbファイルを開き、:Rspec<CR>で実行可能。
" カーソルの上のスペックだけ実行も可能です。
" デフォルトは、<Shift-S>でバインドしてます。
"
" ぶっちゃけwin32とlinuxの違いは、書き出しファイル名を""でくくるかそうでないかの違いです。
" あと、Windowsユーザーは、http://d.hatena.ne.jp/Seasons/20071124/1195848108
" のカスタマイズ vimrun.exeに置き換えてもらうと、コマンドプロンプトが一切でないのでいい
" 感じです。
"
"function! Rspec ()
function! RspecExec ()
"	let rails_spec_pat = '\<spec/\(models\|controllers\|views\|helpers\)/.*_spec\.rb$'
"	if expand('%:p') =~ rails_spec_pat
"		"rakeの方は、基本,私=Seasonsは、使わないので、未サポート
"		exe '!rake spec SPEC="'.expand('%:p').'" RSPECOPTS="-fs -c -l '.line('.').'"'
"	else
		let tmp=tempname()
		"カラーオプションをつけるとリダイレクトされないので、-cオプションは、カット"
		if has('win32')
			let cmd=':!spec -fs -l '.line('.').' "%"' . '> "' . tmp . '"'
		else
			let cmd=':!spec -fs -l '.line('.').' "%" ' . '>' . tmp
		endif
		silent execute cmd
		if getfsize(tmp) != 0
			execute "silent! cfile " . tmp
			:copen
			call delete(tmp)
		endif
"	endif
endfunction

"au BufRead,BufNewFile *_spec.rb :command! Rspec :call Rspec()
"
"nmap <S-S> :Rspec<CR>
