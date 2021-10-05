---
title: mongodb修改器一览表
date: 2019-01-29 16:40:30
layout: post
author: 刘泽美
categories:
  - CSDN文章
  - 导入
tags: 代码人生
---

[原链接](https://blog.csdn.net/weixin_41884153/article/details/86692015)
{% raw %}

                    <svg xmlns="http://www.w3.org/2000/svg" style="display: none;">
                        <path stroke-linecap="round" d="M5,0 0,2.5 5,5z" id="raphael-marker-block" style="-webkit-tap-highlight-color: rgba(0, 0, 0, 0);"></path>
                    </svg>
                    <blockquote> 
 <p>本文对原文进行了格式化和排版操作，作者大神讲得非常清楚。mongodb_修改器（<span class="katex--inline"><span class="katex"><span class="katex-mathml">
     
      
       
        
         i
        
        
         n
        
        
         c
        
        
         /
        
       
       
        inc/
       
      
     </span><span class="katex-html"><span class="base"><span class="strut" style="height: 1em; vertical-align: -0.25em;"></span><span class="mord mathit">i</span><span class="mord mathit">n</span><span class="mord mathit">c</span><span class="mord">/</span></span></span></span></span>set/<span class="katex--inline"><span class="katex"><span class="katex-mathml">
     
      
       
        
         u
        
        
         n
        
        
         s
        
        
         e
        
        
         t
        
        
         /
        
       
       
        unset/
       
      
     </span><span class="katex-html"><span class="base"><span class="strut" style="height: 1em; vertical-align: -0.25em;"></span><span class="mord mathit">u</span><span class="mord mathit">n</span><span class="mord mathit">s</span><span class="mord mathit">e</span><span class="mord mathit">t</span><span class="mord">/</span></span></span></span></span>push/$pop/upsert…）<br> mongodb CRUD 增删改查一应俱全 Mark一下。希望能帮到更多的人。<br> 原文：<a href="https://blog.csdn.net/MCpang/article/details/7752736">https://blog.csdn.net/MCpang/article/details/7752736</a> ,</p> 
</blockquote> 
<p>对于文档的更新除替换外，针对某个或多个文档只需要部分更新可使用原子的更新修改器，能够高效的进行文档更新。更新修改器是中特殊的键，<br> 用来指定复杂的操作，比如增加、删除或者调整键，还可能是操作数组或者内嵌文档。</p> 
<h1><a id="1inc_7"></a>1.$inc</h1> 
<p>这个修改器干什么使的呢？看看下面示例的具体操作后的结果即可知道。</p> 
<p>示例文档：{“uid”:“201203”,“type”:“1”,size:10}</p> 
<pre><code class="prism language-shell"><span class="token operator">&gt;</span> db.b.insert<span class="token punctuation">(</span><span class="token punctuation">{<!-- --></span><span class="token string">"uid"</span><span class="token keyword">:</span><span class="token string">"201203"</span>,<span class="token string">"type"</span><span class="token keyword">:</span><span class="token string">"1"</span>,size:10<span class="token punctuation">}</span><span class="token punctuation">)</span>
<span class="token operator">&gt;</span> db.b.find<span class="token punctuation">(</span><span class="token punctuation">)</span>
<span class="token punctuation">{<!-- --></span> <span class="token string">"_id"</span> <span class="token keyword">:</span> ObjectId<span class="token punctuation">(</span><span class="token string">"5003b6135af21ff428dafbe6"</span><span class="token punctuation">)</span>, 
  <span class="token string">"uid"</span> <span class="token keyword">:</span> <span class="token string">"201203"</span>, 
  <span class="token string">"type"</span> <span class="token keyword">:</span> <span class="token string">"1"</span>,
  <span class="token string">"size"</span> <span class="token keyword">:</span> 10 
<span class="token punctuation">}</span>
<span class="token operator">&gt;</span> db.b.update<span class="token punctuation">(</span><span class="token punctuation">{<!-- --></span><span class="token string">"uid"</span> <span class="token keyword">:</span> <span class="token string">"201203"</span><span class="token punctuation">}</span>,<span class="token punctuation">{<!-- --></span><span class="token string">"<span class="token variable">$inc</span>"</span>:<span class="token punctuation">{<!-- --></span><span class="token string">"size"</span> <span class="token keyword">:</span> 1<span class="token punctuation">}</span><span class="token punctuation">}</span><span class="token punctuation">)</span>
<span class="token operator">&gt;</span> db.b.find<span class="token punctuation">(</span><span class="token punctuation">)</span>
<span class="token punctuation">{<!-- --></span> <span class="token string">"_id"</span> <span class="token keyword">:</span> ObjectId<span class="token punctuation">(</span><span class="token string">"5003b6135af21ff428dafbe6"</span><span class="token punctuation">)</span>, 
  <span class="token string">"uid"</span> <span class="token keyword">:</span> <span class="token string">"201203"</span>, 
  <span class="token string">"type"</span> <span class="token keyword">:</span> <span class="token string">"1"</span>,
  <span class="token string">"size"</span> <span class="token keyword">:</span> 11 
<span class="token punctuation">}</span>
<span class="token operator">&gt;</span> db.b.update<span class="token punctuation">(</span><span class="token punctuation">{<!-- --></span><span class="token string">"uid"</span> <span class="token keyword">:</span> <span class="token string">"201203"</span><span class="token punctuation">}</span>,<span class="token punctuation">{<!-- --></span><span class="token string">"<span class="token variable">$inc</span>"</span>:<span class="token punctuation">{<!-- --></span><span class="token string">"size"</span> <span class="token keyword">:</span> 2<span class="token punctuation">}</span><span class="token punctuation">}</span><span class="token punctuation">)</span>
<span class="token operator">&gt;</span> db.b.find<span class="token punctuation">(</span><span class="token punctuation">)</span>
<span class="token punctuation">{<!-- --></span> <span class="token string">"_id"</span> <span class="token keyword">:</span> ObjectId<span class="token punctuation">(</span><span class="token string">"5003b6135af21ff428dafbe6"</span><span class="token punctuation">)</span>, 
  <span class="token string">"uid"</span> <span class="token keyword">:</span> <span class="token string">"201203"</span>, 
  <span class="token string">"type"</span> <span class="token keyword">:</span> <span class="token string">"1"</span>,
  <span class="token string">"size"</span> <span class="token keyword">:</span> 13 
<span class="token punctuation">}</span>
<span class="token operator">&gt;</span> db.b.update<span class="token punctuation">(</span><span class="token punctuation">{<!-- --></span><span class="token string">"uid"</span> <span class="token keyword">:</span> <span class="token string">"201203"</span><span class="token punctuation">}</span>,<span class="token punctuation">{<!-- --></span><span class="token string">"<span class="token variable">$inc</span>"</span>:<span class="token punctuation">{<!-- --></span><span class="token string">"size"</span> <span class="token keyword">:</span> -1<span class="token punctuation">}</span><span class="token punctuation">}</span><span class="token punctuation">)</span>
<span class="token operator">&gt;</span> db.b.find<span class="token punctuation">(</span><span class="token punctuation">)</span>
<span class="token punctuation">{<!-- --></span> <span class="token string">"_id"</span> <span class="token keyword">:</span> ObjectId<span class="token punctuation">(</span><span class="token string">"5003b6135af21ff428dafbe6"</span><span class="token punctuation">)</span>, 
  <span class="token string">"uid"</span> <span class="token keyword">:</span> <span class="token string">"201203"</span>, 
  <span class="token string">"type"</span> <span class="token keyword">:</span> <span class="token string">"1"</span>,
  <span class="token string">"size"</span> <span class="token keyword">:</span> 12 
<span class="token punctuation">}</span>
</code></pre> 
<p>得出结论：修改器<span class="katex--inline"><span class="katex"><span class="katex-mathml">
    
     
      
       
        i
       
       
        n
       
       
        c
       
       
        可
       
       
        以
       
       
        对
       
       
        文
       
       
        档
       
       
        的
       
       
        某
       
       
        个
       
       
        值
       
       
        为
       
       
        数
       
       
        字
       
       
        型
       
       
        （
       
       
        只
       
       
        能
       
       
        为
       
       
        满
       
       
        足
       
       
        要
       
       
        求
       
       
        的
       
       
        数
       
       
        字
       
       
        ）
       
       
        的
       
       
        键
       
       
        进
       
       
        行
       
       
        增
       
       
        减
       
       
        的
       
       
        操
       
       
        作
       
       
        。
       
       
        （
       
       
        这
       
       
        里
       
       
        有
       
       
        个
       
       
        问
       
       
        题
       
       
        ：
       
       
        上
       
       
        篇
       
       
        中
       
       
        说
       
       
        到
       
       
        更
       
       
        新
       
       
        默
       
       
        认
       
       
        只
       
       
        对
       
       
        满
       
       
        足
       
       
        条
       
       
        件
       
       
        的
       
       
        记
       
       
        录
       
       
        集
       
       
        中
       
       
        第
       
       
        一
       
       
        个
       
       
        文
       
       
        档
       
       
        进
       
       
        行
       
       
        更
       
       
        新
       
       
        ，
       
       
        那
       
       
        么
       
       
        使
       
       
        用
       
      
      
       inc可以对文档的某个值为数字型（只能为满足要求的数字）的键进行增减的操作。 （这里有个问题：上篇中说到更新默认只对满足条件的记录集中第一个文档进行更新，那么使用
      
     
    </span><span class="katex-html"><span class="base"><span class="strut" style="height: 0.65952em; vertical-align: 0em;"></span><span class="mord mathit">i</span><span class="mord mathit">n</span><span class="mord mathit">c</span><span class="mord cjk_fallback">可</span><span class="mord cjk_fallback">以</span><span class="mord cjk_fallback">对</span><span class="mord cjk_fallback">文</span><span class="mord cjk_fallback">档</span><span class="mord cjk_fallback">的</span><span class="mord cjk_fallback">某</span><span class="mord cjk_fallback">个</span><span class="mord cjk_fallback">值</span><span class="mord cjk_fallback">为</span><span class="mord cjk_fallback">数</span><span class="mord cjk_fallback">字</span><span class="mord cjk_fallback">型</span><span class="mord cjk_fallback">（</span><span class="mord cjk_fallback">只</span><span class="mord cjk_fallback">能</span><span class="mord cjk_fallback">为</span><span class="mord cjk_fallback">满</span><span class="mord cjk_fallback">足</span><span class="mord cjk_fallback">要</span><span class="mord cjk_fallback">求</span><span class="mord cjk_fallback">的</span><span class="mord cjk_fallback">数</span><span class="mord cjk_fallback">字</span><span class="mord cjk_fallback">）</span><span class="mord cjk_fallback">的</span><span class="mord cjk_fallback">键</span><span class="mord cjk_fallback">进</span><span class="mord cjk_fallback">行</span><span class="mord cjk_fallback">增</span><span class="mord cjk_fallback">减</span><span class="mord cjk_fallback">的</span><span class="mord cjk_fallback">操</span><span class="mord cjk_fallback">作</span><span class="mord cjk_fallback">。</span><span class="mord cjk_fallback">（</span><span class="mord cjk_fallback">这</span><span class="mord cjk_fallback">里</span><span class="mord cjk_fallback">有</span><span class="mord cjk_fallback">个</span><span class="mord cjk_fallback">问</span><span class="mord cjk_fallback">题</span><span class="mord cjk_fallback">：</span><span class="mord cjk_fallback">上</span><span class="mord cjk_fallback">篇</span><span class="mord cjk_fallback">中</span><span class="mord cjk_fallback">说</span><span class="mord cjk_fallback">到</span><span class="mord cjk_fallback">更</span><span class="mord cjk_fallback">新</span><span class="mord cjk_fallback">默</span><span class="mord cjk_fallback">认</span><span class="mord cjk_fallback">只</span><span class="mord cjk_fallback">对</span><span class="mord cjk_fallback">满</span><span class="mord cjk_fallback">足</span><span class="mord cjk_fallback">条</span><span class="mord cjk_fallback">件</span><span class="mord cjk_fallback">的</span><span class="mord cjk_fallback">记</span><span class="mord cjk_fallback">录</span><span class="mord cjk_fallback">集</span><span class="mord cjk_fallback">中</span><span class="mord cjk_fallback">第</span><span class="mord cjk_fallback">一</span><span class="mord cjk_fallback">个</span><span class="mord cjk_fallback">文</span><span class="mord cjk_fallback">档</span><span class="mord cjk_fallback">进</span><span class="mord cjk_fallback">行</span><span class="mord cjk_fallback">更</span><span class="mord cjk_fallback">新</span><span class="mord cjk_fallback">，</span><span class="mord cjk_fallback">那</span><span class="mord cjk_fallback">么</span><span class="mord cjk_fallback">使</span><span class="mord cjk_fallback">用</span></span></span></span></span>inc修改器之后，还是一样吗？）</p> 
<h1><a id="2set_44"></a>2.$set</h1> 
<p>用来指定一个键并更新键值，若键不存在并创建。来看看下面的效果：</p> 
<pre><code class="prism language-shell"><span class="token operator">&gt;</span> db.a.findOne<span class="token punctuation">(</span><span class="token punctuation">{<!-- --></span><span class="token string">"uid"</span> <span class="token keyword">:</span> <span class="token string">"20120002"</span>,<span class="token string">"type"</span> <span class="token keyword">:</span> <span class="token string">"3"</span><span class="token punctuation">}</span><span class="token punctuation">)</span>
<span class="token punctuation">{<!-- --></span> <span class="token string">"_id"</span> <span class="token keyword">:</span> ObjectId<span class="token punctuation">(</span><span class="token string">"500216de81b954b6161a7d8f"</span><span class="token punctuation">)</span>, 
  <span class="token string">"desc"</span> <span class="token keyword">:</span> <span class="token string">"hello world2!"</span>, 
  <span class="token string">"num"</span><span class="token keyword">:</span> 40,
  <span class="token string">"sname"</span> <span class="token keyword">:</span> <span class="token string">"jk"</span>, 
  <span class="token string">"type"</span> <span class="token keyword">:</span> <span class="token string">"3"</span>, 
  <span class="token string">"uid"</span> <span class="token keyword">:</span> <span class="token string">"20120002"</span> 
<span class="token punctuation">}</span>
</code></pre> 
<p>–size键不存在的场合</p> 
<pre><code class="prism language-shell"><span class="token operator">&gt;</span> db.a.update<span class="token punctuation">(</span>
	<span class="token punctuation">{<!-- --></span><span class="token string">"uid"</span> <span class="token keyword">:</span> <span class="token string">"20120002"</span>,<span class="token string">"type"</span> <span class="token keyword">:</span> <span class="token string">"3"</span><span class="token punctuation">}</span>,
	<span class="token punctuation">{<!-- --></span><span class="token string">"<span class="token variable">$set</span>"</span>:<span class="token punctuation">{<!-- --></span><span class="token string">"size"</span>:10<span class="token punctuation">}</span><span class="token punctuation">}</span>
	<span class="token punctuation">)</span>
<span class="token operator">&gt;</span> db.a.findOne<span class="token punctuation">(</span><span class="token punctuation">{<!-- --></span><span class="token string">"uid"</span> <span class="token keyword">:</span> <span class="token string">"20120002"</span>,<span class="token string">"type"</span> <span class="token keyword">:</span> <span class="token string">"3"</span><span class="token punctuation">}</span><span class="token punctuation">)</span>
<span class="token punctuation">{<!-- --></span> <span class="token string">"_id"</span> <span class="token keyword">:</span> ObjectId<span class="token punctuation">(</span><span class="token string">"500216de81b954b6161a7d8f"</span><span class="token punctuation">)</span>, 
  <span class="token string">"desc"</span> <span class="token keyword">:</span> <span class="token string">"hello world2!"</span>, 
  <span class="token string">"num"</span><span class="token keyword">:</span> 40, 
  <span class="token string">"size"</span> <span class="token keyword">:</span> 10, 
  <span class="token string">"sname"</span> <span class="token keyword">:</span> <span class="token string">"jk"</span>, 
  <span class="token string">"type"</span> <span class="token keyword">:</span> <span class="token string">"3"</span>, 
  <span class="token string">"uid"</span> <span class="token keyword">:</span> <span class="token string">"20120002"</span> 
<span class="token punctuation">}</span>
</code></pre> 
<p>–sname键存在的场合</p> 
<pre><code class="prism language-shell"><span class="token operator">&gt;</span> db.a.update<span class="token punctuation">(</span>
	<span class="token punctuation">{<!-- --></span><span class="token string">"uid"</span> <span class="token keyword">:</span> <span class="token string">"20120002"</span>,<span class="token string">"type"</span> <span class="token keyword">:</span> <span class="token string">"3"</span><span class="token punctuation">}</span>,
	<span class="token punctuation">{<!-- --></span><span class="token string">"<span class="token variable">$set</span>"</span><span class="token keyword">:</span> <span class="token punctuation">{<!-- --></span><span class="token string">"sname"</span><span class="token keyword">:</span><span class="token string">"ssk"</span><span class="token punctuation">}</span> <span class="token punctuation">}</span>
	<span class="token punctuation">)</span>
<span class="token operator">&gt;</span> db.a.find<span class="token punctuation">(</span><span class="token punctuation">)</span>
<span class="token punctuation">{<!-- --></span> <span class="token string">"_id"</span> <span class="token keyword">:</span> ObjectId<span class="token punctuation">(</span><span class="token string">"500216de81b954b6161a7d8f"</span><span class="token punctuation">)</span>, 
  <span class="token string">"desc"</span> <span class="token keyword">:</span> <span class="token string">"hello world2!"</span>, 
  <span class="token string">"num"</span> <span class="token keyword">:</span> 40, 
  <span class="token string">"size"</span> <span class="token keyword">:</span> 10, 
  <span class="token string">"sname"</span> <span class="token keyword">:</span> <span class="token string">"ssk"</span>, 
  <span class="token string">"type"</span> <span class="token keyword">:</span> <span class="token string">"3"</span>, 
  <span class="token string">"uid"</span> <span class="token keyword">:</span> <span class="token string">"20120002"</span> 
<span class="token punctuation">}</span>
<span class="token punctuation">{<!-- --></span> <span class="token string">"_id"</span> <span class="token keyword">:</span> ObjectId<span class="token punctuation">(</span><span class="token string">"50026affdeb4fa8d154f8572"</span><span class="token punctuation">)</span>, 
  <span class="token string">"desc"</span> <span class="token keyword">:</span> <span class="token string">"hello world1!"</span>, 
  <span class="token string">"num"</span> <span class="token keyword">:</span> 50, 
  <span class="token string">"sname"</span> <span class="token keyword">:</span> <span class="token string">"jk"</span>, 
  <span class="token string">"type"</span> <span class="token keyword">:</span> <span class="token string">"1"</span>, 
  <span class="token string">"uid"</span> <span class="token keyword">:</span> <span class="token string">"20120002"</span> 
<span class="token punctuation">}</span>
</code></pre> 
<p>–可改变键的值类型</p> 
<pre><code class="prism language-shell"><span class="token operator">&gt;</span> db.a.update<span class="token punctuation">(</span>
	<span class="token punctuation">{<!-- --></span><span class="token string">"uid"</span> <span class="token keyword">:</span> <span class="token string">"20120002"</span>,<span class="token string">"type"</span> <span class="token keyword">:</span> <span class="token string">"3"</span><span class="token punctuation">}</span>,
	<span class="token punctuation">{<!-- --></span><span class="token string">"<span class="token variable">$set</span>"</span><span class="token keyword">:</span> <span class="token punctuation">{<!-- --></span><span class="token string">"sname"</span>:<span class="token punctuation">[</span><span class="token string">"java"</span>,<span class="token string">".net"</span>,<span class="token string">"c++"</span><span class="token punctuation">]</span><span class="token punctuation">}</span> <span class="token punctuation">}</span>
	<span class="token punctuation">)</span>
<span class="token operator">&gt;</span> db.a.findOne<span class="token punctuation">(</span><span class="token punctuation">{<!-- --></span><span class="token string">"uid"</span> <span class="token keyword">:</span> <span class="token string">"20120002"</span>,<span class="token string">"type"</span> <span class="token keyword">:</span> <span class="token string">"3"</span><span class="token punctuation">}</span><span class="token punctuation">)</span>
<span class="token punctuation">{<!-- --></span>
        <span class="token string">"_id"</span> <span class="token keyword">:</span> ObjectId<span class="token punctuation">(</span><span class="token string">"500216de81b954b6161a7d8f"</span><span class="token punctuation">)</span>,
        <span class="token string">"desc"</span> <span class="token keyword">:</span> <span class="token string">"hello world2!"</span>,
        <span class="token string">"num"</span> <span class="token keyword">:</span> 40,
        <span class="token string">"size"</span> <span class="token keyword">:</span> 10,
        <span class="token string">"sname"</span> <span class="token keyword">:</span> <span class="token punctuation">[</span>
                <span class="token string">"java"</span>,
                <span class="token string">".net"</span>,
                <span class="token string">"c++"</span>
        <span class="token punctuation">]</span>,
        <span class="token string">"type"</span> <span class="token keyword">:</span> <span class="token string">"3"</span>,
        <span class="token string">"uid"</span> <span class="token keyword">:</span> <span class="token string">"20120002"</span>
<span class="token punctuation">}</span>
</code></pre> 
<p>对于内嵌的文档，$set又是如何进行更新的内嵌的文档的呢，请看下面的示例：<br> 示例文档：</p> 
<pre><code class="prism language-shell"><span class="token punctuation">{<!-- --></span>
	<span class="token string">"name"</span><span class="token keyword">:</span><span class="token string">"toyota"</span>,
	<span class="token string">"type"</span><span class="token keyword">:</span><span class="token string">"suv"</span>,
	<span class="token string">"size"</span><span class="token keyword">:</span>
		<span class="token punctuation">{<!-- --></span>
		<span class="token string">"height"</span>:10,
		<span class="token string">"width"</span>:5,
		<span class="token string">"length"</span>:15
		<span class="token punctuation">}</span>
<span class="token punctuation">}</span>
</code></pre> 
<pre><code class="prism language-shell"><span class="token operator">&gt;</span> db.c.findOne<span class="token punctuation">(</span><span class="token punctuation">{<!-- --></span><span class="token string">"name"</span><span class="token keyword">:</span><span class="token string">"toyota"</span><span class="token punctuation">}</span><span class="token punctuation">)</span>
<span class="token punctuation">{<!-- --></span>
        <span class="token string">"_id"</span> <span class="token keyword">:</span> ObjectId<span class="token punctuation">(</span><span class="token string">"5003be465af21ff428dafbe7"</span><span class="token punctuation">)</span>,
        <span class="token string">"name"</span> <span class="token keyword">:</span> <span class="token string">"toyota"</span>,
        <span class="token string">"type"</span> <span class="token keyword">:</span> <span class="token string">"suv"</span>,
        <span class="token string">"size"</span> <span class="token keyword">:</span> <span class="token punctuation">{<!-- --></span>
                <span class="token string">"height"</span> <span class="token keyword">:</span> 10,
                <span class="token string">"width"</span> <span class="token keyword">:</span> 5,
                <span class="token string">"length"</span> <span class="token keyword">:</span> 15
        <span class="token punctuation">}</span>
<span class="token punctuation">}</span>
<span class="token operator">&gt;</span> db.c.update<span class="token punctuation">(</span>
 	<span class="token punctuation">{<!-- --></span><span class="token string">"name"</span><span class="token keyword">:</span> <span class="token string">"toyota"</span> <span class="token punctuation">}</span>,
 	<span class="token punctuation">{<!-- --></span><span class="token string">"<span class="token variable">$set</span>"</span><span class="token keyword">:</span> <span class="token punctuation">{<!-- --></span><span class="token string">"size.height"</span>:8<span class="token punctuation">}</span> <span class="token punctuation">}</span>
 	<span class="token punctuation">)</span>
<span class="token operator">&gt;</span> db.c.findOne<span class="token punctuation">(</span><span class="token punctuation">{<!-- --></span><span class="token string">"name"</span><span class="token keyword">:</span><span class="token string">"toyota"</span><span class="token punctuation">}</span><span class="token punctuation">)</span>
<span class="token punctuation">{<!-- --></span>
        <span class="token string">"_id"</span> <span class="token keyword">:</span> ObjectId<span class="token punctuation">(</span><span class="token string">"5003be465af21ff428dafbe7"</span><span class="token punctuation">)</span>,
        <span class="token string">"name"</span> <span class="token keyword">:</span> <span class="token string">"toyota"</span>,
        <span class="token string">"type"</span> <span class="token keyword">:</span> <span class="token string">"suv"</span>,
        <span class="token string">"size"</span> <span class="token keyword">:</span> <span class="token punctuation">{<!-- --></span>
                <span class="token string">"height"</span> <span class="token keyword">:</span> 8,
                <span class="token string">"width"</span> <span class="token keyword">:</span> 5,
                <span class="token string">"length"</span> <span class="token keyword">:</span> 15
        <span class="token punctuation">}</span>
<span class="token punctuation">}</span>
<span class="token operator">&gt;</span> db.c.update<span class="token punctuation">(</span>
	<span class="token punctuation">{<!-- --></span><span class="token string">"name"</span><span class="token keyword">:</span> <span class="token string">"toyota"</span> <span class="token punctuation">}</span>,
	<span class="token punctuation">{<!-- --></span><span class="token string">"<span class="token variable">$set</span>"</span><span class="token keyword">:</span> <span class="token punctuation">{<!-- --></span><span class="token string">"size.width"</span>:7<span class="token punctuation">}</span> <span class="token punctuation">}</span>
	<span class="token punctuation">)</span>
<span class="token operator">&gt;</span> db.c.findOne<span class="token punctuation">(</span><span class="token punctuation">{<!-- --></span><span class="token string">"name"</span><span class="token keyword">:</span><span class="token string">"toyota"</span><span class="token punctuation">}</span><span class="token punctuation">)</span>
<span class="token punctuation">{<!-- --></span>
        <span class="token string">"_id"</span> <span class="token keyword">:</span> ObjectId<span class="token punctuation">(</span><span class="token string">"5003be465af21ff428dafbe7"</span><span class="token punctuation">)</span>,
        <span class="token string">"name"</span> <span class="token keyword">:</span> <span class="token string">"toyota"</span>,
        <span class="token string">"type"</span> <span class="token keyword">:</span> <span class="token string">"suv"</span>,
        <span class="token string">"size"</span> <span class="token keyword">:</span> <span class="token punctuation">{<!-- --></span>
                <span class="token string">"height"</span> <span class="token keyword">:</span> 8,
                <span class="token string">"width"</span> <span class="token keyword">:</span> 7,
                <span class="token string">"length"</span> <span class="token keyword">:</span> 15
        <span class="token punctuation">}</span>
<span class="token punctuation">}</span>
</code></pre> 
<p>可见：对于内嵌文档在使用$set更新时，使用"."连接的方式。</p> 
<h1><a id="3unset_178"></a>3.$unset</h1> 
<p>从字面就可以看出其意义，主要是用来删除键。<br> 示例操作效果如下：</p> 
<pre><code class="prism language-shell"><span class="token operator">&gt;</span> db.a.update<span class="token punctuation">(</span>
	<span class="token punctuation">{<!-- --></span><span class="token string">"uid"</span> <span class="token keyword">:</span> <span class="token string">"20120002"</span>,<span class="token string">"type"</span> <span class="token keyword">:</span> <span class="token string">"3"</span><span class="token punctuation">}</span>,
	<span class="token punctuation">{<!-- --></span><span class="token string">"<span class="token variable">$unset</span>"</span>:<span class="token punctuation">{<!-- --></span><span class="token string">"sname"</span>:1<span class="token punctuation">}</span><span class="token punctuation">}</span>
	<span class="token punctuation">)</span>
<span class="token operator">&gt;</span> db.a.findOne<span class="token punctuation">(</span><span class="token punctuation">{<!-- --></span><span class="token string">"uid"</span> <span class="token keyword">:</span> <span class="token string">"20120002"</span>,<span class="token string">"type"</span> <span class="token keyword">:</span> <span class="token string">"3"</span><span class="token punctuation">}</span><span class="token punctuation">)</span>
<span class="token punctuation">{<!-- --></span>
        <span class="token string">"_id"</span> <span class="token keyword">:</span> ObjectId<span class="token punctuation">(</span><span class="token string">"500216de81b954b6161a7d8f"</span><span class="token punctuation">)</span>,
        <span class="token string">"desc"</span> <span class="token keyword">:</span> <span class="token string">"hello world2!"</span>,
        <span class="token string">"num"</span> <span class="token keyword">:</span> 40,
        <span class="token string">"size"</span> <span class="token keyword">:</span> 10,
        <span class="token string">"type"</span> <span class="token keyword">:</span> <span class="token string">"3"</span>,
        <span class="token string">"uid"</span> <span class="token keyword">:</span> <span class="token string">"20120002"</span>
<span class="token punctuation">}</span>
<span class="token operator">&gt;</span> db.a.update<span class="token punctuation">(</span>
	<span class="token punctuation">{<!-- --></span><span class="token string">"uid"</span> <span class="token keyword">:</span> <span class="token string">"20120002"</span>,<span class="token string">"type"</span> <span class="token keyword">:</span> <span class="token string">"3"</span><span class="token punctuation">}</span>,
	<span class="token punctuation">{<!-- --></span><span class="token string">"<span class="token variable">$unset</span>"</span>:<span class="token punctuation">{<!-- --></span><span class="token string">"num"</span>:0<span class="token punctuation">}</span><span class="token punctuation">}</span>
	<span class="token punctuation">)</span>
<span class="token operator">&gt;</span> db.a.findOne<span class="token punctuation">(</span><span class="token punctuation">{<!-- --></span><span class="token string">"uid"</span> <span class="token keyword">:</span> <span class="token string">"20120002"</span>,<span class="token string">"type"</span> <span class="token keyword">:</span> <span class="token string">"3"</span><span class="token punctuation">}</span><span class="token punctuation">)</span>
<span class="token punctuation">{<!-- --></span>
        <span class="token string">"_id"</span> <span class="token keyword">:</span> ObjectId<span class="token punctuation">(</span><span class="token string">"500216de81b954b6161a7d8f"</span><span class="token punctuation">)</span>,
        <span class="token string">"desc"</span> <span class="token keyword">:</span> <span class="token string">"hello world2!"</span>,
        <span class="token string">"size"</span> <span class="token keyword">:</span> 10,
        <span class="token string">"type"</span> <span class="token keyword">:</span> <span class="token string">"3"</span>,
        <span class="token string">"uid"</span> <span class="token keyword">:</span> <span class="token string">"20120002"</span>
<span class="token punctuation">}</span>
<span class="token operator">&gt;</span> db.a.update<span class="token punctuation">(</span>
	<span class="token punctuation">{<!-- --></span><span class="token string">"uid"</span> <span class="token keyword">:</span> <span class="token string">"20120002"</span>,<span class="token string">"type"</span> <span class="token keyword">:</span> <span class="token string">"3"</span><span class="token punctuation">}</span>,
	<span class="token punctuation">{<!-- --></span><span class="token string">"<span class="token variable">$unset</span>"</span>:<span class="token punctuation">{<!-- --></span><span class="token string">"size"</span>:-1<span class="token punctuation">}</span><span class="token punctuation">}</span>
	<span class="token punctuation">)</span>
<span class="token operator">&gt;</span> db.a.findOne<span class="token punctuation">(</span><span class="token punctuation">{<!-- --></span><span class="token string">"uid"</span> <span class="token keyword">:</span> <span class="token string">"20120002"</span>,<span class="token string">"type"</span> <span class="token keyword">:</span> <span class="token string">"3"</span><span class="token punctuation">}</span><span class="token punctuation">)</span>
<span class="token punctuation">{<!-- --></span>
        <span class="token string">"_id"</span> <span class="token keyword">:</span> ObjectId<span class="token punctuation">(</span><span class="token string">"500216de81b954b6161a7d8f"</span><span class="token punctuation">)</span>,
        <span class="token string">"desc"</span> <span class="token keyword">:</span> <span class="token string">"hello world2!"</span>,
        <span class="token string">"type"</span> <span class="token keyword">:</span> <span class="token string">"3"</span>,
        <span class="token string">"uid"</span> <span class="token keyword">:</span> <span class="token string">"20120002"</span>
<span class="token punctuation">}</span>
<span class="token operator">&gt;</span> db.a.update<span class="token punctuation">(</span>
	<span class="token punctuation">{<!-- --></span><span class="token string">"uid"</span> <span class="token keyword">:</span> <span class="token string">"20120002"</span>,<span class="token string">"type"</span> <span class="token keyword">:</span> <span class="token string">"3"</span><span class="token punctuation">}</span>,
	<span class="token punctuation">{<!-- --></span><span class="token string">"<span class="token variable">$unset</span>"</span>:<span class="token punctuation">{<!-- --></span><span class="token string">"desc"</span><span class="token keyword">:</span><span class="token string">"sssssss"</span><span class="token punctuation">}</span><span class="token punctuation">}</span>
	<span class="token punctuation">)</span>
<span class="token operator">&gt;</span> db.a.findOne<span class="token punctuation">(</span><span class="token punctuation">{<!-- --></span><span class="token string">"uid"</span> <span class="token keyword">:</span> <span class="token string">"20120002"</span>,<span class="token string">"type"</span> <span class="token keyword">:</span> <span class="token string">"3"</span><span class="token punctuation">}</span><span class="token punctuation">)</span>
<span class="token punctuation">{<!-- --></span>
        <span class="token string">"_id"</span> <span class="token keyword">:</span> ObjectId<span class="token punctuation">(</span><span class="token string">"500216de81b954b6161a7d8f"</span><span class="token punctuation">)</span>,
        <span class="token string">"type"</span> <span class="token keyword">:</span> <span class="token string">"3"</span>,
        <span class="token string">"uid"</span> <span class="token keyword">:</span> <span class="token string">"20120002"</span>
<span class="token punctuation">}</span>
</code></pre> 
<p>得出结论：使用修改器$unset时，不论对目标键使用1、0、-1或者具体的字符串等都是可以删除该目标键。</p> 
<h1><a id="4push_232"></a>4.数组修改器–$push</h1> 
<p>示例操作效果如下：</p> 
<pre><code class="prism language-shell"><span class="token operator">&gt;</span> db.c.find<span class="token punctuation">(</span><span class="token punctuation">)</span>
<span class="token punctuation">{<!-- --></span> 
	<span class="token string">"_id"</span> <span class="token keyword">:</span> ObjectId<span class="token punctuation">(</span><span class="token string">"5003be465af21ff428dafbe7"</span><span class="token punctuation">)</span>, 
	<span class="token string">"name"</span> <span class="token keyword">:</span> <span class="token string">"toyota"</span>, 
	<span class="token string">"type"</span> <span class="token keyword">:</span> <span class="token string">"suv"</span>,
	<span class="token string">"size"</span> <span class="token keyword">:</span> 
		<span class="token punctuation">{<!-- --></span> 
		<span class="token string">"height"</span> <span class="token keyword">:</span> 8, 
		<span class="token string">"width"</span> <span class="token keyword">:</span> 7, 
		<span class="token string">"length"</span> <span class="token keyword">:</span> 15 
		<span class="token punctuation">}</span> 
<span class="token punctuation">}</span>
</code></pre> 
<p>–先push一个当前文档中不存在的键title</p> 
<pre><code class="prism language-shell"><span class="token operator">&gt;</span> db.c.update<span class="token punctuation">(</span>
	<span class="token punctuation">{<!-- --></span><span class="token string">"name"</span> <span class="token keyword">:</span> <span class="token string">"toyota"</span><span class="token punctuation">}</span>,
	<span class="token punctuation">{<!-- --></span><span class="token variable">$push</span>:<span class="token punctuation">{<!-- --></span><span class="token string">"title"</span><span class="token keyword">:</span><span class="token string">"t1"</span><span class="token punctuation">}</span><span class="token punctuation">}</span>
	<span class="token punctuation">)</span>
<span class="token operator">&gt;</span> db.c.find<span class="token punctuation">(</span><span class="token punctuation">)</span>
<span class="token punctuation">{<!-- --></span> 
	<span class="token string">"_id"</span> <span class="token keyword">:</span> ObjectId<span class="token punctuation">(</span><span class="token string">"5003be465af21ff428dafbe7"</span><span class="token punctuation">)</span>, 
	<span class="token string">"name"</span> <span class="token keyword">:</span> <span class="token string">"toyota"</span>, 
	<span class="token string">"size"</span> <span class="token keyword">:</span> 
		<span class="token punctuation">{<!-- --></span> 
		<span class="token string">"height"</span> <span class="token keyword">:</span> 8,
		<span class="token string">"width"</span> <span class="token keyword">:</span> 7, 
		<span class="token string">"length"</span> <span class="token keyword">:</span> 15 
		<span class="token punctuation">}</span>,
	<span class="token string">"title"</span> <span class="token keyword">:</span> <span class="token punctuation">[</span> <span class="token string">"t1"</span> <span class="token punctuation">]</span>, 
	<span class="token string">"type"</span> <span class="token keyword">:</span> <span class="token string">"suv"</span> 
<span class="token punctuation">}</span>
</code></pre> 
<p>–再向title中push一个值</p> 
<pre><code class="prism language-shell"><span class="token operator">&gt;</span> db.c.update<span class="token punctuation">(</span>
	<span class="token punctuation">{<!-- --></span><span class="token string">"name"</span> <span class="token keyword">:</span> <span class="token string">"toyota"</span><span class="token punctuation">}</span>,
	<span class="token punctuation">{<!-- --></span><span class="token variable">$push</span>  <span class="token keyword">:</span> <span class="token punctuation">{<!-- --></span><span class="token string">"title"</span><span class="token keyword">:</span><span class="token string">"t2"</span><span class="token punctuation">}</span> <span class="token punctuation">}</span>
	<span class="token punctuation">)</span>
<span class="token operator">&gt;</span> db.c.find<span class="token punctuation">(</span><span class="token punctuation">)</span>
<span class="token punctuation">{<!-- --></span> 
	<span class="token string">"_id"</span> <span class="token keyword">:</span> ObjectId<span class="token punctuation">(</span><span class="token string">"5003be465af21ff428dafbe7"</span><span class="token punctuation">)</span>, 
	<span class="token string">"name"</span> <span class="token keyword">:</span> <span class="token string">"toyota"</span>, 
	<span class="token string">"size"</span> <span class="token keyword">:</span> 
	<span class="token punctuation">{<!-- --></span> 
		<span class="token string">"height"</span> <span class="token keyword">:</span> 8,
		<span class="token string">"width"</span> <span class="token keyword">:</span> 7, 
		<span class="token string">"length"</span> <span class="token keyword">:</span> 15 
	<span class="token punctuation">}</span>, 
	<span class="token string">"title"</span> <span class="token keyword">:</span> <span class="token punctuation">[</span> <span class="token string">"t1"</span>, <span class="token string">"t2"</span> <span class="token punctuation">]</span>, 
	<span class="token string">"type"</span> <span class="token keyword">:</span> <span class="token string">"suv"</span> 
<span class="token punctuation">}</span>
</code></pre> 
<p>–再向title中push一个值</p> 
<pre><code class="prism language-shell"><span class="token operator">&gt;</span> db.c.update<span class="token punctuation">(</span>
	<span class="token punctuation">{<!-- --></span><span class="token string">"name"</span> <span class="token keyword">:</span> <span class="token string">"toyota"</span> <span class="token punctuation">}</span>,
	<span class="token punctuation">{<!-- --></span><span class="token variable">$push</span>  <span class="token keyword">:</span> <span class="token punctuation">{<!-- --></span><span class="token string">"title"</span><span class="token keyword">:</span><span class="token string">"t2"</span><span class="token punctuation">}</span> <span class="token punctuation">}</span>
	<span class="token punctuation">)</span>
<span class="token operator">&gt;</span> db.c.find<span class="token punctuation">(</span><span class="token punctuation">)</span>
<span class="token punctuation">{<!-- --></span> <span class="token string">"_id"</span> <span class="token keyword">:</span> ObjectId<span class="token punctuation">(</span><span class="token string">"5003be465af21ff428dafbe7"</span><span class="token punctuation">)</span>, 
  <span class="token string">"name"</span> <span class="token keyword">:</span> <span class="token string">"toyota"</span>, 
  <span class="token string">"size"</span> <span class="token keyword">:</span> <span class="token punctuation">{<!-- --></span> 
    <span class="token string">"height"</span> <span class="token keyword">:</span> 8,
    <span class="token string">"width"</span> <span class="token keyword">:</span> 7, 
    <span class="token string">"length"</span> <span class="token keyword">:</span> 15 <span class="token punctuation">}</span>, 
  <span class="token string">"title"</span> <span class="token keyword">:</span> <span class="token punctuation">[</span> <span class="token string">"t1"</span>, <span class="token string">"t2"</span>, <span class="token string">"t2"</span> <span class="token punctuation">]</span>,
  <span class="token string">"type"</span> <span class="token keyword">:</span> <span class="token string">"suv"</span> 
<span class="token punctuation">}</span>
</code></pre> 
<p>–再向一个已经存在的键值非数组类型的键push一个值</p> 
<pre><code class="prism language-shell"><span class="token operator">&gt;</span> db.c.update<span class="token punctuation">(</span>
	<span class="token punctuation">{<!-- --></span><span class="token string">"name"</span> <span class="token keyword">:</span> <span class="token string">"toyota"</span><span class="token punctuation">}</span>,
	<span class="token punctuation">{<!-- --></span><span class="token variable">$push</span>  <span class="token keyword">:</span> <span class="token punctuation">{<!-- --></span><span class="token string">"size.height"</span>:10<span class="token punctuation">}</span> <span class="token punctuation">}</span>
	<span class="token punctuation">)</span>
Cannot apply <span class="token variable">$push</span>/<span class="token variable">$pushAll</span> modifier to non-array
<span class="token operator">&gt;</span> db.c.update<span class="token punctuation">(</span>
	<span class="token punctuation">{<!-- --></span><span class="token string">"name"</span> <span class="token keyword">:</span> <span class="token string">"toyota"</span><span class="token punctuation">}</span>,
	<span class="token punctuation">{<!-- --></span><span class="token variable">$push</span>  <span class="token keyword">:</span> <span class="token punctuation">{<!-- --></span><span class="token string">"name"</span><span class="token keyword">:</span><span class="token string">"ddddddd"</span><span class="token punctuation">}</span> <span class="token punctuation">}</span>
	<span class="token punctuation">)</span>
Cannot apply <span class="token variable">$push</span>/<span class="token variable">$pushAll</span> modifier to non-array
</code></pre> 
<p>得出结论：$push–向文档的某个数组类型的键添加一个数组元素，不过滤重复的数据。添加时键存在，要求键值类型必须是数组；键不存在，则创建数组类型的键。</p> 
<h1><a id="5neaddToSet_320"></a>5.数组修改器–<span class="katex--inline"><span class="katex"><span class="katex-mathml">
    
     
      
       
        n
       
       
        e
       
       
        /
       
      
      
       ne/
      
     
    </span><span class="katex-html"><span class="base"><span class="strut" style="height: 1em; vertical-align: -0.25em;"></span><span class="mord mathit">n</span><span class="mord mathit">e</span><span class="mord">/</span></span></span></span></span>addToSet</h1> 
<p>主要给数组类型键值添加一个元素时，避免在数组中产生重复数据，$ne在有些情况是不通行的。</p> 
<pre><code class="prism language-shell"><span class="token operator">&gt;</span> db.c.update<span class="token punctuation">(</span>
	<span class="token punctuation">{<!-- --></span><span class="token string">"title"</span><span class="token keyword">:</span> <span class="token punctuation">{<!-- --></span><span class="token variable">$ne</span><span class="token keyword">:</span><span class="token string">"t2"</span><span class="token punctuation">}</span> <span class="token punctuation">}</span>,  <span class="token comment">#如果有重复的t2则不执行操作</span>
	<span class="token punctuation">{<!-- --></span><span class="token variable">$push</span>  <span class="token keyword">:</span> <span class="token punctuation">{<!-- --></span><span class="token string">"title"</span><span class="token keyword">:</span><span class="token string">"t2"</span><span class="token punctuation">}</span> <span class="token punctuation">}</span>
	<span class="token punctuation">)</span>
<span class="token operator">&gt;</span> db.c.find<span class="token punctuation">(</span><span class="token punctuation">)</span>
<span class="token punctuation">{<!-- --></span> <span class="token string">"_id"</span> <span class="token keyword">:</span> ObjectId<span class="token punctuation">(</span><span class="token string">"5003be465af21ff428dafbe7"</span><span class="token punctuation">)</span>, 
  <span class="token string">"name"</span> <span class="token keyword">:</span> <span class="token string">"toyota"</span>, 
  <span class="token string">"size"</span> <span class="token keyword">:</span> <span class="token punctuation">{<!-- --></span> 
  	<span class="token string">"height"</span> <span class="token keyword">:</span> 8,
 	<span class="token string">"width"</span> <span class="token keyword">:</span> 7, 
 	<span class="token string">"length"</span> <span class="token keyword">:</span> 15 
 	<span class="token punctuation">}</span>, 
  <span class="token string">"title"</span> <span class="token keyword">:</span> <span class="token punctuation">[</span> <span class="token string">"t1"</span>, <span class="token string">"t2"</span>, <span class="token string">"t2"</span> <span class="token punctuation">]</span>, 
  <span class="token string">"type"</span> <span class="token keyword">:</span> <span class="token string">"suv"</span> 
<span class="token punctuation">}</span>
<span class="token operator">&gt;</span> db.c.update<span class="token punctuation">(</span>
	<span class="token punctuation">{<!-- --></span><span class="token string">"name"</span> <span class="token keyword">:</span> <span class="token string">"toyota"</span><span class="token punctuation">}</span>,
	<span class="token punctuation">{<!-- --></span><span class="token variable">$addToSet</span>:<span class="token punctuation">{<!-- --></span><span class="token string">"title"</span><span class="token keyword">:</span><span class="token string">"t2"</span><span class="token punctuation">}</span><span class="token punctuation">}</span>  <span class="token comment">#如果有重复的t2则不执行操作</span>
	<span class="token punctuation">)</span>
<span class="token operator">&gt;</span> db.c.find<span class="token punctuation">(</span><span class="token punctuation">)</span>
<span class="token punctuation">{<!-- --></span> <span class="token string">"_id"</span> <span class="token keyword">:</span> ObjectId<span class="token punctuation">(</span><span class="token string">"5003be465af21ff428dafbe7"</span><span class="token punctuation">)</span>, 
  <span class="token string">"name"</span> <span class="token keyword">:</span> <span class="token string">"toyota"</span>, 
  <span class="token string">"size"</span> <span class="token keyword">:</span> <span class="token punctuation">{<!-- --></span> 
    <span class="token string">"height"</span> <span class="token keyword">:</span> 8,
    <span class="token string">"width"</span> <span class="token keyword">:</span> 7, 
    <span class="token string">"length"</span> <span class="token keyword">:</span> 15 
    <span class="token punctuation">}</span>, 
  <span class="token string">"title"</span> <span class="token keyword">:</span> <span class="token punctuation">[</span> <span class="token string">"t1"</span>, <span class="token string">"t2"</span>, <span class="token string">"t2"</span> <span class="token punctuation">]</span>, 
  <span class="token string">"type"</span> <span class="token keyword">:</span> <span class="token string">"suv"</span> 
 <span class="token punctuation">}</span>
</code></pre> 
<p>相当于$ne是在选择的时机执行，而addToSet是在添加的时候执行。</p> 
<h1><a id="6poppull_356"></a>6.数组修改器–<span class="katex--inline"><span class="katex"><span class="katex-mathml">
    
     
      
       
        p
       
       
        o
       
       
        p
       
       
        、
       
      
      
       pop、
      
     
    </span><span class="katex-html"><span class="base"><span class="strut" style="height: 0.625em; vertical-align: -0.19444em;"></span><span class="mord mathit">p</span><span class="mord mathit">o</span><span class="mord mathit">p</span><span class="mord cjk_fallback">、</span></span></span></span></span>pull</h1> 
<p>$pop从数组的头或者尾删除数组中的元素，示例如下：</p> 
<pre><code class="prism language-shell"><span class="token punctuation">{<!-- --></span> 
	<span class="token string">"_id"</span> <span class="token keyword">:</span> ObjectId<span class="token punctuation">(</span><span class="token string">"5003be465af21ff428dafbe7"</span><span class="token punctuation">)</span>, 
	<span class="token string">"name"</span> <span class="token keyword">:</span> <span class="token string">"toyota"</span>, 
	<span class="token string">"size"</span> <span class="token keyword">:</span> <span class="token punctuation">{<!-- --></span> 
		<span class="token string">"height"</span> <span class="token keyword">:</span> 8,
		<span class="token string">"width"</span> <span class="token keyword">:</span> 7, 
		<span class="token string">"length"</span> <span class="token keyword">:</span> 15 
		<span class="token punctuation">}</span>, 
	<span class="token string">"title"</span> <span class="token keyword">:</span> <span class="token punctuation">[</span> <span class="token string">"t1"</span>, <span class="token string">"t2"</span>, <span class="token string">"t3"</span>, <span class="token string">"t4"</span> <span class="token punctuation">]</span>,
	<span class="token string">"type"</span> <span class="token keyword">:</span> <span class="token string">"suv"</span> 
<span class="token punctuation">}</span>
</code></pre> 
<p>–从数组的尾部删除 1</p> 
<pre><code class="prism language-shell"><span class="token operator">&gt;</span> db.c.update<span class="token punctuation">(</span>
	<span class="token punctuation">{<!-- --></span><span class="token string">"name"</span> <span class="token keyword">:</span> <span class="token string">"toyota"</span><span class="token punctuation">}</span>,
	<span class="token punctuation">{<!-- --></span> <span class="token variable">$pop</span>  <span class="token keyword">:</span> <span class="token punctuation">{<!-- --></span><span class="token string">"title"</span>:1<span class="token punctuation">}</span> <span class="token punctuation">}</span>
	<span class="token punctuation">)</span>
<span class="token operator">&gt;</span> db.c.find<span class="token punctuation">(</span><span class="token punctuation">)</span>
<span class="token punctuation">{<!-- --></span> 
	<span class="token string">"_id"</span> <span class="token keyword">:</span> ObjectId<span class="token punctuation">(</span><span class="token string">"5003be465af21ff428dafbe7"</span><span class="token punctuation">)</span>, 
	<span class="token string">"name"</span> <span class="token keyword">:</span> <span class="token string">"toyota"</span>, 
	<span class="token string">"size"</span> <span class="token keyword">:</span> 
		<span class="token punctuation">{<!-- --></span>
		<span class="token string">"height"</span> <span class="token keyword">:</span> 8,
		<span class="token string">"width"</span> <span class="token keyword">:</span> 7, 
		<span class="token string">"length"</span> <span class="token keyword">:</span> 15 
		<span class="token punctuation">}</span>, 
	<span class="token string">"title"</span> <span class="token keyword">:</span> <span class="token punctuation">[</span> <span class="token string">"t1"</span>, <span class="token string">"t2"</span>, <span class="token string">"t3"</span> <span class="token punctuation">]</span>, 
	<span class="token string">"type"</span> <span class="token keyword">:</span> <span class="token string">"suv"</span> 
<span class="token punctuation">}</span>
</code></pre> 
<p>–从数组的头部 -1</p> 
<pre><code class="prism language-shell"><span class="token operator">&gt;</span> db.c.update<span class="token punctuation">(</span>
	<span class="token punctuation">{<!-- --></span><span class="token string">"name"</span> <span class="token keyword">:</span> <span class="token string">"toyota"</span><span class="token punctuation">}</span>,
	<span class="token punctuation">{<!-- --></span><span class="token variable">$pop</span>:<span class="token punctuation">{<!-- --></span><span class="token string">"title"</span>:-1<span class="token punctuation">}</span><span class="token punctuation">}</span>
	<span class="token punctuation">)</span>
<span class="token operator">&gt;</span> db.c.find<span class="token punctuation">(</span><span class="token punctuation">)</span>
<span class="token punctuation">{<!-- --></span> 
	<span class="token string">"_id"</span> <span class="token keyword">:</span> ObjectId<span class="token punctuation">(</span><span class="token string">"5003be465af21ff428dafbe7"</span><span class="token punctuation">)</span>,
	<span class="token string">"name"</span> <span class="token keyword">:</span> <span class="token string">"toyota"</span>, 
	<span class="token string">"size"</span> <span class="token keyword">:</span> 
		<span class="token punctuation">{<!-- --></span> 
		<span class="token string">"height"</span> <span class="token keyword">:</span> 8,
		<span class="token string">"width"</span> <span class="token keyword">:</span> 7,
		<span class="token string">"length"</span> <span class="token keyword">:</span> 15 
		<span class="token punctuation">}</span>, 
	<span class="token string">"title"</span> <span class="token keyword">:</span> <span class="token punctuation">[</span> <span class="token string">"t2"</span>, <span class="token string">"t3"</span> <span class="token punctuation">]</span>, 
	<span class="token string">"type"</span> <span class="token keyword">:</span> <span class="token string">"suv"</span> 
<span class="token punctuation">}</span>
</code></pre> 
<p>–从数组的尾部删除 0</p> 
<pre><code class="prism language-shell"><span class="token operator">&gt;</span> db.c.update<span class="token punctuation">(</span>
	<span class="token punctuation">{<!-- --></span><span class="token string">"name"</span> <span class="token keyword">:</span> <span class="token string">"toyota"</span><span class="token punctuation">}</span>,
	<span class="token punctuation">{<!-- --></span><span class="token variable">$pop</span>:<span class="token punctuation">{<!-- --></span><span class="token string">"title"</span>:0<span class="token punctuation">}</span><span class="token punctuation">}</span>
	<span class="token punctuation">)</span>
<span class="token operator">&gt;</span> db.c.find<span class="token punctuation">(</span><span class="token punctuation">)</span>
<span class="token punctuation">{<!-- --></span> 
	<span class="token string">"_id"</span> <span class="token keyword">:</span> ObjectId<span class="token punctuation">(</span><span class="token string">"5003be465af21ff428dafbe7"</span><span class="token punctuation">)</span>, 
	<span class="token string">"name"</span> <span class="token keyword">:</span> <span class="token string">"toyota"</span>,
	<span class="token string">"size"</span> <span class="token keyword">:</span> 
		<span class="token punctuation">{<!-- --></span> 
		<span class="token string">"height"</span> <span class="token keyword">:</span> 8,
		<span class="token string">"width"</span> <span class="token keyword">:</span> 7, 
		<span class="token string">"length"</span> <span class="token keyword">:</span> 15 
		<span class="token punctuation">}</span>, 
	<span class="token string">"title"</span> <span class="token keyword">:</span> <span class="token punctuation">[</span> <span class="token string">"t2"</span> <span class="token punctuation">]</span>, 
	<span class="token string">"type"</span> <span class="token keyword">:</span> <span class="token string">"suv"</span> 
<span class="token punctuation">}</span>
</code></pre> 
<p>$pull从数组中删除满足条件的元素，示例如下：</p> 
<pre><code class="prism language-shell"><span class="token punctuation">{<!-- --></span> 
	<span class="token string">"_id"</span> <span class="token keyword">:</span> ObjectId<span class="token punctuation">(</span><span class="token string">"5003be465af21ff428dafbe7"</span><span class="token punctuation">)</span>, 
	<span class="token string">"name"</span> <span class="token keyword">:</span> <span class="token string">"toyota"</span>, 
	<span class="token string">"size"</span> <span class="token keyword">:</span> 
		<span class="token punctuation">{<!-- --></span> 
		<span class="token string">"height"</span> <span class="token keyword">:</span> 8,
		<span class="token string">"width"</span> <span class="token keyword">:</span> 7,
		<span class="token string">"length"</span> <span class="token keyword">:</span> 15 
		<span class="token punctuation">}</span>, 
	<span class="token string">"title"</span> <span class="token keyword">:</span> <span class="token punctuation">[</span> <span class="token string">"t1"</span>, <span class="token string">"t2"</span>, <span class="token string">"t2"</span>, <span class="token string">"t3"</span> <span class="token punctuation">]</span>,
	<span class="token string">"type"</span> <span class="token keyword">:</span> <span class="token string">"suv"</span> 
<span class="token punctuation">}</span>
<span class="token operator">&gt;</span> db.c.update<span class="token punctuation">(</span>
	<span class="token punctuation">{<!-- --></span><span class="token string">"name"</span> <span class="token keyword">:</span> <span class="token string">"toyota"</span> <span class="token punctuation">}</span>,
	<span class="token punctuation">{<!-- --></span> <span class="token variable">$pull</span> <span class="token keyword">:</span> <span class="token punctuation">{<!-- --></span><span class="token string">"title"</span><span class="token keyword">:</span><span class="token string">"t2"</span><span class="token punctuation">}</span> <span class="token punctuation">}</span>
	<span class="token punctuation">)</span>
<span class="token operator">&gt;</span> db.c.find<span class="token punctuation">(</span><span class="token punctuation">)</span>
<span class="token punctuation">{<!-- --></span> 
	<span class="token string">"_id"</span> <span class="token keyword">:</span> ObjectId<span class="token punctuation">(</span><span class="token string">"5003be465af21ff428dafbe7"</span><span class="token punctuation">)</span>,
	<span class="token string">"name"</span> <span class="token keyword">:</span> <span class="token string">"toyota"</span>, 
	<span class="token string">"size"</span> <span class="token keyword">:</span> 
		<span class="token punctuation">{<!-- --></span> 
		<span class="token string">"height"</span> <span class="token keyword">:</span> 8,
		<span class="token string">"width"</span> <span class="token keyword">:</span> 7, 
		<span class="token string">"length"</span> <span class="token keyword">:</span> 15 
		<span class="token punctuation">}</span>, 
	<span class="token string">"title"</span> <span class="token keyword">:</span> <span class="token punctuation">[</span> <span class="token string">"t1"</span>, <span class="token string">"t3"</span> <span class="token punctuation">]</span>, 
	<span class="token string">"type"</span> <span class="token keyword">:</span> <span class="token string">"suv"</span> 
<span class="token punctuation">}</span>
</code></pre> 
<h2><a id="7_464"></a>7.数组的定位修改器</h2> 
<p>在需要对数组中的值进行操作的时候，可通过位置或者定位操作符（"$"）.数组是0开始的，可以直接将下标作为键来选择元素。<br> 示例如下：</p> 
<pre><code class="prism language-shell"><span class="token punctuation">{<!-- --></span>
	<span class="token string">"uid"</span><span class="token keyword">:</span><span class="token string">"001"</span>,
	comments:
		<span class="token punctuation">[</span>
			<span class="token punctuation">{<!-- --></span><span class="token string">"name"</span><span class="token keyword">:</span><span class="token string">"t1"</span>,<span class="token string">"size"</span>:10<span class="token punctuation">}</span>,		
			<span class="token punctuation">{<!-- --></span><span class="token string">"name"</span><span class="token keyword">:</span><span class="token string">"t2"</span>,<span class="token string">"size"</span>:12<span class="token punctuation">}</span>
		<span class="token punctuation">]</span>
<span class="token punctuation">}</span>

<span class="token operator">&gt;</span> db.c.find<span class="token punctuation">(</span><span class="token punctuation">{<!-- --></span><span class="token string">"uid"</span><span class="token keyword">:</span><span class="token string">"001"</span><span class="token punctuation">}</span><span class="token punctuation">)</span>
<span class="token punctuation">{<!-- --></span> 
	<span class="token string">"_id"</span> <span class="token keyword">:</span> ObjectId<span class="token punctuation">(</span><span class="token string">"5003da405af21ff428dafbe8"</span><span class="token punctuation">)</span>, 
	<span class="token string">"uid"</span> <span class="token keyword">:</span> <span class="token string">"001"</span>, 
	<span class="token string">"comments"</span> <span class="token keyword">:</span> 
	<span class="token punctuation">[</span> 
		<span class="token punctuation">{<!-- --></span><span class="token string">"name"</span> <span class="token keyword">:</span> <span class="token string">"t1"</span>, <span class="token string">"size"</span> <span class="token keyword">:</span> 10 <span class="token punctuation">}</span>, 
		<span class="token punctuation">{<!-- --></span><span class="token string">"name"</span> <span class="token keyword">:</span> <span class="token string">"t2"</span>, <span class="token string">"size"</span> <span class="token keyword">:</span> 12 <span class="token punctuation">}</span> 
	<span class="token punctuation">]</span> 
<span class="token punctuation">}</span>
<span class="token operator">&gt;</span> db.c.update<span class="token punctuation">(</span>
	<span class="token punctuation">{<!-- --></span><span class="token string">"uid"</span><span class="token keyword">:</span><span class="token string">"001"</span><span class="token punctuation">}</span>,
	<span class="token punctuation">{<!-- --></span><span class="token variable">$inc</span>:<span class="token punctuation">{<!-- --></span><span class="token string">"comments.0.size"</span>:1<span class="token punctuation">}</span><span class="token punctuation">}</span>
	<span class="token punctuation">)</span>
<span class="token operator">&gt;</span> db.c.find<span class="token punctuation">(</span><span class="token punctuation">{<!-- --></span><span class="token string">"uid"</span><span class="token keyword">:</span><span class="token string">"001"</span><span class="token punctuation">}</span><span class="token punctuation">)</span>
<span class="token punctuation">{<!-- --></span> 
	<span class="token string">"_id"</span> <span class="token keyword">:</span> ObjectId<span class="token punctuation">(</span><span class="token string">"5003da405af21ff428dafbe8"</span><span class="token punctuation">)</span>, 
	<span class="token string">"uid"</span> <span class="token keyword">:</span> <span class="token string">"001"</span>, 
	<span class="token string">"comments"</span> <span class="token keyword">:</span> 
		<span class="token punctuation">[</span> 
			<span class="token punctuation">{<!-- --></span><span class="token string">"name"</span> <span class="token keyword">:</span> <span class="token string">"t1"</span>, <span class="token string">"size"</span> <span class="token keyword">:</span> 11 <span class="token punctuation">}</span>, 
			<span class="token punctuation">{<!-- --></span><span class="token string">"name"</span> <span class="token keyword">:</span> <span class="token string">"t2"</span>, <span class="token string">"size"</span> <span class="token keyword">:</span> 12 <span class="token punctuation">}</span> 
		<span class="token punctuation">]</span> 
<span class="token punctuation">}</span>
<span class="token operator">&gt;</span> db.c.update<span class="token punctuation">(</span>
	<span class="token punctuation">{<!-- --></span><span class="token string">"comments.name"</span><span class="token keyword">:</span><span class="token string">"t1"</span><span class="token punctuation">}</span>,
	<span class="token punctuation">{<!-- --></span><span class="token variable">$set</span>:<span class="token punctuation">{<!-- --></span><span class="token string">"comments.$.size"</span>:1<span class="token punctuation">}</span><span class="token punctuation">}</span>
	<span class="token punctuation">)</span>
<span class="token operator">&gt;</span> db.c.find<span class="token punctuation">(</span><span class="token punctuation">{<!-- --></span><span class="token string">"uid"</span><span class="token keyword">:</span><span class="token string">"001"</span><span class="token punctuation">}</span><span class="token punctuation">)</span>
<span class="token punctuation">{<!-- --></span> 
	<span class="token string">"_id"</span> <span class="token keyword">:</span> ObjectId<span class="token punctuation">(</span><span class="token string">"5003da405af21ff428dafbe8"</span><span class="token punctuation">)</span>, 
	<span class="token string">"uid"</span> <span class="token keyword">:</span> <span class="token string">"001"</span>, 
	<span class="token string">"comments"</span> <span class="token keyword">:</span> 
		<span class="token punctuation">[</span> 
			<span class="token punctuation">{<!-- --></span><span class="token string">"name"</span> <span class="token keyword">:</span> <span class="token string">"t1"</span>, <span class="token string">"size"</span> <span class="token keyword">:</span> 1 <span class="token punctuation">}</span>, 
			<span class="token punctuation">{<!-- --></span><span class="token string">"name"</span> <span class="token keyword">:</span> <span class="token string">"t2"</span>, <span class="token string">"size"</span> <span class="token keyword">:</span> 12<span class="token punctuation">}</span> 
		<span class="token punctuation">]</span> 
<span class="token punctuation">}</span>
</code></pre> 
<p>–若为多个文档满足条件，则只更新第一个文档。</p> 
<h2><a id="8upsert_519"></a>8.upsert</h2> 
<p>upsert是一种特殊的更新。当没有符合条件的文档，就以这个条件和更新文档为基础创建一个新的文档，如果找到匹配的文档就正常的更新。<br> 使用upsert，既可以避免竞态问题，也可以减少代码量（update的第三个参数就表示这个upsert，参数为true时）</p> 
<pre><code class="prism language-shell"><span class="token operator">&gt;</span> db.c.remove<span class="token punctuation">(</span><span class="token punctuation">)</span>
<span class="token operator">&gt;</span> db.c.update<span class="token punctuation">(</span><span class="token punctuation">{<!-- --></span><span class="token string">"size"</span>:11<span class="token punctuation">}</span>,<span class="token punctuation">{<!-- --></span><span class="token variable">$inc</span>:<span class="token punctuation">{<!-- --></span><span class="token string">"size"</span>:3<span class="token punctuation">}</span><span class="token punctuation">}</span><span class="token punctuation">)</span>
<span class="token operator">&gt;</span> db.c.find<span class="token punctuation">(</span><span class="token punctuation">)</span>
<span class="token operator">&gt;</span> db.c.update<span class="token punctuation">(</span><span class="token punctuation">{<!-- --></span><span class="token string">"size"</span>:11<span class="token punctuation">}</span>,<span class="token punctuation">{<!-- --></span><span class="token variable">$inc</span>:<span class="token punctuation">{<!-- --></span><span class="token string">"size"</span>:3<span class="token punctuation">}</span><span class="token punctuation">}</span>,false<span class="token punctuation">)</span>
<span class="token operator">&gt;</span> db.c.find<span class="token punctuation">(</span><span class="token punctuation">)</span>
<span class="token operator">&gt;</span> db.c.update<span class="token punctuation">(</span><span class="token punctuation">{<!-- --></span><span class="token string">"size"</span>:11<span class="token punctuation">}</span>,<span class="token punctuation">{<!-- --></span><span class="token variable">$inc</span>:<span class="token punctuation">{<!-- --></span><span class="token string">"size"</span>:3<span class="token punctuation">}</span><span class="token punctuation">}</span>,true<span class="token punctuation">)</span>
<span class="token operator">&gt;</span> db.c.find<span class="token punctuation">(</span><span class="token punctuation">)</span>
<span class="token punctuation">{<!-- --></span> <span class="token string">"_id"</span> <span class="token keyword">:</span> ObjectId<span class="token punctuation">(</span><span class="token string">"5003ded6c28f67507a6df1de"</span><span class="token punctuation">)</span>, <span class="token string">"size"</span> <span class="token keyword">:</span> 14 <span class="token punctuation">}</span>
</code></pre> 
<h2><a id="9save_533"></a>9.save函数</h2> 
<p>1.可以在文档不存在的时候插入，存在的时候更新，只有一个参数文档。<br> 2.要是文档含有"_id"，会调用upsert。否则，会调用插入。</p> 
<pre><code class="prism language-shell"><span class="token operator">&gt;</span> db.a.find<span class="token punctuation">(</span><span class="token punctuation">)</span>
<span class="token punctuation">{<!-- --></span> 
	<span class="token string">"_id"</span> <span class="token keyword">:</span> ObjectId<span class="token punctuation">(</span><span class="token string">"50026affdeb4fa8d154f8572"</span><span class="token punctuation">)</span>, 
	<span class="token string">"desc"</span> <span class="token keyword">:</span> <span class="token string">"hello world1!"</span>, 
	<span class="token string">"num"</span><span class="token keyword">:</span> 50,
 	<span class="token string">"sname"</span> <span class="token keyword">:</span> <span class="token string">"jk"</span>, 
 	<span class="token string">"type"</span> <span class="token keyword">:</span> <span class="token string">"1"</span>, 
 	<span class="token string">"uid"</span> <span class="token keyword">:</span> <span class="token string">"20120002"</span> 
 <span class="token punctuation">}</span>
<span class="token operator">&gt;</span> var o <span class="token operator">=</span> db.a.findOne<span class="token punctuation">(</span><span class="token punctuation">)</span>
<span class="token operator">&gt;</span> o.num <span class="token operator">=</span> 55
55
<span class="token operator">&gt;</span> db.a.save<span class="token punctuation">(</span>o<span class="token punctuation">)</span>
<span class="token operator">&gt;</span> db.a.find<span class="token punctuation">(</span><span class="token punctuation">)</span>
<span class="token punctuation">{<!-- --></span> 
	<span class="token string">"_id"</span> <span class="token keyword">:</span> ObjectId<span class="token punctuation">(</span><span class="token string">"50026affdeb4fa8d154f8572"</span><span class="token punctuation">)</span>, 
	<span class="token string">"desc"</span> <span class="token keyword">:</span> <span class="token string">"hello world1!"</span>, 
	<span class="token string">"num"</span><span class="token keyword">:</span> 55,
	<span class="token string">"sname"</span> <span class="token keyword">:</span> <span class="token string">"jk"</span>, 
	<span class="token string">"type"</span> <span class="token keyword">:</span> <span class="token string">"1"</span>, 
	<span class="token string">"uid"</span> <span class="token keyword">:</span> <span class="token string">"20120002"</span> 
<span class="token punctuation">}</span>
</code></pre>
                
{% endraw %}
