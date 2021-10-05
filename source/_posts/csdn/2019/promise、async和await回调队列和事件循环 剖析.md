---
title: promise、async和await回调队列和事件循环 剖析
date: 2019-06-02 11:24:02
layout: post
author: 刘泽美
categories:
  - CSDN文章
  - 导入
tags: 代码人生
---

[原链接](https://blog.csdn.net/weixin_41884153/article/details/90737448)
{% raw %}

                    <svg xmlns="http://www.w3.org/2000/svg" style="display: none;">
                        <path stroke-linecap="round" d="M5,0 0,2.5 5,5z" id="raphael-marker-block" style="-webkit-tap-highlight-color: rgba(0, 0, 0, 0);"></path>
                    </svg>
                    <blockquote> 
 <p>本文受https://segmentfault.com/a/1190000015057278文章启发。</p> 
</blockquote> 
<p>不过感觉作者写得比较冗余，且有些东西还是没有讲明白。于是我尝试用更进阶的代码并配上更简洁的注释来讲明白这些事情。</p> 
<h3><a id="1__4"></a>1. 事件循环</h3> 
<blockquote> 
 <p>js在执行的过程中是单线程的，所以采用了事件循环机制。也就是说，从上往下执行。执行完毕 =&gt; 判断是否<code>微任务</code> =&gt; 判断是否有<code>宏任务</code></p> 
</blockquote> 
<h3><a id="2_7"></a>2.回调队列</h3> 
<blockquote> 
 <p>宏任务目前就简单的理解为setTimeout就ok了。而微任务就理解为回调函数的回调队列，这里包含await promise callback。</p> 
</blockquote> 
<p>某种意义上来说， await 是 对 promise 的封装 ， 而 promise 又是对 callback 的封装。所以，其实是一回事儿。</p> 
<p>即使看不懂上边的两点也无所谓，下面进入重点，废话少说，直接贴代码。</p> 
<pre><code class="prism language-js"><span class="token keyword">async</span> <span class="token keyword">function</span> <span class="token function">async1</span><span class="token punctuation">(</span><span class="token punctuation">)</span><span class="token punctuation">{<!-- --></span>
    console<span class="token punctuation">.</span><span class="token function">log</span><span class="token punctuation">(</span><span class="token string">'async1 start'</span><span class="token punctuation">)</span>
    console<span class="token punctuation">.</span><span class="token function">log</span><span class="token punctuation">(</span><span class="token string">'async1 print'</span><span class="token punctuation">,</span><span class="token keyword">await</span> <span class="token function">async2</span><span class="token punctuation">(</span><span class="token punctuation">)</span><span class="token punctuation">)</span>
    console<span class="token punctuation">.</span><span class="token function">log</span><span class="token punctuation">(</span><span class="token string">'async1 end'</span><span class="token punctuation">)</span>
<span class="token punctuation">}</span>
<span class="token keyword">async</span> <span class="token keyword">function</span> <span class="token function">async2</span><span class="token punctuation">(</span><span class="token punctuation">)</span><span class="token punctuation">{<!-- --></span>
    console<span class="token punctuation">.</span><span class="token function">log</span><span class="token punctuation">(</span><span class="token string">'async2 start'</span><span class="token punctuation">)</span>
    console<span class="token punctuation">.</span><span class="token function">log</span><span class="token punctuation">(</span><span class="token string">'async2 print'</span><span class="token punctuation">,</span><span class="token keyword">await</span> <span class="token function">async3</span><span class="token punctuation">(</span><span class="token punctuation">)</span><span class="token punctuation">)</span>
    console<span class="token punctuation">.</span><span class="token function">log</span><span class="token punctuation">(</span><span class="token string">'async2 end'</span><span class="token punctuation">)</span>
<span class="token punctuation">}</span>
<span class="token keyword">async</span> <span class="token keyword">function</span> <span class="token function">async3</span><span class="token punctuation">(</span><span class="token punctuation">)</span><span class="token punctuation">{<!-- --></span>
    console<span class="token punctuation">.</span><span class="token function">log</span><span class="token punctuation">(</span><span class="token string">'async3'</span><span class="token punctuation">)</span>
<span class="token punctuation">}</span>
console<span class="token punctuation">.</span><span class="token function">log</span><span class="token punctuation">(</span><span class="token string">'进程 start'</span><span class="token punctuation">)</span>
<span class="token function">setTimeout</span><span class="token punctuation">(</span><span class="token keyword">function</span><span class="token punctuation">(</span><span class="token punctuation">)</span><span class="token punctuation">{<!-- --></span>
    console<span class="token punctuation">.</span><span class="token function">log</span><span class="token punctuation">(</span><span class="token string">'setTimeout1'</span><span class="token punctuation">)</span> 
<span class="token punctuation">}</span><span class="token punctuation">,</span><span class="token number">0</span><span class="token punctuation">)</span>  
<span class="token function">setTimeout</span><span class="token punctuation">(</span><span class="token keyword">function</span><span class="token punctuation">(</span><span class="token punctuation">)</span><span class="token punctuation">{<!-- --></span>
    console<span class="token punctuation">.</span><span class="token function">log</span><span class="token punctuation">(</span><span class="token string">'setTimeout2'</span><span class="token punctuation">)</span> 
<span class="token punctuation">}</span><span class="token punctuation">,</span><span class="token number">0</span><span class="token punctuation">)</span>  
<span class="token function">async1</span><span class="token punctuation">(</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
<span class="token keyword">new</span> <span class="token class-name">Promise</span><span class="token punctuation">(</span><span class="token keyword">function</span><span class="token punctuation">(</span>resolve<span class="token punctuation">)</span><span class="token punctuation">{<!-- --></span>
    console<span class="token punctuation">.</span><span class="token function">log</span><span class="token punctuation">(</span><span class="token string">'promise1'</span><span class="token punctuation">)</span>
    <span class="token function">resolve</span><span class="token punctuation">(</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span class="token punctuation">.</span><span class="token function">then</span><span class="token punctuation">(</span><span class="token keyword">function</span><span class="token punctuation">(</span><span class="token punctuation">)</span><span class="token punctuation">{<!-- --></span>
    console<span class="token punctuation">.</span><span class="token function">log</span><span class="token punctuation">(</span><span class="token string">'promise1 resolve'</span><span class="token punctuation">)</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span>
<span class="token keyword">new</span> <span class="token class-name">Promise</span><span class="token punctuation">(</span><span class="token keyword">function</span><span class="token punctuation">(</span>resolve<span class="token punctuation">)</span><span class="token punctuation">{<!-- --></span>
    console<span class="token punctuation">.</span><span class="token function">log</span><span class="token punctuation">(</span><span class="token string">'promise2'</span><span class="token punctuation">)</span>
    <span class="token function">resolve</span><span class="token punctuation">(</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span class="token punctuation">.</span><span class="token function">then</span><span class="token punctuation">(</span><span class="token keyword">function</span><span class="token punctuation">(</span><span class="token punctuation">)</span><span class="token punctuation">{<!-- --></span>
    console<span class="token punctuation">.</span><span class="token function">log</span><span class="token punctuation">(</span><span class="token string">'promise2 resolve'</span><span class="token punctuation">)</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span>
console<span class="token punctuation">.</span><span class="token function">log</span><span class="token punctuation">(</span><span class="token string">'进程 end'</span><span class="token punctuation">)</span>
</code></pre> 
<p>看起来其实挺绕的，如果你看了开篇那篇文章，且看不明白，那你就看我的吧。虽然更复杂，但我觉得我讲得更清楚一些。</p> 
<pre><code>
---------- 主进程开始
1. 进程start
2. 执行函数 async1, 打印 async1 start, 碰到await async2.
3. 执行函数 async2, 打印 async2 start, 碰到await async3.
4. 执行函数 async3, 打印 async3, 并返回回调队列1，函数继续往下执行.
5. 执行Promise , 打印promise1, 并返回回调队列2， 函数继续往下执行.
6. 执行Promise , 打印promise2, 并返回回调队列3， 函数继续往下执行。
7. 进程end
--------- 主进程结束

--- 微任务开始
---------- 回调队列
8. 处理回调队列1， 执行完async3, 返回给 async2, 打印 async2 print undefined, async2 end， 返回回调队列1
9. 处理回调队列2， 打印 promise1 resolve
10. 处理回调队列3， 打印 promise2 resolve

---------- 第二次回调队列
11. 处理时间队列1， 执行完async2, 返回给 async1, 打印 async1 print undefined, async1 end, 此时回调队列为空

--- 微任务结束


--- 宏任务开始

---------- 执行事件循环
12. setTimeout1
13. setTimeout2

--- 宏任务结束

全部结束

</code></pre> 
<p>也就是说最后执行的结果为：</p> 
<pre><code>进程 start
async1 start
async2 start
async3
promise1
promise2
进程 end
async2 print undefined
async2 end
promise1 resolve
promise2 resolve
async1 print undefined
async1 end
setTimeout1
setTimeout2
</code></pre> 
<p>有不明白的欢迎留言。</p>
                
{% endraw %}
