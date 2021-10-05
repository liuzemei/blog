---
title: 安装remix各种报错？start启动不了？一篇文章帮你搞定。
date: 2018-10-03 19:08:21
layout: post
author: 刘泽美
categories:
  - CSDN文章
  - 导入
tags: 代码人生
---

[原链接](https://blog.csdn.net/weixin_41884153/article/details/82933250)
{% raw %}

                    <svg xmlns="http://www.w3.org/2000/svg" style="display: none;">
                        <path stroke-linecap="round" d="M5,0 0,2.5 5,5z" id="raphael-marker-block" style="-webkit-tap-highlight-color: rgba(0, 0, 0, 0);"></path>
                    </svg>
                    <p>太坑爹了…</p> 
<p>研究各种npm error研究了快两天了，还是没有头绪。</p> 
<p>这个时候两种方法搞定：<br> 1、把node.js卸载掉，npm也卸载掉。重装。</p> 
<p>2、我是采用另外一种方法装好的：</p> 
<p>直接安装remix-ide就好了。</p> 
<pre class=" language-shell"><code class="prism  language-shell">$ <span class="token function">npm</span> <span class="token function">install</span> remix-ide -g
</code></pre> 
<p>结束…</p> 
<p>然后启动的话，就输入</p> 
<pre class=" language-shell"><code class="prism  language-shell">$ remix-ide
</code></pre> 
<p>然后浏览器打开127.0.0.1:8080就搞定了。</p>
                
{% endraw %}
