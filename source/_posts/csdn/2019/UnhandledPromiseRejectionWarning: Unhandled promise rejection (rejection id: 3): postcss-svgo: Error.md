---
title: "\"UnhandledPromiseRejectionWarning\": Unhandled promise rejection (rejection id: 3): postcss-svgo: Error"
date: 2019-02-02 08:55:22
layout: post
author: 刘泽美
categories:
  - CSDN文章
  - 导入
tags: 代码人生
---

[原链接](https://blog.csdn.net/weixin_41884153/article/details/86747298)
{% raw %}

                    <svg xmlns="http://www.w3.org/2000/svg" style="display: none;">
                        <path stroke-linecap="round" d="M5,0 0,2.5 5,5z" id="raphael-marker-block" style="-webkit-tap-highlight-color: rgba(0, 0, 0, 0);"></path>
                    </svg>
                    <blockquote> 
 <p>用vue-cli脚手架，用mui这个框架，运行 npm run build 时 发生如下错误：</p> 
</blockquote> 
<pre><code class="prism language-shell">Error processing file: static/css/app.efecf6dcdf8d2d9b19398fc99ecf888c.css
<span class="token punctuation">(</span>node:15116<span class="token punctuation">)</span> UnhandledPromiseRejectionWarning: Unhandled promise rejection <span class="token punctuation">(</span>rejection id: 3<span class="token punctuation">)</span>: postcss-svgo: Error <span class="token keyword">in</span> parsing SVG: Unquoted attribute value
Line: 0
Column: 14
Char: \
</code></pre> 
<h3><a id="_10"></a>问题描述：</h3> 
<p>其实问题已经很清楚了，就是指你的static/下面有个css/目录下有个.css文件的SVG没有用双引号。</p> 
<h3><a id="_14"></a>解决方案：</h3> 
<p>我的情况属于在项目工程中导入了mui.css文件，然后mui.css这个文件里面导入svg的时候，没有用双引号。</p> 
<p>于是</p> 
<h4><a id="1static__muicssmuicss_18"></a>1.找到static/ 下的 mui/css目录下，找到mui.css文件</h4> 
<p><img src="https://img-blog.csdnimg.cn/20190202085139844.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MTg4NDE1Mw==,size_16,color_FFFFFF,t_70" alt="大概就是这么个思路"></p> 
<h3><a id="2svgurl_20"></a>2.搜索svg，然后找到后面的url引用的路径。</h3> 
<blockquote> 
 <ul><li>默认这个路径是用单引号的，所以报错。</li><li>把这里的单引号变成<strong>双引号</strong>就OK了</li></ul> 
</blockquote> 
<h3><a id="3_npm_run_build_ok_24"></a>3.再运行 npm run build 提示ok</h3> 
<h3><a id="_26"></a>补充：</h3> 
<p>再补充一点：在nginx部署时，首先要去nginx.conf 里面配置好前端的端口，然后把路径指向 第三步运行出来的 dist 目录 就ok了。</p> 
<p>这样就可以用ip或者你指定的域名进行访问你的前端页面了。</p> 
<p>到此结束~~</p>
                
{% endraw %}
