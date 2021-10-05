---
title: 我的NodeJS学习之路7（权限认证）
date: 2019-02-07 16:10:24
layout: post
author: 刘泽美
categories:
  - CSDN文章
  - 导入
tags: 代码人生
---

[原链接](https://blog.csdn.net/weixin_41884153/article/details/86771964)
{% raw %}

                    <svg xmlns="http://www.w3.org/2000/svg" style="display: none;">
                        <path stroke-linecap="round" d="M5,0 0,2.5 5,5z" id="raphael-marker-block" style="-webkit-tap-highlight-color: rgba(0, 0, 0, 0);"></path>
                    </svg>
                    <p>本文来介绍系统中用到的权限认证的知识。</p> 
<p>首先简单介绍一下passportjs。</p> 
<p>Passport做登录验证具有：灵活性、模块化、丰富的中间件等特点，更加详细的介绍请参考：<a href="http://idlelife.org/archives/808">http://idlelife.org/archives/808</a></p> 
<h2><a id="passport_6"></a>如何在项目中使用passport？</h2> 
<blockquote> 
 <p>注意：关于passport的配置信息要放置在<code>app.js</code>所有的路由请求上面，这样才能对所有的路由进行过滤。</p> 
</blockquote> 
<h3><a id="1__10"></a>1. 安装集成</h3> 
<pre><code class="prism language-shell"><span class="token function">npm</span> <span class="token function">install</span> passport --save
</code></pre> 
<p>我们还用到了本地验证策略，所以将passport-local一起安装</p> 
<pre><code class="prism language-shell"><span class="token function">npm</span> <span class="token function">install</span> passport-local --save
</code></pre> 
<h3><a id="2_passport_20"></a>2. 配置passport</h3> 
<p>1.在项目中引用</p> 
<pre><code class="prism language-js"><span class="token keyword">var</span> passport <span class="token operator">=</span> <span class="token function">require</span><span class="token punctuation">(</span><span class="token string">'passport'</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
<span class="token keyword">var</span> LocalStrategy <span class="token operator">=</span> <span class="token function">require</span><span class="token punctuation">(</span><span class="token string">'passport-local'</span><span class="token punctuation">)</span><span class="token punctuation">.</span>Strategy<span class="token punctuation">;</span>
</code></pre> 
<p>2.对策略进行配置</p> 
<pre><code class="prism language-js">passport<span class="token punctuation">.</span><span class="token function">use</span><span class="token punctuation">(</span><span class="token keyword">new</span> <span class="token class-name">LocalStrategy</span><span class="token punctuation">(</span>callback_function<span class="token punctuation">)</span><span class="token punctuation">)</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
</code></pre> 
<blockquote> 
 <p><strong>callback_function:</strong><br> 三个参数分别是：<code>username、password、done</code>。</p> 
</blockquote> 
<ul><li><code>username</code>：需要验证的“用户名”</li><li><code>password</code>：需要验证的“密码”</li><li><code>done</code>： 对验证结果的处理方法</li></ul> 
<blockquote> 
 <p><code>username</code>和<code>password</code>默认对应表单的<code>name="username"</code>和<code>name="password"</code>，也可以自己定义表单的名字，比如：</p> 
</blockquote> 
<pre><code class="prism language-js">passport<span class="token punctuation">.</span><span class="token function">use</span><span class="token punctuation">(</span><span class="token keyword">new</span> <span class="token class-name">LocalStrategy</span><span class="token punctuation">(</span><span class="token punctuation">{<!-- --></span>
    usernameField<span class="token punctuation">:</span> <span class="token string">'email'</span><span class="token punctuation">,</span>
    passwordField<span class="token punctuation">:</span> <span class="token string">'passwd'</span>
  <span class="token punctuation">}</span><span class="token punctuation">,</span>
  <span class="token keyword">function</span><span class="token punctuation">(</span>username<span class="token punctuation">,</span> password<span class="token punctuation">,</span> done<span class="token punctuation">)</span> <span class="token punctuation">{<!-- --></span>
    <span class="token comment">// ...</span>
  <span class="token punctuation">}</span>
<span class="token punctuation">)</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
</code></pre> 
<p>关于<code>done</code>函数：</p> 
<p>处理成功，<code>return done(null, user)</code></p> 
<p>处理失败<code>return done(err)</code>或者<code>return done(null, false)</code>或者<code>return done(null, false, { message: 'Incorrect password.' })</code></p> 
<p>3.对Session进行序列化和反序列化</p> 
<p><strong>序列化：</strong><br> 即：将唯一的值（如登录用户的id）序列化到session中，即sessionID，同时它将作为凭证存储在用户cookie中。</p> 
<pre><code class="prism language-js">passport<span class="token punctuation">.</span><span class="token function">serializeUser</span><span class="token punctuation">(</span><span class="token keyword">function</span> <span class="token punctuation">(</span>user<span class="token punctuation">,</span> done<span class="token punctuation">)</span> <span class="token punctuation">{<!-- --></span>
    <span class="token function">done</span><span class="token punctuation">(</span><span class="token keyword">null</span><span class="token punctuation">,</span> user<span class="token punctuation">.</span>id<span class="token punctuation">)</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
</code></pre> 
<p><strong>反序列化：</strong><br> 即：根据存在的sessionID，从数据库中查询user并存储与req.user中。</p> 
<pre><code class="prism language-js">passport<span class="token punctuation">.</span><span class="token function">deserializeUser</span><span class="token punctuation">(</span><span class="token keyword">function</span> <span class="token punctuation">(</span>id<span class="token punctuation">,</span> done<span class="token punctuation">)</span> <span class="token punctuation">{<!-- --></span>
    <span class="token function">done</span><span class="token punctuation">(</span><span class="token keyword">null</span><span class="token punctuation">,</span> id<span class="token punctuation">)</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
</code></pre> 
<p>做完以上三步，就已经简单地将passport集成在项目中了。</p> 
<h3><a id="3__81"></a>3. 做登录处理</h3> 
<p>在处理登陆请求的路由中，加入登录处理的配置信息，然后passport会自动帮你处理是否登录成功（有点类似shiro）。</p> 
<pre><code class="prism language-js">router<span class="token punctuation">.</span><span class="token function">post</span><span class="token punctuation">(</span><span class="token string">'/login'</span><span class="token punctuation">,</span> passport<span class="token punctuation">.</span><span class="token function">authenticate</span><span class="token punctuation">(</span><span class="token string">'local'</span><span class="token punctuation">,</span> options<span class="token punctuation">)</span><span class="token punctuation">,</span>  success_callback<span class="token punctuation">)</span><span class="token punctuation">;</span>
</code></pre> 
<p>options可以定义的参数：</p> 
<ul><li> <p><code>session</code>：Boolean。设置是否需要session，默认为true</p> </li><li> <p><code>successRedirect</code>：String。设置当验证成功时的跳转链接</p> </li><li> <p><code>failureRedirect</code>：String。设置当验证失败时的跳转链接</p> </li><li> <p><code>failureFlash</code>：Boolean or String。设置为Boolean时，<br> express-flash将调用use()里设置的message。设置为String时将直接调用这里的信息。</p> </li><li> <p><code>successFlash</code>：Boolean or String。使用方法同上。</p> </li><li> <p><code>success_callback</code>：验证成功后做的处理，可以是登录成功后的跳转等等。</p> </li></ul> 
<h3><a id="4__101"></a>4. 在方法中使用校验</h3> 
<p>使用其实很简单，passport扩展了<code>http request</code>默认提供了一些内置方法：</p> 
<ul><li><code>request.logIn(user, options, callback)</code>： 将登录用户存入session。</li></ul> 
<pre><code class="prism language-js">req<span class="token punctuation">.</span><span class="token function">logIn</span><span class="token punctuation">(</span>user<span class="token punctuation">,</span> <span class="token keyword">function</span><span class="token punctuation">(</span>err<span class="token punctuation">)</span> <span class="token punctuation">{<!-- --></span>
  <span class="token keyword">if</span> <span class="token punctuation">(</span>err<span class="token punctuation">)</span> <span class="token punctuation">{<!-- --></span> <span class="token keyword">return</span> <span class="token function">next</span><span class="token punctuation">(</span>err<span class="token punctuation">)</span><span class="token punctuation">;</span> <span class="token punctuation">}</span>
  <span class="token keyword">return</span> res<span class="token punctuation">.</span><span class="token function">redirect</span><span class="token punctuation">(</span><span class="token string">'/users/'</span> <span class="token operator">+</span> user<span class="token punctuation">.</span>username<span class="token punctuation">)</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
</code></pre> 
<p>这样，就可以通过<code>req.user</code>获取<code>user</code>对象了</p> 
<ul><li> <p><code>request.logOut()</code>：退出登录用户，删除session信息。</p> </li><li> <p><code>request.isAuthenticated()</code>：判断当前请求的用户是否已授权（已登录），返回true或false</p> </li><li> <p><code>request.isUnauthenticated()</code>：跟request.isAuthenticated()相反。</p> </li></ul> 
<p>有了上面的知识，我们就可以统一进行验证了。<br> 如：对于后台管理的模块，必须登录用户才能有权限，所以可以对后台管理的所有路由进行拦截，为了方便我们可以自定义一个中间件来统一进行处理：<strong>验证通过，继续；验证不通过，跳回到登录页面，并告知需要登陆。</strong></p> 
<h3><a id="5_authorityjs_124"></a>5. 封装验证中间件：（authority.js）</h3> 
<pre><code class="prism language-js">module<span class="token punctuation">.</span>exports <span class="token operator">=</span> <span class="token punctuation">{<!-- --></span>
    <span class="token comment">/**
     * 登陆权限验证
     */</span>
    isAuthenticated<span class="token punctuation">:</span> <span class="token keyword">function</span> <span class="token punctuation">(</span>req<span class="token punctuation">,</span> res<span class="token punctuation">,</span> next<span class="token punctuation">)</span> <span class="token punctuation">{<!-- --></span>
        <span class="token keyword">if</span><span class="token punctuation">(</span>req<span class="token punctuation">.</span><span class="token function">isAuthenticated</span><span class="token punctuation">(</span><span class="token punctuation">)</span><span class="token punctuation">)</span> <span class="token punctuation">{<!-- --></span>
            <span class="token keyword">return</span> <span class="token function">next</span><span class="token punctuation">(</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
        <span class="token punctuation">}</span><span class="token keyword">else</span><span class="token punctuation">{<!-- --></span>
            req<span class="token punctuation">.</span><span class="token function">flash</span><span class="token punctuation">(</span>config<span class="token punctuation">.</span>constant<span class="token punctuation">.</span>flash<span class="token punctuation">.</span>error<span class="token punctuation">,</span> <span class="token string">'请先登录!'</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
            res<span class="token punctuation">.</span><span class="token function">redirect</span><span class="token punctuation">(</span><span class="token string">'/login'</span><span class="token punctuation">)</span>
        <span class="token punctuation">}</span>
    <span class="token punctuation">}</span>
<span class="token punctuation">}</span><span class="token punctuation">;</span>
</code></pre> 
<h3><a id="6__141"></a>6. 统一对路由进行过滤</h3> 
<pre><code class="prism language-js">app<span class="token punctuation">.</span><span class="token function">use</span><span class="token punctuation">(</span><span class="token string">'/dashboard'</span><span class="token punctuation">,</span> authority<span class="token punctuation">.</span>isAuthenticated<span class="token punctuation">,</span> <span class="token function">require</span><span class="token punctuation">(</span><span class="token string">'./routes/dashboard'</span><span class="token punctuation">)</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
app<span class="token punctuation">.</span><span class="token function">use</span><span class="token punctuation">(</span><span class="token string">'/dashboard/p'</span><span class="token punctuation">,</span> authority<span class="token punctuation">.</span>isAuthenticated<span class="token punctuation">,</span> <span class="token function">require</span><span class="token punctuation">(</span><span class="token string">'./routes/dashboard-p'</span><span class="token punctuation">)</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
app<span class="token punctuation">.</span><span class="token function">use</span><span class="token punctuation">(</span><span class="token string">'/dashboard/u'</span><span class="token punctuation">,</span> authority<span class="token punctuation">.</span>isAuthenticated<span class="token punctuation">,</span> <span class="token function">require</span><span class="token punctuation">(</span><span class="token string">'./routes/dashboard-u'</span><span class="token punctuation">)</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
</code></pre> 
<p>关于passport-local的实用实例，在官方wiki有给出，可以做一下参考。</p> 
<p>原文链接：<a href="https://www.jianshu.com/p/1bcf32ebf893">https://www.jianshu.com/p/1bcf32ebf893</a></p>
                
{% endraw %}
