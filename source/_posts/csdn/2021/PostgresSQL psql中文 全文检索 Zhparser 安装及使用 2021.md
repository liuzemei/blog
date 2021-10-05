---
title: PostgresSQL psql中文 全文检索 Zhparser 安装及使用 2021
date: 2021-08-18 21:09:09
layout: post
author: 刘泽美
categories:
  - CSDN文章
  - 导入
tags: 代码人生
---

[原链接](https://blog.csdn.net/weixin_41884153/article/details/119788891)
{% raw %}

                    <svg xmlns="http://www.w3.org/2000/svg" style="display: none;">
                        <path stroke-linecap="round" d="M5,0 0,2.5 5,5z" id="raphael-marker-block" style="-webkit-tap-highlight-color: rgba(0, 0, 0, 0);"></path>
                    </svg>
                    <blockquote> 
 <p>本文写于 2021/8/18日<br> 系统: ubuntu0.20.04.1<br> psql版本: psql (PostgreSQL) 12.8 (Ubuntu 12.8-0ubuntu0.20.04.1)<br> 参考: https://github.com/amutu/zhparser</p> 
</blockquote> 
<h3><a id="1__SCWS_4"></a>1. 安装 SCWS</h3> 
<pre><code class="prism language-shell"><span class="token function">wget</span> -q -O - http://www.xunsearch.com/scws/down/scws-1.2.3.tar.bz2 <span class="token operator">|</span> <span class="token function">tar</span> xf -
<span class="token builtin class-name">cd</span> scws-1.2.3 <span class="token punctuation">;</span> ./configure <span class="token punctuation">;</span> <span class="token function">make</span> <span class="token function">install</span>
</code></pre> 
<h3><a id="2__zhparser__10"></a>2. 下载 zhparser 源码</h3> 
<blockquote> 
 <p>这里有个问题, 我用的是12 的版本, 如果是其他版本就更换对应的数字<br> 需要先安装 dev 的插件</p> 
</blockquote> 
<pre><code class="prism language-shell"><span class="token function">sudo</span> <span class="token function">apt</span> <span class="token function">install</span> postgresql-server-dev-12
</code></pre> 
<pre><code class="prism language-shell"><span class="token function">git</span> clone https://github.com/amutu/zhparser.git
<span class="token builtin class-name">cd</span> zhparser
<span class="token function">make</span> <span class="token operator">&amp;&amp;</span> <span class="token function">sudo</span> <span class="token function">make</span> <span class="token function">install</span>
</code></pre> 
<h3><a id="3__psql__24"></a>3. 进入 psql 中安装</h3> 
<pre><code class="prism language-sql"><span class="token comment">-- 创建 extension</span>
<span class="token keyword">CREATE</span> EXTENSION zhparser<span class="token punctuation">;</span>

<span class="token comment">-- 使用解析器进行测试配置</span>
<span class="token keyword">CREATE</span> <span class="token keyword">TEXT</span> SEARCH CONFIGURATION testzhcfg <span class="token punctuation">(</span>PARSER <span class="token operator">=</span> zhparser<span class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token comment">-- 添加令牌映射</span>
<span class="token keyword">ALTER</span> <span class="token keyword">TEXT</span> SEARCH CONFIGURATION testzhcfg <span class="token keyword">ADD</span> MAPPING <span class="token keyword">FOR</span> n<span class="token punctuation">,</span>v<span class="token punctuation">,</span>a<span class="token punctuation">,</span>i<span class="token punctuation">,</span>e<span class="token punctuation">,</span>l <span class="token keyword">WITH</span> <span class="token keyword">simple</span><span class="token punctuation">;</span>

<span class="token comment">-- 测试一下 ts_parse</span>
<span class="token keyword">SELECT</span> <span class="token operator">*</span> <span class="token keyword">FROM</span> ts_parse<span class="token punctuation">(</span><span class="token string">'zhparser'</span><span class="token punctuation">,</span> <span class="token string">'hello world! 2010年保障房建设在全国范围内获全面启动，从中央到地方纷纷加大 了保障房的建设和投入力度 。2011年，保障房进入了更大规模的建设阶段。住房城乡建设部党组书记、部长姜伟新去年底在全国住房城乡建设工作会议上表示，要继续推进保障性安居工程建设。'</span><span class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token comment">-- 测试一下 to_tsvector</span>
<span class="token keyword">SELECT</span> to_tsvector<span class="token punctuation">(</span><span class="token string">'testzhcfg'</span><span class="token punctuation">,</span><span class="token string">'“今年保障房新开工数量虽然有所下调，但实际的年度在建规模以及竣工规模会超以往年份，相对应的对资金的需求也会创历&gt;史纪录。”陈国强说。在他看来，与2011年相比，2012年的保障房建设在资金配套上的压力将更为严峻。'</span><span class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token comment">-- 测试一下 to_tsquery</span>
<span class="token keyword">SELECT</span> to_tsquery<span class="token punctuation">(</span><span class="token string">'testzhcfg'</span><span class="token punctuation">,</span> <span class="token string">'保障房资金压力'</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
</code></pre> 
<h3><a id="5__45"></a>5. 完成</h3>
                
{% endraw %}
