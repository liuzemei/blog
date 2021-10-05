all:
	hexo generate
	tar -zcvf public.tar.gz public
	scp ./public.tar.gz liu1:~/github/liuzemei/blog/public.tar.gz
	rm -f public.tar.gz
	ssh liu1 "cd ~/github/liuzemei/blog; tar -zxvf public.tar.gz; rm public.tar.gz"
