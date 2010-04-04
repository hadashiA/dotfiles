TESTS =  ruby-syntax.sh migemo.sh convert.sh cache.sh regex.sh\
	 emacs-type.sh insertion.sh regex-dict.sh user-dict.sh symbols.sh
EXTRA_DIST   =	test-dict sample.rb $(TESTS) test.txt
noinst_DATA = 	test-dict.idx test-dict.cache


test-dict.idx: test-dict ../migemo-index.rb
	ruby -I.. ../migemo-index.rb test-dict > test-dict.idx

test-dict.cache: test-dict test-dict.idx ../migemo-cache.rb
	ruby -rromkan -ne 'puts $$1.to_roma if /^(.+?)	/' test-dict |\
	while read line; do\
	    echo $$line | ruby -ne 'chomp!;1.upto($$_.length) do |x| puts $$_[0,x] end';\
	done | ruby -I.. ../migemo-cache.rb test-dict

clean-local:
	rm -f tmp.*
	rm -f test-dict.idx test-dict.cache test-dict.cache.idx

