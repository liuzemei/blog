---
title: 如何在ubuntu系统下更新源并安装搜狗输入法
date: 2018-08-09 10:14:07
layout: post
author: 刘泽美
categories:
  - CSDN文章
  - 导入
tags: 代码人生
---

[原链接](https://blog.csdn.net/weixin_41884153/article/details/81531650)
{% raw %}

                    <svg xmlns="http://www.w3.org/2000/svg" style="display: none;">
                        <path stroke-linecap="round" d="M5,0 0,2.5 5,5z" id="raphael-marker-block" style="-webkit-tap-highlight-color: rgba(0, 0, 0, 0);"></path>
                    </svg>
                    <p>ü首先，点击右上角</p> 
<p><img src="https://img-blog.csdn.net/20180809100718617?watermark/2/text/aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MTg4NDE1Mw==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70" alt="输入so后打开这个文件"></p> 
<p><img src="https://img-blog.csdn.net/2018080910082366?watermark/2/text/aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MTg4NDE1Mw==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70" alt="第二步"></p> 
<p>把图中的5个全部勾选</p> 
<p>再点击<code>Download from:</code>的下拉菜单</p> 
<p>选择最后一个Other…</p> 
<p>再点右边的<code>Select Best Server</code></p> 
<p>最后点确定。</p> 
<p>中间有几次需要输入密码，直接输入就行。</p> 
<p>最后点关闭的时候有提示，一定不能点取消。否则就前功尽弃了、</p> 
<p>需要点更新。结束之后说明源文件已经更新好了。</p> 
<p>下面是安装搜狗输入法命令：</p> 
<pre class=" language-shell"><code class="prism  language-shell"> <span class="token function">wget</span> <span class="token string">"http://pinyin.sogou.com/linux/download.php?f=linux&amp;bit=64"</span> -O <span class="token string">"sougou_64.deb"</span>
 
 <span class="token function">sudo</span> dpkg -i sougou_64.deb
</code></pre> 
<p>上面的搜狗输入法安装完成后，设置系统的输入法：<br> 通过 系统设置&gt;语言支持&gt;键盘输入方式系统， 然后选择 fcitx 项</p> 
<p>最后注销系统并重新登陆，在屏幕右上角就能看见输入法了，然后选择搜狗拼音就可使用并输入了。</p> 
<p>如果只有一个keyboard - Chinese<br> 就点最后的setting然后，找“+”拉到最后把sougoupinyin加进去就行了、</p>
                
{% endraw %}
