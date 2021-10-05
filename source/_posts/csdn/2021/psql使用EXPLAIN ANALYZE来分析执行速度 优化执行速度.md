---
title: psql使用EXPLAIN ANALYZE来分析执行速度 优化执行速度
date: 2021-06-16 07:51:53
layout: post
author: 刘泽美
categories:
  - CSDN文章
  - 导入
tags: 代码人生
---

[原链接](https://blog.csdn.net/weixin_41884153/article/details/117944094)
{% raw %}

                    <svg xmlns="http://www.w3.org/2000/svg" style="display: none;">
                        <path stroke-linecap="round" d="M5,0 0,2.5 5,5z" id="raphael-marker-block" style="-webkit-tap-highlight-color: rgba(0, 0, 0, 0);"></path>
                    </svg>
                    <h1><a id="_EXPLAIN_ANALYZE__0"></a>使用 EXPLAIN ANALYZE 优化查询速度</h1> 
<p>事情的经过是这样</p> 
<blockquote> 
 <p>写了一个消息分发的服务，群内有大概1200人，每个人发一条消息，数据库待分发的消息就增加 1200 条。如果短期内发消息的人特别多且特别频繁。然后每小时清理一次。</p> 
</blockquote> 
<p>这里涉及到两个操作</p> 
<blockquote> 
 <ol><li>从数据库里拿出消息最近的一部分消息。</li><li>发完消息之后，从数据库里更新这些消息。</li></ol> 
</blockquote> 
<p>然后发现，当数据库里的数据大于几十万条之后，消息发送极其缓慢。</p> 
<p>1 和 2 的的查询都是在10s左右。</p> 
<p>于是建立了两个索引之后，1 和 2 的查询速度都降低到了 10ms 以内。</p> 
<p>由于瓶颈是在这里，所以问题也就迎刃而解了。</p> 
<h3><a id="_17"></a>数据库速度分析</h3> 
<ol><li>正常查询</li></ol> 
<pre><code class="prism language-sql"><span class="token keyword">SELECT</span> <span class="token operator">*</span> <span class="token keyword">FROM</span> t1 <span class="token keyword">WHERE</span> a<span class="token operator">=</span><span class="token number">1</span> <span class="token operator">AND</span> b<span class="token operator">=</span><span class="token number">2</span> <span class="token operator">AND</span> c<span class="token operator">=</span><span class="token number">3</span> <span class="token keyword">order</span> <span class="token keyword">by</span> d<span class="token punctuation">,</span>e
</code></pre> 
<blockquote> 
 <p>这个查询，当没有建立索引的时候，数据量一大，就会非常慢。</p> 
</blockquote> 
<ol start="2"><li>查询分析（EXPLAIN ANALYZE）</li></ol> 
<p>其实就是在正常查询的前边加上了 <code>EXPLAIN ANALYZE</code> 就能够获取数据库执行 <code>sql</code> 语句，所经历的过程，以及耗费的时间。</p> 
<pre><code class="prism language-sql"><span class="token keyword">EXPLAIN</span> <span class="token keyword">ANALYZE</span> <span class="token keyword">SELECT</span> <span class="token operator">*</span> <span class="token keyword">FROM</span> t1 <span class="token keyword">WHERE</span> a<span class="token operator">=</span><span class="token number">1</span> <span class="token operator">AND</span> b<span class="token operator">=</span><span class="token number">2</span> <span class="token operator">AND</span> c<span class="token operator">=</span><span class="token number">3</span> <span class="token keyword">ORDER</span> <span class="token keyword">BY</span> d<span class="token punctuation">,</span>e<span class="token punctuation">;</span>
</code></pre> 
<p>就会得到如下结果</p> 
<pre><code class="prism language-sql"><span class="token keyword">Limit</span>  <span class="token punctuation">(</span>cost<span class="token operator">=</span><span class="token number">6.82</span><span class="token punctuation">.</span><span class="token number">.6</span><span class="token number">.83</span> <span class="token keyword">rows</span><span class="token operator">=</span><span class="token number">1</span> width<span class="token operator">=</span><span class="token number">287</span><span class="token punctuation">)</span> <span class="token punctuation">(</span>actual <span class="token keyword">time</span><span class="token operator">=</span><span class="token number">0.040</span><span class="token punctuation">.</span><span class="token number">.0</span><span class="token number">.041</span> <span class="token keyword">rows</span><span class="token operator">=</span><span class="token number">0</span> loops<span class="token operator">=</span><span class="token number">1</span><span class="token punctuation">)</span>
  <span class="token operator">-</span><span class="token operator">&gt;</span>  Sort  <span class="token punctuation">(</span>cost<span class="token operator">=</span><span class="token number">6.82</span><span class="token punctuation">.</span><span class="token number">.6</span><span class="token number">.83</span> <span class="token keyword">rows</span><span class="token operator">=</span><span class="token number">1</span> width<span class="token operator">=</span><span class="token number">287</span><span class="token punctuation">)</span> <span class="token punctuation">(</span>actual <span class="token keyword">time</span><span class="token operator">=</span><span class="token number">0.039</span><span class="token punctuation">.</span><span class="token number">.0</span><span class="token number">.040</span> <span class="token keyword">rows</span><span class="token operator">=</span><span class="token number">0</span> loops<span class="token operator">=</span><span class="token number">1</span><span class="token punctuation">)</span>
<span class="token string">"        Sort Key: d, e"</span>
        Sort Method: quicksort  Memory: <span class="token number">25</span>kB
              <span class="token keyword">Index</span> Cond: <span class="token punctuation">(</span>a <span class="token operator">=</span> <span class="token number">1</span><span class="token punctuation">)</span>
              Filter: <span class="token punctuation">(</span><span class="token punctuation">(</span>b <span class="token operator">=</span> <span class="token number">2</span><span class="token punctuation">)</span> <span class="token operator">AND</span> <span class="token punctuation">(</span>c <span class="token operator">=</span> <span class="token number">3</span><span class="token punctuation">)</span><span class="token punctuation">)</span>
Planning <span class="token keyword">Time</span>: <span class="token number">0.695</span> ms
Execution <span class="token keyword">Time</span>: <span class="token number">0.065</span> ms
</code></pre> 
<p>可以看到，这里其实只用到了 a (假设他是 pk)，这一个字段的索引，数据量大了，就会非常非常慢。<br> <code>所以，这里的解决方案也是讲 a/b/c/d/e 这五个字段全部进行索引</code>。这样的话，这条<code>sql</code>语句的执行，就是毫秒级的了。</p> 
<pre><code class="prism language-sql"><span class="token keyword">CREATE</span> <span class="token keyword">INDEX</span> t1_a_b_c_d_e_idx <span class="token keyword">ON</span> t1<span class="token punctuation">(</span>a<span class="token punctuation">,</span>b<span class="token punctuation">,</span>c<span class="token punctuation">,</span>d<span class="token punctuation">,</span>e<span class="token punctuation">)</span><span class="token punctuation">;</span>
</code></pre> 
<p>执行这条语句，就会给 t1 这个表，添加 <code>a/b/c/d/e</code> 的索引，同时用 <code>a/b/c/d/e</code> 进行查询的时候，就会优先使用这个索引，从而达到毫秒级的查询速度。</p> 
<p>最后，我们再用添加完索引之后的表，再进行 <code>EXPLAIN ANALYZE</code>一下。</p> 
<pre><code class="prism language-sql"><span class="token keyword">EXPLAIN</span> <span class="token keyword">ANALYZE</span> <span class="token keyword">SELECT</span> <span class="token operator">*</span> <span class="token keyword">FROM</span> t1 <span class="token keyword">WHERE</span> a<span class="token operator">=</span><span class="token number">1</span> <span class="token operator">AND</span> b<span class="token operator">=</span><span class="token number">2</span> <span class="token operator">AND</span> c<span class="token operator">=</span><span class="token number">3</span> <span class="token keyword">ORDER</span> <span class="token keyword">BY</span> d<span class="token punctuation">,</span>e<span class="token punctuation">;</span>
</code></pre> 
<pre><code class="prism language-sql"><span class="token keyword">Limit</span> <span class="token punctuation">(</span>cost<span class="token operator">=</span><span class="token number">0.41</span><span class="token punctuation">.</span><span class="token number">.8</span><span class="token number">.42</span> <span class="token keyword">rows</span><span class="token operator">=</span><span class="token number">1</span> width<span class="token operator">=</span><span class="token number">308</span><span class="token punctuation">)</span> <span class="token punctuation">(</span>actual <span class="token keyword">time</span><span class="token operator">=</span><span class="token number">0.015</span><span class="token punctuation">.</span><span class="token number">.0</span><span class="token number">.015</span> <span class="token keyword">rows</span><span class="token operator">=</span><span class="token number">0</span> loops<span class="token operator">=</span><span class="token number">1</span><span class="token punctuation">)</span>
<span class="token operator">-</span><span class="token operator">&gt;</span> <span class="token keyword">Index</span> Scan <span class="token keyword">using</span> t1_a_b_c_d_e_idx <span class="token keyword">on</span> t1 <span class="token punctuation">(</span>cost<span class="token operator">=</span><span class="token number">0.41</span><span class="token punctuation">.</span><span class="token number">.8</span><span class="token number">.42</span> <span class="token keyword">rows</span><span class="token operator">=</span><span class="token number">1</span> width<span class="token operator">=</span><span class="token number">308</span><span class="token punctuation">)</span> <span class="token punctuation">(</span>actual <span class="token keyword">time</span><span class="token operator">=</span><span class="token number">0.014</span><span class="token punctuation">.</span><span class="token number">.0</span><span class="token number">.014</span> <span class="token keyword">rows</span><span class="token operator">=</span><span class="token number">0</span> loops<span class="token operator">=</span><span class="token number">1</span><span class="token punctuation">)</span>
<span class="token keyword">Index</span> Cond: <span class="token punctuation">(</span><span class="token punctuation">(</span>a <span class="token operator">=</span> <span class="token number">1</span><span class="token punctuation">)</span> <span class="token operator">AND</span> <span class="token punctuation">(</span>b<span class="token operator">=</span><span class="token number">2</span><span class="token punctuation">)</span> <span class="token operator">AND</span> <span class="token punctuation">(</span>c<span class="token operator">=</span><span class="token number">3</span><span class="token punctuation">)</span><span class="token punctuation">)</span>
Planning <span class="token keyword">Time</span>: <span class="token number">0.123</span> ms
Execution <span class="token keyword">Time</span>: <span class="token number">0.034</span> ms
</code></pre> 
<p>可以看到，这个查询路径更短，而且一上来首先就直接使用了 <code>t1_a_b_c_d_e_idx</code> 这个索引来进行查询，后边的就是在索引之后的结果里操作的，这样非常快了。</p>
                
{% endraw %}
