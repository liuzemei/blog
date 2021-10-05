---
title: koa 初体验
date: 2019-03-24 01:29:20
layout: post
author: 刘泽美
categories:
  - CSDN文章
  - 导入
tags: 代码人生
---

[原链接](https://blog.csdn.net/weixin_41884153/article/details/88772097)
{% raw %}

                    <svg xmlns="http://www.w3.org/2000/svg" style="display: none;">
                        <path stroke-linecap="round" d="M5,0 0,2.5 5,5z" id="raphael-marker-block" style="-webkit-tap-highlight-color: rgba(0, 0, 0, 0);"></path>
                    </svg>
                    <pre><code class="prism language-js"><span class="token keyword">const</span> Koa <span class="token operator">=</span> <span class="token function">require</span><span class="token punctuation">(</span><span class="token string">'koa'</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
<span class="token keyword">const</span> app <span class="token operator">=</span> <span class="token keyword">new</span> <span class="token class-name">Koa</span><span class="token punctuation">(</span><span class="token punctuation">)</span><span class="token punctuation">;</span>

<span class="token comment">// 1. 中间件的演示</span>

<span class="token comment">// app.use(async (ctx, next) =&gt; {<!-- --></span>
<span class="token comment">//     console.log(`${ctx.request.method} ${ctx.request.url}`);</span>
<span class="token comment">//     await next();</span>
<span class="token comment">// })</span>

<span class="token comment">// app.use(async (ctx, next) =&gt; {<!-- --></span>
<span class="token comment">//     const start = new Date().getTime(); //当前时间</span>
<span class="token comment">//     await next();</span>
<span class="token comment">//     const ms = new Date().getTime() - start;</span>
<span class="token comment">//     console.log(`Time: ${ms}ms`)</span>
<span class="token comment">// })</span>

<span class="token comment">// app.use(async (ctx, next) =&gt; {<!-- --></span>
<span class="token comment">//     await next();</span>
<span class="token comment">//     ctx.type = 'text/html';</span>
<span class="token comment">//     ctx.body = '&lt;h1&gt;Hello, Koa2!&lt;/h1&gt;';</span>
<span class="token comment">// })</span>


<span class="token comment">// 2. 设置不同的路由演示</span>
<span class="token comment">// app.use(async (ctx, next) =&gt; {<!-- --></span>
<span class="token comment">//     if(ctx.url === '/') ctx.body = 'index page'</span>
<span class="token comment">//     else await next();</span>
<span class="token comment">// })</span>

<span class="token comment">// app.use(async (ctx, next) =&gt; {<!-- --></span>
<span class="token comment">//     if(ctx.url === '/test') ctx.body = 'test page'</span>
<span class="token comment">//     else await next();</span>
<span class="token comment">// })</span>

<span class="token comment">// app.use(async (ctx, next) =&gt; {<!-- --></span>
<span class="token comment">//     if(ctx.url === '/error') ctx.body = 'error page'</span>
<span class="token comment">//     else await next();</span>
<span class="token comment">// })</span>

<span class="token comment">// 3. 使用koa-router 改进2的代码</span>
<span class="token comment">// npm i koa-router</span>
<span class="token comment">// const router = require('koa-router')();// 注意这里是一个函数</span>


<span class="token comment">// app.use(async (ctx, next) =&gt; {<!-- --></span>
<span class="token comment">//     console.log(`Process ${ctx.method} ${ctx.url}...`);</span>
<span class="token comment">//     await next();</span>
<span class="token comment">// });</span>


<span class="token comment">// router.get('/hello/:name', async (ctx, next) =&gt; {<!-- --></span>
<span class="token comment">//     let name = ctx.params.name;</span>
<span class="token comment">//     ctx.body = `&lt;h1&gt;Hello, ${name} !&lt;/h1&gt;`</span>
<span class="token comment">// })</span>

<span class="token comment">// router.get('/', async (ctx, next) =&gt; {<!-- --></span>
<span class="token comment">//     ctx.body = `&lt;h1&gt; Index &lt;/h1&gt;`</span>
<span class="token comment">// })</span>


<span class="token comment">// app.use(router.routes());//将router.routes()注册到app</span>
<span class="token comment">//注意，这句话一般是要放到最后的，因为这句话之后的中间件都不会执行。</span>

<span class="token comment">// 4. 使用 koa-router 的 post 请求中间件问题</span>
<span class="token keyword">const</span> router <span class="token operator">=</span> <span class="token function">require</span><span class="token punctuation">(</span><span class="token string">'koa-router'</span><span class="token punctuation">)</span><span class="token punctuation">(</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
<span class="token keyword">const</span> bodyParser <span class="token operator">=</span> <span class="token function">require</span><span class="token punctuation">(</span><span class="token string">'koa-bodyparser'</span><span class="token punctuation">)</span><span class="token punctuation">;</span><span class="token comment">// npm i koa-bodyparser</span>

app<span class="token punctuation">.</span><span class="token function">use</span><span class="token punctuation">(</span><span class="token function">bodyParser</span><span class="token punctuation">(</span><span class="token punctuation">)</span><span class="token punctuation">)</span><span class="token punctuation">;</span>

router<span class="token punctuation">.</span><span class="token keyword">get</span><span class="token punctuation">(</span><span class="token string">'/'</span><span class="token punctuation">,</span> <span class="token keyword">async</span> <span class="token punctuation">(</span>ctx<span class="token punctuation">,</span> next<span class="token punctuation">)</span> <span class="token operator">=&gt;</span> <span class="token punctuation">{<!-- --></span>
    ctx<span class="token punctuation">.</span>body <span class="token operator">=</span> <span class="token template-string"><span class="token string">`
        &lt;h1&gt; Index &lt;/h1&gt;
        &lt;form action='/signin' method='post'&gt;
            &lt;p&gt; Name: &lt;input name='name' value='koa' /&gt; &lt;/p&gt;
            &lt;p&gt; Password: &lt;input name='password' type='password' /&gt; &lt;/p&gt;
            &lt;p&gt; &lt;input type='submit' value='Submit' /&gt; &lt;/p&gt;
        &lt;/form&gt;
    `</span></span>
<span class="token punctuation">}</span><span class="token punctuation">)</span>

router<span class="token punctuation">.</span><span class="token function">post</span><span class="token punctuation">(</span><span class="token string">'/signin'</span><span class="token punctuation">,</span> <span class="token keyword">async</span> <span class="token punctuation">(</span>ctx<span class="token punctuation">,</span> next<span class="token punctuation">)</span> <span class="token operator">=&gt;</span> <span class="token punctuation">{<!-- --></span>
    <span class="token keyword">let</span> name <span class="token operator">=</span> ctx<span class="token punctuation">.</span>request<span class="token punctuation">.</span>body<span class="token punctuation">.</span>name <span class="token operator">||</span> <span class="token string">''</span><span class="token punctuation">;</span>
    <span class="token keyword">let</span> password  <span class="token operator">=</span> ctx<span class="token punctuation">.</span>request<span class="token punctuation">.</span>body<span class="token punctuation">.</span>password <span class="token operator">||</span> <span class="token string">''</span><span class="token punctuation">;</span>
    console<span class="token punctuation">.</span><span class="token function">log</span><span class="token punctuation">(</span><span class="token template-string"><span class="token string">`signin with name: </span><span class="token interpolation"><span class="token interpolation-punctuation punctuation">${<!-- --></span>name<span class="token interpolation-punctuation punctuation">}</span></span><span class="token string"> , password: </span><span class="token interpolation"><span class="token interpolation-punctuation punctuation">${<!-- --></span>password<span class="token interpolation-punctuation punctuation">}</span></span><span class="token string">`</span></span><span class="token punctuation">)</span><span class="token punctuation">;</span>
    <span class="token keyword">if</span><span class="token punctuation">(</span>name <span class="token operator">===</span> <span class="token string">'koa'</span> <span class="token operator">&amp;&amp;</span> password <span class="token operator">===</span> <span class="token string">'12345'</span><span class="token punctuation">)</span> <span class="token punctuation">{<!-- --></span>
        ctx<span class="token punctuation">.</span>body <span class="token operator">=</span> <span class="token template-string"><span class="token string">`&lt;h1&gt; Welcome, </span><span class="token interpolation"><span class="token interpolation-punctuation punctuation">${<!-- --></span>name<span class="token interpolation-punctuation punctuation">}</span></span><span class="token string">&lt;/h1&gt;`</span></span><span class="token punctuation">;</span>
    <span class="token punctuation">}</span>
    <span class="token keyword">else</span> <span class="token punctuation">{<!-- --></span>
        ctx<span class="token punctuation">.</span>body <span class="token operator">=</span> <span class="token template-string"><span class="token string">`&lt;h1&gt; Login failed! &lt;/h1&gt;
        &lt;p&gt; &lt;a href='/' &gt;Try again &lt;/a&gt; &lt;/p&gt;`</span></span>
    <span class="token punctuation">}</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span>


app<span class="token punctuation">.</span><span class="token function">use</span><span class="token punctuation">(</span>router<span class="token punctuation">.</span><span class="token function">routes</span><span class="token punctuation">(</span><span class="token punctuation">)</span><span class="token punctuation">)</span><span class="token punctuation">;</span>

app<span class="token punctuation">.</span><span class="token function">listen</span><span class="token punctuation">(</span><span class="token number">3000</span><span class="token punctuation">)</span>
</code></pre>
                
{% endraw %}
