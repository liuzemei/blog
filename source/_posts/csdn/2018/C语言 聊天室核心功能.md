---
title: C语言 聊天室核心功能
date: 2018-09-04 22:02:55
layout: post
author: 刘泽美
categories:
  - CSDN文章
  - 导入
tags: 代码人生
---

[原链接](https://blog.csdn.net/weixin_41884153/article/details/82391247)
{% raw %}

                    <svg xmlns="http://www.w3.org/2000/svg" style="display: none;">
                        <path stroke-linecap="round" d="M5,0 0,2.5 5,5z" id="raphael-marker-block" style="-webkit-tap-highlight-color: rgba(0, 0, 0, 0);"></path>
                    </svg>
                    <p>从早上折腾到现在，基本上把聊天室的核心功能做出来了。</p> 
<p>嗯，从下午到晚上一直在调试各种bug。</p> 
<p>出现如下错误：<br> 1、段错误（在使用链表的时候，非法使用p_last空间，解决方案是直接不用p_last）<br> 2、新建的链表节点没有放在堆区…然后各种问题…<br> 2、出现内存溢出（结果发现，第二次write一个/n的时候是copy的上一行的…第三个参数没改）——这个纠结了半下午。最后改成1，然后瞬间通畅…<br> 3、关于服务器和客户端的线程回收（分离）的问题没关注，导致陷入printf("\n")的死循环…（解决方案是分别在客户端和服务器里加一个判断，如果从对方的通讯节点里收到的字节数为空，那么就直接关闭通讯节点并结束线程）</p> 
<p>4.现在貌似还有个问题，就是我malloc堆区的内存还没有地方释放，我正在思考在哪里free…</p> 
<p>先上传代码吧。明天再改改。</p> 
<p>服务器端：server.c</p> 
<pre class=" language-c"><code class="prism  language-c"><span class="token macro property">#<span class="token directive keyword">include</span> <span class="token string">&lt;stdio.h&gt;</span></span>
<span class="token macro property">#<span class="token directive keyword">include</span> <span class="token string">&lt;sys/types.h&gt;</span></span>
<span class="token macro property">#<span class="token directive keyword">include</span> <span class="token string">&lt;netinet/in.h&gt;</span></span>
<span class="token macro property">#<span class="token directive keyword">include</span> <span class="token string">&lt;netinet/ip.h&gt;</span></span>
<span class="token macro property">#<span class="token directive keyword">include</span> <span class="token string">&lt;sys/socket.h&gt;</span></span>
<span class="token macro property">#<span class="token directive keyword">include</span> <span class="token string">&lt;arpa/inet.h&gt;</span></span>
<span class="token macro property">#<span class="token directive keyword">include</span> <span class="token string">&lt;string.h&gt;</span></span>
<span class="token macro property">#<span class="token directive keyword">include</span> <span class="token string">&lt;unistd.h&gt;</span></span>
<span class="token macro property">#<span class="token directive keyword">include</span> <span class="token string">&lt;pthread.h&gt;</span></span>
<span class="token macro property">#<span class="token directive keyword">include</span> <span class="token string">&lt;ctype.h&gt;</span></span>
<span class="token macro property">#<span class="token directive keyword">include</span> <span class="token string">&lt;stdlib.h&gt;</span></span>

<span class="token keyword">typedef</span> <span class="token keyword">struct</span> node<span class="token punctuation">{<!-- --></span>
	<span class="token keyword">int</span> cfd<span class="token punctuation">;</span>
	<span class="token keyword">struct</span> node <span class="token operator">*</span>p_next<span class="token punctuation">;</span>
<span class="token punctuation">}</span>node<span class="token punctuation">;</span>

pthread_mutex_t mutex <span class="token operator">=</span> PTHREAD_MUTEX_INITIALIZER<span class="token punctuation">;</span>
node head<span class="token operator">=</span><span class="token punctuation">{<!-- --></span><span class="token number">0</span><span class="token punctuation">}</span><span class="token punctuation">;</span>
node tail<span class="token operator">=</span><span class="token punctuation">{<!-- --></span><span class="token number">0</span><span class="token punctuation">}</span><span class="token punctuation">;</span>

<span class="token keyword">void</span><span class="token operator">*</span> <span class="token function">func</span><span class="token punctuation">(</span><span class="token punctuation">)</span><span class="token punctuation">{<!-- --></span>
	<span class="token keyword">char</span> buf<span class="token punctuation">[</span><span class="token number">128</span><span class="token punctuation">]</span><span class="token punctuation">;</span>
<span class="token comment">//	node* p_tmp=NULL;</span>
	<span class="token function">pthread_mutex_lock</span><span class="token punctuation">(</span><span class="token operator">&amp;</span>mutex<span class="token punctuation">)</span><span class="token punctuation">;</span>
	node<span class="token operator">*</span> p_tmp<span class="token operator">=</span><span class="token operator">&amp;</span>head<span class="token punctuation">;</span>
	node<span class="token operator">*</span> p_tmp1<span class="token operator">=</span><span class="token operator">&amp;</span>tail<span class="token punctuation">;</span>
	<span class="token function">pthread_mutex_unlock</span><span class="token punctuation">(</span><span class="token operator">&amp;</span>mutex<span class="token punctuation">)</span><span class="token punctuation">;</span>
	<span class="token keyword">int</span> cfd<span class="token punctuation">;</span>
	<span class="token keyword">for</span><span class="token punctuation">(</span><span class="token punctuation">;</span>p_tmp<span class="token operator">!=</span>p_tmp1<span class="token punctuation">;</span>p_tmp<span class="token operator">=</span>p_tmp<span class="token operator">-&gt;</span>p_next<span class="token punctuation">)</span><span class="token punctuation">{<!-- --></span>
		node<span class="token operator">*</span> p_first <span class="token operator">=</span> p_tmp<span class="token punctuation">;</span>
		node<span class="token operator">*</span> p_mid <span class="token operator">=</span> p_first<span class="token operator">-&gt;</span>p_next<span class="token punctuation">;</span>
		<span class="token keyword">if</span><span class="token punctuation">(</span>p_mid <span class="token operator">==</span> <span class="token operator">&amp;</span>tail<span class="token punctuation">)</span><span class="token punctuation">{<!-- --></span>
			cfd <span class="token operator">=</span> p_first<span class="token operator">-&gt;</span>cfd<span class="token punctuation">;</span>
		<span class="token punctuation">}</span>
	<span class="token punctuation">}</span>
	<span class="token keyword">while</span><span class="token punctuation">(</span><span class="token number">1</span><span class="token punctuation">)</span><span class="token punctuation">{<!-- --></span>
		<span class="token function">pthread_mutex_lock</span><span class="token punctuation">(</span><span class="token operator">&amp;</span>mutex<span class="token punctuation">)</span><span class="token punctuation">;</span>
		p_tmp<span class="token operator">=</span>head<span class="token punctuation">.</span>p_next<span class="token punctuation">;</span>
		<span class="token function">pthread_mutex_unlock</span><span class="token punctuation">(</span><span class="token operator">&amp;</span>mutex<span class="token punctuation">)</span><span class="token punctuation">;</span>
		<span class="token function">bzero</span><span class="token punctuation">(</span>buf<span class="token punctuation">,</span><span class="token number">128</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
		<span class="token keyword">int</span> r<span class="token operator">=</span><span class="token function">read</span><span class="token punctuation">(</span>cfd<span class="token punctuation">,</span>buf<span class="token punctuation">,</span><span class="token number">128</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
		<span class="token keyword">if</span><span class="token punctuation">(</span>r<span class="token operator">==</span><span class="token number">0</span><span class="token punctuation">)</span><span class="token punctuation">{<!-- --></span>
			<span class="token function">printf</span><span class="token punctuation">(</span><span class="token string">"%d:关闭套接字,结束线程"</span><span class="token punctuation">,</span>cfd<span class="token punctuation">)</span><span class="token punctuation">;</span>
			
			<span class="token function">close</span><span class="token punctuation">(</span>cfd<span class="token punctuation">)</span><span class="token punctuation">;</span>
			<span class="token function">pthread_exit</span><span class="token punctuation">(</span><span class="token number">0</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
		<span class="token punctuation">}</span>
		<span class="token keyword">for</span><span class="token punctuation">(</span><span class="token punctuation">;</span>p_tmp<span class="token operator">!=</span>p_tmp1<span class="token punctuation">;</span>p_tmp<span class="token operator">=</span>p_tmp<span class="token operator">-&gt;</span>p_next<span class="token punctuation">)</span><span class="token punctuation">{<!-- --></span>
			node<span class="token operator">*</span> p_first <span class="token operator">=</span> p_tmp<span class="token punctuation">;</span>
			node<span class="token operator">*</span> p_mid <span class="token operator">=</span> p_first<span class="token operator">-&gt;</span>p_next<span class="token punctuation">;</span>
			<span class="token function">printf</span><span class="token punctuation">(</span><span class="token string">"%d:%s\n"</span><span class="token punctuation">,</span>cfd<span class="token punctuation">,</span>buf<span class="token punctuation">)</span><span class="token punctuation">;</span>
			<span class="token function">write</span><span class="token punctuation">(</span>p_first<span class="token operator">-&gt;</span>cfd<span class="token punctuation">,</span>buf<span class="token punctuation">,</span>r<span class="token punctuation">)</span><span class="token punctuation">;</span>
			<span class="token function">printf</span><span class="token punctuation">(</span><span class="token string">"我发给了这个客户端:%d\n"</span><span class="token punctuation">,</span>p_first<span class="token operator">-&gt;</span>cfd<span class="token punctuation">)</span><span class="token punctuation">;</span>
			<span class="token function">write</span><span class="token punctuation">(</span>p_first<span class="token operator">-&gt;</span>cfd<span class="token punctuation">,</span><span class="token string">"\n"</span><span class="token punctuation">,</span><span class="token number">1</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
		<span class="token punctuation">}</span>
	<span class="token punctuation">}</span>
	<span class="token keyword">return</span> <span class="token constant">NULL</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span>

<span class="token keyword">int</span> <span class="token function">main</span><span class="token punctuation">(</span><span class="token keyword">void</span><span class="token punctuation">)</span><span class="token punctuation">{<!-- --></span>
	<span class="token keyword">struct</span> sockaddr_in peer_addr<span class="token punctuation">;</span>
	socklen_t peer_addr_size<span class="token punctuation">;</span>
	peer_addr_size<span class="token operator">=</span><span class="token keyword">sizeof</span><span class="token punctuation">(</span>peer_addr<span class="token punctuation">)</span><span class="token punctuation">;</span>
	<span class="token keyword">int</span> cfd<span class="token punctuation">;</span>
	<span class="token keyword">char</span> IP<span class="token punctuation">[</span><span class="token number">64</span><span class="token punctuation">]</span><span class="token punctuation">;</span>
	<span class="token keyword">int</span> sfd<span class="token punctuation">;</span>
	<span class="token keyword">struct</span> sockaddr_in my_addr<span class="token punctuation">;</span>
	node<span class="token operator">*</span> p_node<span class="token operator">=</span><span class="token constant">NULL</span><span class="token punctuation">;</span>
	head<span class="token punctuation">.</span>p_next <span class="token operator">=</span> <span class="token operator">&amp;</span>tail<span class="token punctuation">;</span>
	tail<span class="token punctuation">.</span>p_next <span class="token operator">=</span> <span class="token constant">NULL</span><span class="token punctuation">;</span>

	sfd <span class="token operator">=</span> <span class="token function">socket</span><span class="token punctuation">(</span>AF_INET<span class="token punctuation">,</span> SOCK_STREAM<span class="token punctuation">,</span> <span class="token number">0</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
	<span class="token keyword">if</span> <span class="token punctuation">(</span>sfd <span class="token operator">==</span> <span class="token operator">-</span><span class="token number">1</span><span class="token punctuation">)</span>
		<span class="token function">perror</span><span class="token punctuation">(</span><span class="token string">"socket"</span><span class="token punctuation">)</span><span class="token punctuation">;</span>

	<span class="token function">memset</span><span class="token punctuation">(</span><span class="token operator">&amp;</span>my_addr<span class="token punctuation">,</span> <span class="token number">0</span><span class="token punctuation">,</span> <span class="token keyword">sizeof</span><span class="token punctuation">(</span><span class="token keyword">struct</span> sockaddr_in<span class="token punctuation">)</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
    
	my_addr<span class="token punctuation">.</span>sin_family <span class="token operator">=</span> AF_INET<span class="token punctuation">;</span>
	my_addr<span class="token punctuation">.</span>sin_port <span class="token operator">=</span> <span class="token function">htons</span><span class="token punctuation">(</span><span class="token number">8080</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
	my_addr<span class="token punctuation">.</span>sin_addr<span class="token punctuation">.</span>s_addr <span class="token operator">=</span> <span class="token function">htonl</span><span class="token punctuation">(</span>INADDR_ANY<span class="token punctuation">)</span><span class="token punctuation">;</span>

	<span class="token keyword">if</span> <span class="token punctuation">(</span><span class="token function">bind</span><span class="token punctuation">(</span>sfd<span class="token punctuation">,</span> <span class="token punctuation">(</span><span class="token keyword">struct</span> sockaddr <span class="token operator">*</span><span class="token punctuation">)</span> <span class="token operator">&amp;</span>my_addr<span class="token punctuation">,</span>
	<span class="token keyword">sizeof</span><span class="token punctuation">(</span><span class="token keyword">struct</span> sockaddr_in<span class="token punctuation">)</span><span class="token punctuation">)</span> <span class="token operator">==</span> <span class="token operator">-</span><span class="token number">1</span><span class="token punctuation">)</span>
		<span class="token function">perror</span><span class="token punctuation">(</span><span class="token string">"bind"</span><span class="token punctuation">)</span><span class="token punctuation">;</span>

	<span class="token keyword">if</span> <span class="token punctuation">(</span><span class="token function">listen</span><span class="token punctuation">(</span>sfd<span class="token punctuation">,</span> <span class="token number">5</span><span class="token punctuation">)</span> <span class="token operator">==</span> <span class="token operator">-</span><span class="token number">1</span><span class="token punctuation">)</span>
	<span class="token function">perror</span><span class="token punctuation">(</span><span class="token string">"listen"</span><span class="token punctuation">)</span><span class="token punctuation">;</span>

	pthread_t tid<span class="token punctuation">;</span>
	<span class="token keyword">void</span><span class="token operator">*</span> tret<span class="token punctuation">;</span>
	<span class="token keyword">while</span><span class="token punctuation">(</span><span class="token number">1</span><span class="token punctuation">)</span><span class="token punctuation">{<!-- --></span>
		node<span class="token operator">*</span> p_newThread<span class="token operator">=</span> <span class="token punctuation">(</span>node<span class="token operator">*</span><span class="token punctuation">)</span><span class="token function">malloc</span><span class="token punctuation">(</span><span class="token keyword">sizeof</span><span class="token punctuation">(</span>node<span class="token punctuation">)</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
		p_newThread<span class="token operator">-&gt;</span>cfd<span class="token operator">=</span><span class="token function">accept</span><span class="token punctuation">(</span>sfd<span class="token punctuation">,</span><span class="token punctuation">(</span><span class="token keyword">struct</span> sockaddr<span class="token operator">*</span><span class="token punctuation">)</span><span class="token operator">&amp;</span>peer_addr<span class="token punctuation">,</span><span class="token operator">&amp;</span>peer_addr_size<span class="token punctuation">)</span><span class="token punctuation">;</span>
		p_newThread<span class="token operator">-&gt;</span>p_next<span class="token operator">=</span><span class="token constant">NULL</span><span class="token punctuation">;</span>

		<span class="token keyword">if</span><span class="token punctuation">(</span>p_newThread<span class="token operator">-&gt;</span>cfd<span class="token operator">==</span><span class="token operator">-</span><span class="token number">1</span><span class="token punctuation">)</span><span class="token function">perror</span><span class="token punctuation">(</span><span class="token string">"accept"</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
		<span class="token keyword">for</span><span class="token punctuation">(</span>p_node<span class="token operator">=</span><span class="token operator">&amp;</span>head<span class="token punctuation">;</span>p_node<span class="token operator">!=</span><span class="token operator">&amp;</span>tail<span class="token punctuation">;</span>p_node<span class="token operator">=</span>p_node<span class="token operator">-&gt;</span>p_next<span class="token punctuation">)</span><span class="token punctuation">{<!-- --></span>
			node<span class="token operator">*</span> p_first <span class="token operator">=</span> p_node<span class="token punctuation">;</span>
			node<span class="token operator">*</span> p_mid <span class="token operator">=</span> p_first<span class="token operator">-&gt;</span>p_next<span class="token punctuation">;</span>
			<span class="token keyword">if</span><span class="token punctuation">(</span>p_mid<span class="token operator">==</span><span class="token operator">&amp;</span>tail<span class="token punctuation">)</span><span class="token punctuation">{<!-- --></span>
				p_first<span class="token operator">-&gt;</span>p_next <span class="token operator">=</span> p_newThread<span class="token punctuation">;</span>
				p_newThread<span class="token operator">-&gt;</span>p_next <span class="token operator">=</span> p_mid<span class="token punctuation">;</span>
			<span class="token punctuation">}</span>
		<span class="token punctuation">}</span>
		<span class="token function">printf</span><span class="token punctuation">(</span><span class="token string">"%d\n"</span><span class="token punctuation">,</span>p_newThread<span class="token operator">-&gt;</span>cfd<span class="token punctuation">)</span><span class="token punctuation">;</span>


		<span class="token function">printf</span><span class="token punctuation">(</span><span class="token string">"IP:%s\n"</span><span class="token punctuation">,</span><span class="token function">inet_ntop</span><span class="token punctuation">(</span>AF_INET<span class="token punctuation">,</span>
						<span class="token operator">&amp;</span>peer_addr<span class="token punctuation">.</span>sin_addr<span class="token punctuation">,</span>IP<span class="token punctuation">,</span><span class="token number">64</span><span class="token punctuation">)</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
		<span class="token function">pthread_create</span><span class="token punctuation">(</span><span class="token operator">&amp;</span>tid<span class="token punctuation">,</span><span class="token constant">NULL</span><span class="token punctuation">,</span>func<span class="token punctuation">,</span><span class="token constant">NULL</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
   <span class="token punctuation">}</span>
   <span class="token function">close</span><span class="token punctuation">(</span>sfd<span class="token punctuation">)</span><span class="token punctuation">;</span>
   <span class="token keyword">return</span> <span class="token number">0</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span>

</code></pre> 
<p>客户端：client.c</p> 
<pre><code>#include &lt;stdio.h&gt;
#include &lt;sys/types.h&gt;
#include &lt;sys/socket.h&gt;
#include &lt;netinet/in.h&gt;
#include &lt;string.h&gt;
#include &lt;unistd.h&gt;
#include &lt;arpa/inet.h&gt;
#include &lt;pthread.h&gt;
#include &lt;strings.h&gt;
#include &lt;stdlib.h&gt;


void* func(void* arg){
	int fd=*(int*)arg;
	char buf[128];
	while(1){
		bzero(buf,128);
		int r=read(fd,buf,128);
		if(r==0)break;
		write(1,buf,r);
		write(1,"\n",1);
		bzero(buf,128);
	}
	exit(0);
	return (void *)0;
}

int main(int argc,char* argv[]){
	char msg[128];
	struct sockaddr_in serv;

	int fd = socket(AF_INET,SOCK_STREAM,0);
	if(fd==-1){perror("socket");return -1;}

	serv.sin_family=AF_INET;
	serv.sin_port=htons(8080);
	inet_pton(AF_INET,argv[1],&amp;serv.sin_addr);

	int c = connect(fd, (struct sockaddr*)&amp;serv,sizeof(serv));
	if(c==-1){perror("connect");return -1;}
	while(1){
		pthread_t tid;
		pthread_create(&amp;tid,NULL,func,&amp;fd);
		bzero(msg,128);
		gets(msg);
		write(fd,msg,strlen(msg));
	}
	return 0;
}

</code></pre> 
<p>Ubuntu16.04和macOS10.13.2<br> 实测已经成功。</p> 
<p>也请大牛们多多指教啊。</p>
                
{% endraw %}
