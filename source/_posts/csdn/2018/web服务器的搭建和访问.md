---
title: web服务器的搭建和访问
date: 2018-08-22 07:10:09
layout: post
author: 刘泽美
categories:
  - CSDN文章
  - 导入
tags: 代码人生
---

[原链接](https://blog.csdn.net/weixin_41884153/article/details/81937306)
{% raw %}

                    <svg xmlns="http://www.w3.org/2000/svg" style="display: none;">
                        <path stroke-linecap="round" d="M5,0 0,2.5 5,5z" id="raphael-marker-block" style="-webkit-tap-highlight-color: rgba(0, 0, 0, 0);"></path>
                    </svg>
                    <p>这是我做的算是第二个项目了吧…</p> 
<p>第一个项目应该是扫雷，代码之前弄丢了，改天再写一份上传。</p> 
<p>这个项目的需求是：<br> <strong>从浏览器访问服务器，然后获取一个网页，该网页需要有文本文件和图片文件。</strong></p> 
<p>思路：<br> 1、制作index.html文件、404.html文件、下载一个mypic.jpeg文件，放入工作路径下。<br> 2、编写头文件t_net.h，并写头文件卫士、include、和typedef以及函数声明。<br> 3、封装服务器的socket和bind函数，函数名为s_bind，封装文件为：t_net.c<br> 4、封装服务器的业务处理文件、函数名为do_main，封装文件尾：do_main.c<br> 5、编写主函数server.c，并调用t_net.c和do_main.c</p> 
<p>核心的业务注意事项：<br> 1、对浏览器发送的连接请求，先向浏览器回应标准http协议头，然后再将index.html文件发送给浏览器。<br> 2、这里涉及到2次请求(一次网页，一次图片)，所以在服务器端需要accept两次，才能正常接收到所有的网页请求。<br> 3、若没有找到页面文件，需要返回一个404.html，我这里取了个巧，用open的flags里边的互斥标签，O_CREAT和O_EXCL进行判断这个文件是否存在。可能会出现一些问题，但目前还不得而知。</p> 
<p>好，业务缕清楚了。代码如下：</p> 
<p><strong>index.html</strong>文件就随便写了，代码参见：</p> 
<pre><code class="language-html"><code class="prism  language-html"><span class="token tag"><span class="token tag"><span class="token punctuation">&lt;</span>html</span><span class="token punctuation">&gt;</span></span>
	<span class="token tag"><span class="token tag"><span class="token punctuation">&lt;</span>head</span><span class="token punctuation">&gt;</span></span><span class="token tag"><span class="token tag"><span class="token punctuation">&lt;</span>title</span><span class="token punctuation">&gt;</span></span>Test Page<span class="token tag"><span class="token tag"><span class="token punctuation">&lt;/</span>title</span><span class="token punctuation">&gt;</span></span><span class="token tag"><span class="token tag"><span class="token punctuation">&lt;/</span>head</span><span class="token punctuation">&gt;</span></span>
	<span class="token tag"><span class="token tag"><span class="token punctuation">&lt;</span>body</span><span class="token punctuation">&gt;</span></span>
        <span class="token tag"><span class="token tag"><span class="token punctuation">&lt;</span>p</span><span class="token punctuation">&gt;</span></span>This is my wife:<span class="token tag"><span class="token tag"><span class="token punctuation">&lt;/</span>p</span><span class="token punctuation">&gt;</span></span>
		<span class="token tag"><span class="token tag"><span class="token punctuation">&lt;</span>img</span> <span class="token attr-name">src</span><span class="token attr-value"><span class="token punctuation">=</span><span class="token punctuation">'</span>mypic.jpeg<span class="token punctuation">'</span></span><span class="token punctuation">&gt;</span></span>
	<span class="token tag"><span class="token tag"><span class="token punctuation">&lt;/</span>body</span><span class="token punctuation">&gt;</span></span>
<span class="token tag"><span class="token tag"><span class="token punctuation">&lt;/</span>html</span><span class="token punctuation">&gt;</span></span>
</code></code></pre> 
<p><strong>404.html</strong>代码参见：</p> 
<pre><code class="language-html"><code class="prism  language-html"><span class="token tag"><span class="token tag"><span class="token punctuation">&lt;</span>html</span><span class="token punctuation">&gt;</span></span>
	<span class="token tag"><span class="token tag"><span class="token punctuation">&lt;</span>body</span><span class="token punctuation">&gt;</span></span>request file not found<span class="token tag"><span class="token tag"><span class="token punctuation">&lt;/</span>body</span><span class="token punctuation">&gt;</span></span>
<span class="token tag"><span class="token tag"><span class="token punctuation">&lt;/</span>html</span><span class="token punctuation">&gt;</span></span>
</code></code></pre> 
<p><strong>t_net.h:</strong></p> 
<pre class=" language-c"><code class="prism  language-c"><span class="token macro property">#<span class="token directive keyword">ifndef</span> T_NET_H__</span>
<span class="token macro property">#<span class="token directive keyword">define</span> T_NET_H__</span>
<span class="token macro property">#<span class="token directive keyword">include</span> <span class="token string">&lt;sys/types.h&gt;</span></span>
<span class="token macro property">#<span class="token directive keyword">include</span> <span class="token string">&lt;sys/socket.h&gt;</span></span>
<span class="token macro property">#<span class="token directive keyword">include</span> <span class="token string">&lt;unistd.h&gt;</span></span>
<span class="token macro property">#<span class="token directive keyword">include</span> <span class="token string">&lt;sys/stat.h&gt;</span></span>
<span class="token macro property">#<span class="token directive keyword">include</span> <span class="token string">&lt;fcntl.h&gt;</span></span>
<span class="token macro property">#<span class="token directive keyword">include</span> <span class="token string">&lt;netinet/in.h&gt;</span></span>
<span class="token macro property">#<span class="token directive keyword">include</span> <span class="token string">&lt;netinet/ip.h&gt;</span></span>

<span class="token keyword">typedef</span> <span class="token keyword">struct</span> sockaddr SA<span class="token punctuation">;</span>
<span class="token keyword">typedef</span> <span class="token keyword">struct</span> sockaddr_in SA4<span class="token punctuation">;</span>

<span class="token keyword">int</span> <span class="token function">s_bind</span><span class="token punctuation">(</span><span class="token keyword">int</span> domain<span class="token punctuation">,</span> <span class="token keyword">int</span> type<span class="token punctuation">,</span> <span class="token keyword">unsigned</span> <span class="token keyword">short</span> port<span class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token macro property">#<span class="token directive keyword">endif</span></span>
</code></pre> 
<p>封装的socket和bind函数文件t_net.c参见：</p> 
<pre class=" language-c"><code class="prism  language-c"><span class="token macro property">#<span class="token directive keyword">include</span> <span class="token string">&lt;stdio.h&gt;</span></span>
<span class="token macro property">#<span class="token directive keyword">include</span> <span class="token string">"t_net.h"</span></span>

<span class="token keyword">int</span> <span class="token function">s_bind</span><span class="token punctuation">(</span><span class="token keyword">int</span> domain<span class="token punctuation">,</span><span class="token keyword">int</span> type<span class="token punctuation">,</span><span class="token keyword">unsigned</span> <span class="token keyword">short</span> port<span class="token punctuation">)</span><span class="token punctuation">{<!-- --></span>
    
    SA4 serv<span class="token punctuation">;</span>
    <span class="token comment">//创建一个通讯端点,返回一个文件描述符</span>
    <span class="token keyword">int</span> lfd<span class="token operator">=</span><span class="token function">socket</span><span class="token punctuation">(</span>domain<span class="token punctuation">,</span>type<span class="token punctuation">,</span><span class="token number">0</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
    <span class="token keyword">if</span><span class="token punctuation">(</span>lfd<span class="token operator">==</span><span class="token operator">-</span><span class="token number">1</span><span class="token punctuation">)</span><span class="token punctuation">{<!-- --></span>
        <span class="token function">perror</span><span class="token punctuation">(</span><span class="token string">"socket"</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
        <span class="token keyword">return</span> <span class="token operator">-</span><span class="token number">1</span><span class="token punctuation">;</span>
    <span class="token punctuation">}</span>
    <span class="token comment">//需要对serv变量的成员进行初始化</span>
    serv<span class="token punctuation">.</span>sin_family<span class="token operator">=</span>AF_INET<span class="token punctuation">;</span>
    serv<span class="token punctuation">.</span>sin_port<span class="token operator">=</span><span class="token function">htons</span><span class="token punctuation">(</span>port<span class="token punctuation">)</span><span class="token punctuation">;</span>
    serv<span class="token punctuation">.</span>sin_addr<span class="token punctuation">.</span>s_addr<span class="token operator">=</span><span class="token function">htonl</span><span class="token punctuation">(</span>INADDR_ANY<span class="token punctuation">)</span><span class="token punctuation">;</span>
    <span class="token comment">//将serv绑定到lfd上.</span>
    <span class="token keyword">int</span> b<span class="token operator">=</span><span class="token function">bind</span><span class="token punctuation">(</span>lfd<span class="token punctuation">,</span><span class="token punctuation">(</span>SA <span class="token operator">*</span><span class="token punctuation">)</span><span class="token operator">&amp;</span>serv<span class="token punctuation">,</span><span class="token keyword">sizeof</span><span class="token punctuation">(</span>serv<span class="token punctuation">)</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
    <span class="token keyword">if</span><span class="token punctuation">(</span>b<span class="token operator">==</span><span class="token operator">-</span><span class="token number">1</span><span class="token punctuation">)</span><span class="token punctuation">{<!-- --></span>
        <span class="token function">perror</span><span class="token punctuation">(</span><span class="token string">"bind"</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
        <span class="token keyword">return</span> <span class="token operator">-</span><span class="token number">1</span><span class="token punctuation">;</span>
    <span class="token punctuation">}</span>
    <span class="token keyword">return</span> lfd<span class="token punctuation">;</span>

<span class="token punctuation">}</span>

</code></pre> 
<p>domain还没来得及封装，一块参见server.c吧。</p> 
<pre class=" language-c"><code class="prism  language-c"><span class="token macro property">#<span class="token directive keyword">include</span> <span class="token string">&lt;stdio.h&gt;</span></span>
<span class="token macro property">#<span class="token directive keyword">include</span> <span class="token string">"t_net.h"</span></span>
<span class="token macro property">#<span class="token directive keyword">include</span> <span class="token string">&lt;stdlib.h&gt;</span></span>
<span class="token macro property">#<span class="token directive keyword">include</span> <span class="token string">&lt;string.h&gt;</span></span>

<span class="token keyword">int</span> <span class="token function">main</span><span class="token punctuation">(</span><span class="token keyword">void</span><span class="token punctuation">)</span><span class="token punctuation">{<!-- --></span>
    <span class="token keyword">int</span> conn_fd<span class="token punctuation">;</span><span class="token comment">//用于和客户端连接的描述符</span>
    <span class="token keyword">char</span> IP<span class="token punctuation">[</span><span class="token number">64</span><span class="token punctuation">]</span><span class="token punctuation">;</span>
	<span class="token keyword">char</span> buf<span class="token punctuation">[</span><span class="token number">102400</span><span class="token punctuation">]</span><span class="token punctuation">;</span>
    SA4  cli<span class="token punctuation">;</span>
    socklen_t cli_len<span class="token punctuation">;</span>
    <span class="token keyword">int</span> lfd<span class="token operator">=</span><span class="token function">s_bind</span><span class="token punctuation">(</span>AF_INET<span class="token punctuation">,</span>SOCK_STREAM<span class="token punctuation">,</span><span class="token number">8000</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
    <span class="token keyword">if</span><span class="token punctuation">(</span>lfd<span class="token operator">==</span><span class="token operator">-</span><span class="token number">1</span><span class="token punctuation">)</span> <span class="token keyword">return</span> <span class="token operator">-</span><span class="token number">1</span><span class="token punctuation">;</span>
    
    <span class="token function">listen</span><span class="token punctuation">(</span>lfd<span class="token punctuation">,</span><span class="token number">5</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
    <span class="token keyword">while</span><span class="token punctuation">(</span><span class="token number">1</span><span class="token punctuation">)</span><span class="token punctuation">{<!-- --></span>
        cli_len<span class="token operator">=</span><span class="token keyword">sizeof</span><span class="token punctuation">(</span>cli<span class="token punctuation">)</span><span class="token punctuation">;</span>
        conn_fd<span class="token operator">=</span><span class="token function">accept</span><span class="token punctuation">(</span>lfd<span class="token punctuation">,</span><span class="token punctuation">(</span>SA <span class="token operator">*</span><span class="token punctuation">)</span><span class="token operator">&amp;</span>cli<span class="token punctuation">,</span><span class="token operator">&amp;</span>cli_len<span class="token punctuation">)</span><span class="token punctuation">;</span>
        <span class="token keyword">if</span><span class="token punctuation">(</span>conn_fd<span class="token operator">==</span><span class="token number">1</span><span class="token punctuation">)</span><span class="token punctuation">{<!-- --></span>
            <span class="token function">perror</span><span class="token punctuation">(</span><span class="token string">"accept"</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
            <span class="token keyword">return</span> <span class="token operator">-</span><span class="token number">1</span><span class="token punctuation">;</span>
        <span class="token punctuation">}</span>
		<span class="token comment">//业务处理</span>
		pid_t pid<span class="token operator">=</span><span class="token function">fork</span><span class="token punctuation">(</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
		<span class="token keyword">if</span><span class="token punctuation">(</span>pid<span class="token operator">==</span><span class="token operator">-</span><span class="token number">1</span><span class="token punctuation">)</span><span class="token punctuation">{<!-- --></span><span class="token function">perror</span><span class="token punctuation">(</span><span class="token string">"fork"</span><span class="token punctuation">)</span><span class="token punctuation">;</span><span class="token keyword">return</span> <span class="token operator">-</span><span class="token number">1</span><span class="token punctuation">;</span><span class="token punctuation">}</span>
		<span class="token keyword">if</span><span class="token punctuation">(</span>pid<span class="token operator">==</span><span class="token number">0</span><span class="token punctuation">)</span><span class="token punctuation">{<!-- --></span>
			<span class="token function">close</span><span class="token punctuation">(</span>lfd<span class="token punctuation">)</span><span class="token punctuation">;</span>
			<span class="token keyword">char</span> <span class="token operator">*</span>html<span class="token operator">=</span><span class="token string">"HTTP/1.1 200 OK\r\nContent-Type: text/html\r\n\r\n"</span><span class="token punctuation">;</span>
			<span class="token function">write</span><span class="token punctuation">(</span>conn_fd<span class="token punctuation">,</span> html<span class="token punctuation">,</span><span class="token function">strlen</span><span class="token punctuation">(</span>html<span class="token punctuation">)</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
			<span class="token keyword">int</span> web<span class="token operator">=</span><span class="token function">open</span><span class="token punctuation">(</span><span class="token string">"index.html"</span><span class="token punctuation">,</span>O_RDONLY<span class="token operator">|</span>O_CREAT<span class="token operator">|</span>O_EXCL<span class="token punctuation">)</span><span class="token punctuation">;</span>
			<span class="token keyword">if</span><span class="token punctuation">(</span>web<span class="token operator">==</span><span class="token operator">-</span><span class="token number">1</span><span class="token punctuation">)</span><span class="token punctuation">{<!-- --></span>
				web<span class="token operator">=</span><span class="token function">open</span><span class="token punctuation">(</span><span class="token string">"index.html"</span><span class="token punctuation">,</span>O_RDONLY<span class="token punctuation">)</span><span class="token punctuation">;</span>
				<span class="token keyword">int</span> r<span class="token operator">=</span><span class="token function">read</span><span class="token punctuation">(</span>web<span class="token punctuation">,</span> buf<span class="token punctuation">,</span> <span class="token number">102400</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
				<span class="token function">write</span><span class="token punctuation">(</span>conn_fd<span class="token punctuation">,</span> buf<span class="token punctuation">,</span>r<span class="token punctuation">)</span><span class="token punctuation">;</span>
				<span class="token function">close</span><span class="token punctuation">(</span>conn_fd<span class="token punctuation">)</span><span class="token punctuation">;</span>
				<span class="token function">exit</span><span class="token punctuation">(</span><span class="token number">0</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
			<span class="token punctuation">}</span><span class="token keyword">else</span><span class="token punctuation">{<!-- --></span>
				<span class="token function">close</span><span class="token punctuation">(</span>web<span class="token punctuation">)</span><span class="token punctuation">;</span>
				<span class="token function">remove</span><span class="token punctuation">(</span><span class="token string">"index.html"</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
				<span class="token keyword">int</span> web<span class="token operator">=</span><span class="token function">open</span><span class="token punctuation">(</span><span class="token string">"404.html"</span><span class="token punctuation">,</span>O_RDONLY<span class="token punctuation">)</span><span class="token punctuation">;</span>
				<span class="token keyword">if</span><span class="token punctuation">(</span>web<span class="token operator">==</span><span class="token operator">-</span><span class="token number">1</span><span class="token punctuation">)</span><span class="token punctuation">{<!-- --></span><span class="token function">perror</span><span class="token punctuation">(</span><span class="token string">"open"</span><span class="token punctuation">)</span><span class="token punctuation">;</span><span class="token keyword">return</span> <span class="token operator">-</span><span class="token number">1</span><span class="token punctuation">;</span><span class="token punctuation">}</span>
				<span class="token keyword">int</span> r<span class="token operator">=</span><span class="token function">read</span><span class="token punctuation">(</span>web<span class="token punctuation">,</span> buf<span class="token punctuation">,</span> <span class="token number">102400</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
				<span class="token function">write</span><span class="token punctuation">(</span>conn_fd<span class="token punctuation">,</span> buf<span class="token punctuation">,</span>r<span class="token punctuation">)</span><span class="token punctuation">;</span>
				<span class="token function">close</span><span class="token punctuation">(</span>conn_fd<span class="token punctuation">)</span><span class="token punctuation">;</span>
				<span class="token function">exit</span><span class="token punctuation">(</span><span class="token number">0</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
			<span class="token punctuation">}</span>
		<span class="token punctuation">}</span><span class="token keyword">else</span><span class="token punctuation">{<!-- --></span>
			<span class="token function">close</span><span class="token punctuation">(</span>conn_fd<span class="token punctuation">)</span><span class="token punctuation">;</span>
		<span class="token punctuation">}</span>
        conn_fd<span class="token operator">=</span><span class="token function">accept</span><span class="token punctuation">(</span>lfd<span class="token punctuation">,</span><span class="token punctuation">(</span>SA <span class="token operator">*</span><span class="token punctuation">)</span><span class="token operator">&amp;</span>cli<span class="token punctuation">,</span><span class="token operator">&amp;</span>cli_len<span class="token punctuation">)</span><span class="token punctuation">;</span>
        <span class="token keyword">if</span><span class="token punctuation">(</span>conn_fd<span class="token operator">==</span><span class="token number">1</span><span class="token punctuation">)</span><span class="token punctuation">{<!-- --></span>
            <span class="token function">perror</span><span class="token punctuation">(</span><span class="token string">"accept"</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
            <span class="token keyword">return</span> <span class="token operator">-</span><span class="token number">1</span><span class="token punctuation">;</span>
        <span class="token punctuation">}</span>
		pid_t pid1<span class="token operator">=</span><span class="token function">fork</span><span class="token punctuation">(</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
		<span class="token keyword">if</span><span class="token punctuation">(</span>pid1<span class="token operator">==</span><span class="token operator">-</span><span class="token number">1</span><span class="token punctuation">)</span><span class="token punctuation">{<!-- --></span><span class="token function">perror</span><span class="token punctuation">(</span><span class="token string">"fork"</span><span class="token punctuation">)</span><span class="token punctuation">;</span><span class="token keyword">return</span> <span class="token operator">-</span><span class="token number">1</span><span class="token punctuation">;</span><span class="token punctuation">}</span>
		<span class="token keyword">if</span><span class="token punctuation">(</span>pid1<span class="token operator">==</span><span class="token number">0</span><span class="token punctuation">)</span><span class="token punctuation">{<!-- --></span>
			<span class="token function">close</span><span class="token punctuation">(</span>lfd<span class="token punctuation">)</span><span class="token punctuation">;</span>
			<span class="token keyword">char</span> <span class="token operator">*</span>img<span class="token operator">=</span><span class="token string">"HTTP/1.1 200 OK\r\nContent-Type: image/jpeg\r\n\r\n"</span><span class="token punctuation">;</span>
			<span class="token function">write</span><span class="token punctuation">(</span>conn_fd<span class="token punctuation">,</span> img<span class="token punctuation">,</span><span class="token function">strlen</span><span class="token punctuation">(</span>img<span class="token punctuation">)</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
			<span class="token keyword">int</span> web1<span class="token operator">=</span><span class="token function">open</span><span class="token punctuation">(</span><span class="token string">"mypic.jpeg"</span><span class="token punctuation">,</span>O_RDONLY<span class="token punctuation">)</span><span class="token punctuation">;</span>
			<span class="token keyword">int</span> r1<span class="token operator">=</span><span class="token function">read</span><span class="token punctuation">(</span>web1<span class="token punctuation">,</span> buf<span class="token punctuation">,</span> <span class="token number">102400</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
			<span class="token function">write</span><span class="token punctuation">(</span>conn_fd<span class="token punctuation">,</span> buf<span class="token punctuation">,</span>r1<span class="token punctuation">)</span><span class="token punctuation">;</span>
			<span class="token function">close</span><span class="token punctuation">(</span>conn_fd<span class="token punctuation">)</span><span class="token punctuation">;</span>
			<span class="token function">exit</span><span class="token punctuation">(</span><span class="token number">0</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
		<span class="token punctuation">}</span><span class="token keyword">else</span><span class="token punctuation">{<!-- --></span>
			<span class="token function">close</span><span class="token punctuation">(</span>conn_fd<span class="token punctuation">)</span><span class="token punctuation">;</span>
		<span class="token punctuation">}</span>

	<span class="token punctuation">}</span>
    <span class="token function">close</span><span class="token punctuation">(</span>lfd<span class="token punctuation">)</span><span class="token punctuation">;</span>
    <span class="token keyword">return</span> <span class="token number">0</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span>
</code></pre> 
<p>整个项目到这里就全部结束了。</p> 
<p>这里用的操作系统是：Ubuntu 16.04</p> 
<p>先把服务器起了，然后打开127.0.0.1:8000</p> 
<p>返回的效果如下：<br> <img src="https://img-blog.csdn.net/20180822070906819?watermark/2/text/aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MTg4NDE1Mw==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70" alt="这里写图片描述"></p> 
<p>当然没显示全啦哈哈。</p>
                
{% endraw %}
