---
title: 重新学习 mongo4
date: 2021-10-03 20:26:59
layout: post
author: 刘泽美
categories:
  - CSDN文章
  - 导入
tags: 代码人生
---

[原链接](https://blog.csdn.net/weixin_41884153/article/details/120595731)
{% raw %}

                    <svg xmlns="http://www.w3.org/2000/svg" style="display: none;">
                        <path stroke-linecap="round" d="M5,0 0,2.5 5,5z" id="raphael-marker-block" style="-webkit-tap-highlight-color: rgba(0, 0, 0, 0);"></path>
                    </svg>
                    <h1><a id="_0"></a>写在前面</h1> 
<p>作为一款广为应用的 noSql 数据库。还是有必要重新熟悉一遍。</p> 
<h1><a id="_3"></a>环境及语言</h1> 
<p>本教程使用环境</p> 
<ol><li>node 版本 14.15.4</li><li>mongo 版本 4.2.8</li><li>mongodb npm版本 4.1.2</li></ol> 
<p>安装 mongo</p> 
<pre><code class="prism language-shell"><span class="token function">npm</span> <span class="token function">install</span> mongo
</code></pre> 
<h1><a id="1__13"></a>1. 连接数据库</h1> 
<pre><code class="prism language-js"><span class="token keyword">const</span> <span class="token punctuation">{<!-- --></span> MongoClient <span class="token punctuation">}</span> <span class="token operator">=</span> <span class="token function">require</span><span class="token punctuation">(</span><span class="token string">'mongodb'</span><span class="token punctuation">)</span>
<span class="token keyword">const</span> client <span class="token operator">=</span> <span class="token keyword">new</span> <span class="token class-name">MongoClient</span><span class="token punctuation">(</span><span class="token string">'mongodb://127.0.0.1:27017'</span><span class="token punctuation">)</span>
<span class="token keyword">async</span> <span class="token keyword">function</span> <span class="token function">connect</span><span class="token punctuation">(</span><span class="token punctuation">)</span><span class="token punctuation">{<!-- --></span>
	<span class="token keyword">await</span> client<span class="token punctuation">.</span><span class="token function">connect</span><span class="token punctuation">(</span><span class="token punctuation">)</span>
	console<span class="token punctuation">.</span><span class="token function">log</span><span class="token punctuation">(</span><span class="token string">'连接成功'</span><span class="token punctuation">)</span>
	db <span class="token operator">=</span> client<span class="token punctuation">.</span><span class="token function">db</span><span class="token punctuation">(</span><span class="token string">'study_test'</span><span class="token punctuation">)</span> <span class="token comment">// 连接 study_test 数据库</span>
	<span class="token comment">/* 
	 * 接下来的代码直接认为写在这里...
	 */</span>
<span class="token punctuation">}</span>
</code></pre> 
<h1><a id="2__26"></a>2. 增</h1> 
<pre><code class="prism language-js">db<span class="token punctuation">.</span><span class="token function">collection</span><span class="token punctuation">(</span><span class="token string">'user'</span><span class="token punctuation">)</span><span class="token punctuation">.</span><span class="token function">insertOne</span><span class="token punctuation">(</span><span class="token punctuation">{<!-- --></span>name<span class="token operator">:</span><span class="token string">'张三'</span><span class="token punctuation">}</span><span class="token punctuation">)</span>
db<span class="token punctuation">.</span><span class="token function">collection</span><span class="token punctuation">(</span><span class="token string">'user'</span><span class="token punctuation">)</span><span class="token punctuation">.</span><span class="token function">insertMany</span><span class="token punctuation">(</span><span class="token punctuation">[</span><span class="token punctuation">{<!-- --></span>name<span class="token operator">:</span><span class="token string">'李四'</span><span class="token punctuation">}</span><span class="token punctuation">,</span><span class="token punctuation">{<!-- --></span>name<span class="token operator">:</span><span class="token string">'王麻子'</span><span class="token punctuation">}</span><span class="token punctuation">]</span><span class="token punctuation">)</span>
</code></pre> 
<blockquote> 
 <p><strong>insertMany</strong> 有个参数介绍一下<br> <code>ordered</code>: 如果是 true，则当执行失败时，不会写入数据库。如果是 false，则当某一条执行失败时，直接写入数据库。也就是说当有大量写入的时候，为了性能优化，可以设置为 false。</p> 
</blockquote> 
<h1><a id="3__34"></a>3. 删</h1> 
<pre><code class="prism language-js">db<span class="token punctuation">.</span><span class="token function">collection</span><span class="token punctuation">(</span><span class="token string">'user'</span><span class="token punctuation">)</span><span class="token punctuation">.</span><span class="token function">deleteOne</span><span class="token punctuation">(</span><span class="token punctuation">{<!-- --></span>name<span class="token operator">:</span><span class="token string">'张三'</span><span class="token punctuation">}</span><span class="token punctuation">)</span> <span class="token comment">// 删除一条叫张三的</span>
db<span class="token punctuation">.</span><span class="token function">collection</span><span class="token punctuation">(</span><span class="token string">'user'</span><span class="token punctuation">)</span><span class="token punctuation">.</span><span class="token function">deleteMany</span><span class="token punctuation">(</span><span class="token punctuation">{<!-- --></span>age<span class="token operator">:</span> <span class="token number">18</span><span class="token punctuation">}</span><span class="token punctuation">)</span> <span class="token comment">// 删除所有年龄为 18 的</span>
</code></pre> 
<h1><a id="4__40"></a>4. 改</h1> 
<p>update 和 replace 的区别是：<br> update可以替换部分字段。<br> replace会替换所有字段。</p> 
<pre><code class="prism language-js">db<span class="token punctuation">.</span><span class="token function">collection</span><span class="token punctuation">(</span><span class="token string">'user'</span><span class="token punctuation">)</span><span class="token punctuation">.</span><span class="token function">updateOne</span><span class="token punctuation">(</span><span class="token punctuation">{<!-- --></span>name<span class="token operator">:</span><span class="token string">'张三'</span><span class="token punctuation">}</span><span class="token punctuation">,</span> <span class="token punctuation">{<!-- --></span>gender<span class="token operator">:</span><span class="token string">'男'</span><span class="token punctuation">}</span><span class="token punctuation">)</span> <span class="token comment">// 给一条姓名为张三的，添加一个 gender:男 的属性。</span>
db<span class="token punctuation">.</span><span class="token function">collection</span><span class="token punctuation">(</span><span class="token string">'user'</span><span class="token punctuation">)</span><span class="token punctuation">.</span><span class="token function">updateMany</span><span class="token punctuation">(</span><span class="token punctuation">{<!-- --></span>name<span class="token operator">:</span><span class="token string">'张三'</span><span class="token punctuation">}</span><span class="token punctuation">,</span> <span class="token punctuation">{<!-- --></span>gender<span class="token operator">:</span><span class="token string">'男'</span><span class="token punctuation">}</span><span class="token punctuation">)</span> <span class="token comment">// 给所有姓名为张三的，添加一个 gender:男 的属性。</span>
</code></pre> 
<blockquote> 
 <p><strong>update</strong> 有个参数介绍一下<br> <code>upsert</code>: 如果为true，当要更新的文档不存在时，会新增一条。为 false，则不会。</p> 
</blockquote> 
<h1><a id="5__51"></a>5. 查询</h1> 
<pre><code class="prism language-js">db<span class="token punctuation">.</span><span class="token function">collection</span><span class="token punctuation">(</span><span class="token string">'user'</span><span class="token punctuation">)</span><span class="token punctuation">.</span><span class="token function">findOne</span><span class="token punctuation">(</span><span class="token punctuation">{<!-- --></span>name<span class="token operator">:</span><span class="token string">'张三'</span><span class="token punctuation">}</span><span class="token punctuation">)</span> <span class="token comment">// 查询一条 姓名为张三的</span>
db<span class="token punctuation">.</span><span class="token function">collection</span><span class="token punctuation">(</span><span class="token string">'user'</span><span class="token punctuation">)</span><span class="token punctuation">.</span><span class="token function">find</span><span class="token punctuation">(</span><span class="token punctuation">{<!-- --></span><span class="token punctuation">}</span><span class="token punctuation">)</span><span class="token punctuation">.</span><span class="token function">toArray</span><span class="token punctuation">(</span><span class="token punctuation">)</span> <span class="token comment">// 查询所有的用户</span>
db<span class="token punctuation">.</span><span class="token function">collection</span><span class="token punctuation">(</span><span class="token string">'user'</span><span class="token punctuation">)</span><span class="token punctuation">.</span><span class="token function">find</span><span class="token punctuation">(</span><span class="token punctuation">{<!-- --></span><span class="token punctuation">}</span><span class="token punctuation">,</span> <span class="token punctuation">{<!-- --></span>returnKey<span class="token operator">:</span><span class="token boolean">true</span><span class="token punctuation">}</span><span class="token punctuation">)</span><span class="token punctuation">.</span><span class="token function">toArray</span><span class="token punctuation">(</span><span class="token punctuation">)</span> <span class="token comment">// 查询所有的用户的_id</span>
db<span class="token punctuation">.</span><span class="token function">collection</span><span class="token punctuation">(</span><span class="token string">'user'</span><span class="token punctuation">)</span><span class="token punctuation">.</span><span class="token function">find</span><span class="token punctuation">(</span><span class="token punctuation">{<!-- --></span><span class="token punctuation">}</span><span class="token punctuation">)</span><span class="token punctuation">.</span><span class="token function">count</span><span class="token punctuation">(</span><span class="token punctuation">)</span> <span class="token comment">// 查询用户数</span>
</code></pre> 
<table><thead><tr><th align="center">query参数</th><th align="center">类型</th><th align="center">解释</th></tr></thead><tbody><tr><td align="center">$eq</td><td align="center">any</td><td align="center">是否相等</td></tr><tr><td align="center">$gt</td><td align="center">number</td><td align="center">大于</td></tr><tr><td align="center">$gte</td><td align="center">number</td><td align="center">大于等于</td></tr><tr><td align="center">$lt $lte</td><td align="center">number</td><td align="center">小于/等于</td></tr><tr><td align="center">$in</td><td align="center">array</td><td align="center">是否包含</td></tr><tr><td align="center">$ne</td><td align="center">any</td><td align="center">是否不相等</td></tr><tr><td align="center">$nin</td><td align="center">array</td><td align="center">不包含</td></tr><tr><td align="center">$not</td><td align="center">any</td><td align="center">复杂查询不包含</td></tr><tr><td align="center">$exists</td><td align="center">bool</td><td align="center">是否包含此字段</td></tr><tr><td align="center">$type</td><td align="center">BSONType</td><td align="center">此字段为指定的类型</td></tr><tr><td align="center">$regex</td><td align="center">RegExp</td><td align="center">匹配正则</td></tr><tr><td align="center">$options</td><td align="center">i/m/x/s</td><td align="center">与 $regex 匹配使用</td></tr><tr><td align="center">$geoIntersects</td><td align="center">any</td><td align="center">地理坐标相关，还有 $geoWithin、 $near、 $nearSphere 、 $maxDistance</td></tr><tr><td align="center">$all</td><td align="center">array</td><td align="center">与 $in 类似，不过需要包含所有内容</td></tr><tr><td align="center">$elemMatch</td><td align="center">any</td><td align="center">匹配包含至少一个元素匹配所有指定查询条件的数组字段的文档。</td></tr><tr><td align="center">$size</td><td align="center">number</td><td align="center">匹配长度相同的数组字段的文档</td></tr></tbody></table> 
<table><thead><tr><th align="center">option参数</th><th align="center">类型</th><th align="center">解释</th></tr></thead><tbody><tr><td align="center">limit</td><td align="center">number</td><td align="center">限定返回结果的数量</td></tr><tr><td align="center">sort</td><td align="center">object</td><td align="center">排序，传入一个对象，键为字段名，值为1/-1/‘asc’/‘desc’</td></tr><tr><td align="center">projection</td><td align="center">object</td><td align="center">限定返回结果的字段，键为字段名，值为 1/0</td></tr><tr><td align="center">skip</td><td align="center">number</td><td align="center">要跳过的文档数量</td></tr><tr><td align="center">returnKey</td><td align="center">bool</td><td align="center">如果为 true ，则只会返回 _id</td></tr></tbody></table>
                
{% endraw %}
