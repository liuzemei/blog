---
title: 升级了 webstorm 2021 之后的 vim 配置
date: 2021-06-13 10:24:29
layout: post
author: 刘泽美
categories:
  - CSDN文章
  - 导入
tags: 代码人生
---

[原链接](https://blog.csdn.net/weixin_41884153/article/details/117869780)
{% raw %}

                    <svg xmlns="http://www.w3.org/2000/svg" style="display: none;">
                        <path stroke-linecap="round" d="M5,0 0,2.5 5,5z" id="raphael-marker-block" style="-webkit-tap-highlight-color: rgba(0, 0, 0, 0);"></path>
                    </svg>
                    <h3><a id="_webstorm_2021__0"></a>升级了 webstorm 2021 之后…</h3> 
<blockquote> 
 <p>发现 vscode map 不太好使了。<br> 这就对 vim 的操作需求更大一些了。</p> 
</blockquote> 
<h3><a id="1__4"></a>1. 多文件切换</h3> 
<pre><code class="prism language-shell">:n  <span class="token comment"># 下一个文件</span>
:n2 <span class="token comment"># 下两个文件</span>
:N  <span class="token comment"># 上一个文件</span>
:N2 <span class="token comment"># 上两个文件</span>
</code></pre> 
<h3><a id="2__12"></a>2. 分屏显示</h3> 
<pre><code class="prism language-shell">:split  <span class="token comment"># 垂直分屏</span>
:vsplit <span class="token comment"># 水平分屏</span>
</code></pre> 
<h3><a id="3__18"></a>3. 切换分屏</h3> 
<p><code>ctrl + W</code> 松开之后 + 方向键 ： 就会往指定分屏移动</p> 
<blockquote> 
 <p>方向键：<br> <code>j</code> <code>k</code> 为 <code>下</code> <code>上</code><br> <code>h</code> <code>l</code> 为 <code>左</code> <code>右</code></p> 
</blockquote> 
<h3><a id="4__24"></a>4. 撤销和取消撤销</h3> 
<pre><code class="prism language-shell">u <span class="token comment"># 撤销</span>
ctrl + r <span class="token comment"># 取消撤销</span>
</code></pre>
                
{% endraw %}
