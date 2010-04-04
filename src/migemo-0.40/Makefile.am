SUBDIRS      = 	tests
bin_SCRIPTS  =  migemo migemo-grep migemo-server migemo-client
lisp_LISP    = 	migemo.el
ruby_data_    = migemo-dict.rb migemo-regex.rb\
		migemo-convert.rb migemo-index.rb migemo-cache.rb 
ruby_DATA    =  migemo.rb $(ruby_data_)
pkgdata_DATA = 	migemo-dict migemo-dict.idx\
		migemo-dict.cache migemo-dict.cache.idx\
		user-dict.sample regex-dict.sample\
		migemo.ja.rd
EXTRA_DIST   =	$(bin_SCRIPTS) migemo.rb.in $(ruby_data_) migemo.el.in \
		genchars.sh ngram.sh frequent-chars $(pkgdata_DATA)

migemo.el: migemo.el.in
	sed -e 's!@pkgdatadir@!$(pkgdatadir)!g' migemo.el.in > $@

migemo-dict: # SKK-JISYO.L
	ruby -I. migemo-convert.rb SKK-JISYO.L > $@

migemo-dict.idx: migemo-dict
	ruby -I. migemo-index.rb migemo-dict > migemo-dict.idx

migemo-dict.cache: frequent-chars migemo-dict migemo-dict.idx
	sort frequent-chars | ruby -I. migemo-cache.rb migemo-dict

frequent-chars: genchars.sh migemo-dict
	sh genchars.sh > tmp.list1
	cat tmp.list1 | ruby -rromkan -ne 'puts $$_.to_kunrei' > tmp.list2
	cat tmp.list1 tmp.list2 | sort | uniq > frequent-chars

clean-local:
	rm -f frequent-chars 
	rm -f migemo-dict migemo-dict.idx
	rm -f migemo-dict.cache migemo-dict.cache.idx

SKK-JISYO.L:
	wget http://openlab.ring.gr.jp/skk/skk/dic/SKK-JISYO.L

romkan.rb:
	wget -O ruby-romkan.tar.gz \
	http://cvs.namazu.org/ruby-romkan/ruby-romkan.tar.gz?tarball=1
	tar zxf ruby-romkan.tar.gz
	cp ruby-romkan/romkan.rb .
	rm -rf ruby-romkan

bsearch.rb:
	wget -O ruby-bsearch.tar.gz \
	http://cvs.namazu.org/ruby-bsearch/ruby-bsearch.tar.gz?tarball=1
	tar zxf ruby-bsearch.tar.gz
	cp ruby-bsearch/bsearch.rb .
	rm -rf ruby-bsearch

