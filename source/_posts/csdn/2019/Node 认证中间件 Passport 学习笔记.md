---
title: Node 认证中间件 Passport 学习笔记
date: 2019-02-07 16:34:23
layout: post
author: 刘泽美
categories:
  - CSDN文章
  - 导入
tags: 代码人生
---

[原链接](https://blog.csdn.net/weixin_41884153/article/details/86772084)
{% raw %}

                    <svg xmlns="http://www.w3.org/2000/svg" style="display: none;">
                        <path stroke-linecap="round" d="M5,0 0,2.5 5,5z" id="raphael-marker-block" style="-webkit-tap-highlight-color: rgba(0, 0, 0, 0);"></path>
                    </svg>
                    <h1><a id="1__GENERAL_0"></a>1. 综述 GENERAL</h1> 
<p><strong>Simple, unobtrusive authentication for Node.js</strong></p> 
<ul><li> <p>1.综述 GENERAL</p> 
  <ul><li>1.1. 概览 Overview</li><li>1.2. 认证 Authenticate 
    <ul><li>1.2.1. 重定向 Redirects</li><li>1.2.2. 快报 Flash Messages</li><li>1.2.3. 禁用会话 Disable Sessions</li><li>1.2.4. 自定义回调函数 Custom Callback</li></ul> </li><li>1.3. 配置 Configure 
    <ul><li>1.3.1. 策略 Strategies</li><li>1.3.2. 验证回调 Verify Callback</li><li>1.3.3. 中间件 Middleware</li><li>1.3.4. 会话 Session</li></ul> </li><li>1.4. 用户名和密码 Username &amp; Password 
    <ul><li>1.4.1. 配置 Configuration</li><li>1.4.2. 表格 Form</li><li>1.4.3. 路由 Route</li><li>1.4.4. 参数 Parameters</li></ul> </li><li>1.5. OpenID</li><li>1.6. OAuth</li></ul> </li><li> <p>2.内置操作 Operations</p> 
  <ul><li>2.1. 登录 Log In</li><li>2.2. 注销 Log Out</li><li>2.3. 授权 Authorize</li></ul> </li><li> <p>3.具体流程</p> 
  <ul><li>3.1. 第一次访问 (GET)</li><li>3.2. 第二次访问 (POST)</li><li>3.3. 第三次访问 (GET)</li><li>3.4. 用户注销 (GET)</li></ul> </li></ul> 
<h3><a id="11__Overview_36"></a>1.1. 概览 Overview</h3> 
<p>Passport 是 Node 的认证中间件，它的存在只有一个单一的目的，就是认证请求。</p> 
<p>在现今的网络应用中认证方式多种多样。经典做法是用户提供用户名和密码进行登录，但随着社交网络的兴起，OAuth 等基于口令的方式越来越受到欢迎。</p> 
<p>在 Passport 设计理念中就认为每一个网络应用拥有不同的认证需求。因此为了满足各种网络应用，被称作策略的认证机制被封装成单一的模块中，网络应用可自由选择不同策略来实现认证功能。</p> 
<p>认证机制本身可能比较复杂，但是在 Passport 中编写的代码并没有那么繁琐：</p> 
<pre><code class="prism language-js">app<span class="token punctuation">.</span><span class="token function">post</span><span class="token punctuation">(</span><span class="token string">'/login'</span><span class="token punctuation">,</span> 
	passport<span class="token punctuation">.</span><span class="token function">authenticate</span><span class="token punctuation">(</span><span class="token string">'local'</span><span class="token punctuation">,</span> 
	<span class="token punctuation">{<!-- --></span> successRedirect<span class="token punctuation">:</span> <span class="token string">'/'</span><span class="token punctuation">,</span> 
	  failureRedirect<span class="token punctuation">:</span> <span class="token string">'/login'</span> 
	<span class="token punctuation">}</span> <span class="token punctuation">)</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
</code></pre> 
<p>当然首先需要安装 Passport：</p> 
<pre><code class="prism language-shell">$ <span class="token function">npm</span> <span class="token function">install</span> passport
</code></pre> 
<h3><a id="12__Authenticate_55"></a>1.2. 认证 Authenticate</h3> 
<p>通过调用 <code>passport.authenticate()</code>方法及配置相应的策略，就可实现认证网络请求。 <code>authenticate()</code>方法是标准的Node 中间件，在 Express 应用中可以非常方便的作为路由使用。</p> 
<pre><code class="prism language-js">app<span class="token punctuation">.</span><span class="token function">post</span><span class="token punctuation">(</span><span class="token string">'/login'</span><span class="token punctuation">,</span>
  passport<span class="token punctuation">.</span><span class="token function">authenticate</span><span class="token punctuation">(</span><span class="token string">'local'</span><span class="token punctuation">)</span><span class="token punctuation">,</span>
  <span class="token keyword">function</span><span class="token punctuation">(</span>req<span class="token punctuation">,</span> res<span class="token punctuation">)</span> <span class="token punctuation">{<!-- --></span>
    <span class="token comment">// 如果认证通过，将触发该函数</span>
    <span class="token comment">// `req.user` 字段内有认证的用户名.</span>
    res<span class="token punctuation">.</span><span class="token function">redirect</span><span class="token punctuation">(</span><span class="token string">'/users/'</span> <span class="token operator">+</span> req<span class="token punctuation">.</span>user<span class="token punctuation">.</span>username<span class="token punctuation">)</span><span class="token punctuation">;</span>
  <span class="token punctuation">}</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
</code></pre> 
<p>在默认情况下，认证失败后 Passport 会返回 <code>401 Unauthorized</code> 状态的响应，其后面的处理函数也不会被触发。当然认证成功后，处理函数被触发并将认证用户信息作为值赋值给 <code>req.user</code> 。</p> 
<blockquote> 
 <p>注意： 策略必须在路由使用它之前进行配置。</p> 
</blockquote> 
<h5><a id="121__Redirects_70"></a>1.2.1. 重定向 Redirects</h5> 
<p>在认证请求后通常接下来需要处理的事务就是重定向。</p> 
<pre><code class="prism language-js">app<span class="token punctuation">.</span><span class="token function">post</span><span class="token punctuation">(</span><span class="token string">'/login'</span><span class="token punctuation">,</span>
  passport<span class="token punctuation">.</span><span class="token function">authenticate</span><span class="token punctuation">(</span><span class="token string">'local'</span><span class="token punctuation">,</span> 
  <span class="token punctuation">{<!-- --></span> successRedirect<span class="token punctuation">:</span> <span class="token string">'/'</span><span class="token punctuation">,</span>
    failureRedirect<span class="token punctuation">:</span> <span class="token string">'/login'</span> 
  <span class="token punctuation">}</span><span class="token punctuation">)</span>
<span class="token punctuation">)</span><span class="token punctuation">;</span>
</code></pre> 
<p>上述代码中，如果认证成功将会被重定向到首页，如果失败会重新来到登录页面。</p> 
<h5><a id="122__Flash_Messages_81"></a>1.2.2. 快报 Flash Messages</h5> 
<p>当认证失败后客户端被重定向到登录页面，重定向后的页面中经常会显示一些状态提示信息，如：登录失败。那么如何分辨登录页面是认证失败后的重定向还是第一次访问？区别它们的方法就是在 session 中写入一个特殊的标识 <code>flash</code> 。</p> 
<pre><code class="prism language-js">app<span class="token punctuation">.</span><span class="token function">post</span><span class="token punctuation">(</span><span class="token string">'/login'</span><span class="token punctuation">,</span>
  passport<span class="token punctuation">.</span><span class="token function">authenticate</span><span class="token punctuation">(</span><span class="token string">'local'</span><span class="token punctuation">,</span> 
  <span class="token punctuation">{<!-- --></span> successRedirect<span class="token punctuation">:</span> <span class="token string">'/'</span><span class="token punctuation">,</span>
    failureRedirect<span class="token punctuation">:</span> <span class="token string">'/login'</span><span class="token punctuation">,</span>
    failureFlash<span class="token punctuation">:</span> <span class="token boolean">true</span> 
  <span class="token punctuation">}</span><span class="token punctuation">)</span>
<span class="token punctuation">)</span><span class="token punctuation">;</span>
</code></pre> 
<p>上述代码会在认证失败后，将策略的认证函数中返回的信息写入 flash。这是最常用和最好的方法，因为每个策略的认证函数都会把认证失败的准确信息返回。</p> 
<p>当然也可以自定义快报：</p> 
<pre><code class="prism language-js">passport<span class="token punctuation">.</span><span class="token function">authenticate</span><span class="token punctuation">(</span><span class="token string">'local'</span><span class="token punctuation">,</span>
  <span class="token punctuation">{<!-- --></span>failureFlash<span class="token punctuation">:</span> <span class="token string">'Invalid username or password.'</span> <span class="token punctuation">}</span>
<span class="token punctuation">)</span><span class="token punctuation">;</span>
</code></pre> 
<p>或者是认证成功后的快报：</p> 
<pre><code class="prism language-js">passport<span class="token punctuation">.</span><span class="token function">authenticate</span><span class="token punctuation">(</span><span class="token string">'local'</span><span class="token punctuation">,</span> 
  <span class="token punctuation">{<!-- --></span> successFlash<span class="token punctuation">:</span> <span class="token string">'Welcome!'</span> <span class="token punctuation">}</span>
<span class="token punctuation">)</span><span class="token punctuation">;</span>
</code></pre> 
<blockquote> 
 <p>注意： 在 Express 4.x 中使用快报需要添加 <code>connect-flash</code> 中间件。</p> 
</blockquote> 
<h5><a id="123__Disable_Sessions_108"></a>1.2.3. 禁用会话 Disable Sessions</h5> 
<p>由于 HTTP 是无状态协议，所以在认证成功后通常是将登录信息保存在 session 中。但是在某些情况下并不需要 session，如 API 服务需要证书来认证，此时可以放心的禁用会话。</p> 
<pre><code class="prism language-js">app<span class="token punctuation">.</span><span class="token keyword">get</span><span class="token punctuation">(</span><span class="token string">'/api/users/me'</span><span class="token punctuation">,</span>
  passport<span class="token punctuation">.</span><span class="token function">authenticate</span><span class="token punctuation">(</span><span class="token string">'basic'</span><span class="token punctuation">,</span> 
  <span class="token punctuation">{<!-- --></span> session<span class="token punctuation">:</span> <span class="token boolean">false</span> <span class="token punctuation">}</span><span class="token punctuation">)</span><span class="token punctuation">,</span>
  <span class="token keyword">function</span><span class="token punctuation">(</span>req<span class="token punctuation">,</span> res<span class="token punctuation">)</span> <span class="token punctuation">{<!-- --></span>
    res<span class="token punctuation">.</span><span class="token function">json</span><span class="token punctuation">(</span><span class="token punctuation">{<!-- --></span> id<span class="token punctuation">:</span> req<span class="token punctuation">.</span>user<span class="token punctuation">.</span>id<span class="token punctuation">,</span> 
               username<span class="token punctuation">:</span> req<span class="token punctuation">.</span>user<span class="token punctuation">.</span>username 
            <span class="token punctuation">}</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
  <span class="token punctuation">}</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
</code></pre> 
<h5><a id="124__Custom_Callback_120"></a>1.2.4. 自定义回调函数 Custom Callback</h5> 
<p>在处理认证请求时，可自定义回调函数来处理成功或失败的认证。</p> 
<pre><code class="prism language-js">app<span class="token punctuation">.</span><span class="token keyword">get</span><span class="token punctuation">(</span><span class="token string">'/login'</span><span class="token punctuation">,</span> <span class="token keyword">function</span><span class="token punctuation">(</span>req<span class="token punctuation">,</span> res<span class="token punctuation">,</span> next<span class="token punctuation">)</span> <span class="token punctuation">{<!-- --></span>
  passport<span class="token punctuation">.</span><span class="token function">authenticate</span><span class="token punctuation">(</span><span class="token string">'local'</span><span class="token punctuation">,</span> 
    <span class="token keyword">function</span><span class="token punctuation">(</span>err<span class="token punctuation">,</span> user<span class="token punctuation">,</span> info<span class="token punctuation">)</span> <span class="token punctuation">{<!-- --></span>
      <span class="token keyword">if</span> <span class="token punctuation">(</span>err<span class="token punctuation">)</span> <span class="token punctuation">{<!-- --></span> <span class="token keyword">return</span> <span class="token function">next</span><span class="token punctuation">(</span>err<span class="token punctuation">)</span><span class="token punctuation">;</span> <span class="token punctuation">}</span>
      <span class="token keyword">if</span> <span class="token punctuation">(</span><span class="token operator">!</span>user<span class="token punctuation">)</span> <span class="token punctuation">{<!-- --></span> <span class="token keyword">return</span> res<span class="token punctuation">.</span><span class="token function">redirect</span><span class="token punctuation">(</span><span class="token string">'/login'</span><span class="token punctuation">)</span><span class="token punctuation">;</span> <span class="token punctuation">}</span>
      req<span class="token punctuation">.</span><span class="token function">logIn</span><span class="token punctuation">(</span>user<span class="token punctuation">,</span> <span class="token keyword">function</span><span class="token punctuation">(</span>err<span class="token punctuation">)</span> <span class="token punctuation">{<!-- --></span>
        <span class="token keyword">if</span> <span class="token punctuation">(</span>err<span class="token punctuation">)</span> <span class="token punctuation">{<!-- --></span> <span class="token keyword">return</span> <span class="token function">next</span><span class="token punctuation">(</span>err<span class="token punctuation">)</span><span class="token punctuation">;</span> <span class="token punctuation">}</span>
        <span class="token keyword">return</span> res<span class="token punctuation">.</span><span class="token function">redirect</span><span class="token punctuation">(</span><span class="token string">'/users/'</span> <span class="token operator">+</span> user<span class="token punctuation">.</span>username<span class="token punctuation">)</span><span class="token punctuation">;</span>
    <span class="token punctuation">}</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
  <span class="token punctuation">}</span><span class="token punctuation">)</span><span class="token punctuation">(</span>req<span class="token punctuation">,</span> res<span class="token punctuation">,</span> next<span class="token punctuation">)</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
</code></pre> 
<p>上例中，方法 <code>authenticate()</code> 没有作为路由的中间件出现，而是在路由的处理函数中被调用。该方法的回调函数的参数通过闭包从路由中传入。如果认证失败<code>user</code>将被赋值为 <code>false</code>。出现异常 <code>err</code>会被初始化并返回异常信息。可选的 <code>info</code>则返回策略中相关信息。</p> 
<blockquote> 
 <p>注意： 使用自定义回调函数，应用必须建立一个 session （上例通过 req.logIn()） 并发送响应。</p> 
</blockquote> 
<h3><a id="13__Configure_139"></a>1.3. 配置 Configure</h3> 
<p>在认证过程中 Passport 需要配置三个部分：</p> 
<ul><li>认证策略</li><li>应用中间件</li><li>会话（可选）</li></ul> 
<h5><a id="131__Strategies_146"></a>1.3.1. 策略 Strategies</h5> 
<p>Passport 通过策略来认证网络请求。策略可以是用户名和密码的确认认证，可以是 OAuth 的委派认证，还可以是 OpenID 的联合认证。正如上文所提到的策略在使用前必须进行配置。<br> 策略及其配置通过 <code>use()</code>方法实现。比如接下来的通过用户名和密码的认证策略<code>LocalStrategy</code>:</p> 
<pre><code class="prism language-js"><span class="token keyword">var</span> passport <span class="token operator">=</span> <span class="token function">require</span><span class="token punctuation">(</span><span class="token string">'passport'</span><span class="token punctuation">)</span>
<span class="token keyword">var</span> LocalStrategy <span class="token operator">=</span> <span class="token function">require</span><span class="token punctuation">(</span><span class="token string">'passport-local'</span><span class="token punctuation">)</span><span class="token punctuation">.</span>Strategy<span class="token punctuation">;</span>

passport<span class="token punctuation">.</span><span class="token function">use</span><span class="token punctuation">(</span><span class="token keyword">new</span> <span class="token class-name">LocalStrategy</span><span class="token punctuation">(</span>
  <span class="token keyword">function</span><span class="token punctuation">(</span>username<span class="token punctuation">,</span> password<span class="token punctuation">,</span> done<span class="token punctuation">)</span> <span class="token punctuation">{<!-- --></span>
    User<span class="token punctuation">.</span><span class="token function">findOne</span><span class="token punctuation">(</span><span class="token punctuation">{<!-- --></span> username<span class="token punctuation">:</span> username <span class="token punctuation">}</span><span class="token punctuation">,</span> 
    <span class="token keyword">function</span> <span class="token punctuation">(</span>err<span class="token punctuation">,</span> user<span class="token punctuation">)</span> <span class="token punctuation">{<!-- --></span>
      <span class="token keyword">if</span> <span class="token punctuation">(</span>err<span class="token punctuation">)</span> <span class="token punctuation">{<!-- --></span> <span class="token keyword">return</span> <span class="token function">done</span><span class="token punctuation">(</span>err<span class="token punctuation">)</span><span class="token punctuation">;</span> <span class="token punctuation">}</span>
      <span class="token keyword">if</span> <span class="token punctuation">(</span><span class="token operator">!</span>user<span class="token punctuation">)</span> <span class="token punctuation">{<!-- --></span>
        <span class="token keyword">return</span> <span class="token function">done</span><span class="token punctuation">(</span><span class="token keyword">null</span><span class="token punctuation">,</span> <span class="token boolean">false</span><span class="token punctuation">,</span> 
        <span class="token punctuation">{<!-- --></span> message<span class="token punctuation">:</span> <span class="token string">'Incorrect username.'</span> <span class="token punctuation">}</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
      <span class="token punctuation">}</span>
      <span class="token keyword">if</span> <span class="token punctuation">(</span><span class="token operator">!</span>user<span class="token punctuation">.</span><span class="token function">validPassword</span><span class="token punctuation">(</span>password<span class="token punctuation">)</span><span class="token punctuation">)</span> <span class="token punctuation">{<!-- --></span>
        <span class="token keyword">return</span> <span class="token function">done</span><span class="token punctuation">(</span><span class="token keyword">null</span><span class="token punctuation">,</span> <span class="token boolean">false</span><span class="token punctuation">,</span> 
        <span class="token punctuation">{<!-- --></span> message<span class="token punctuation">:</span> <span class="token string">'Incorrect password.'</span> <span class="token punctuation">}</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
      <span class="token punctuation">}</span>
      <span class="token keyword">return</span> <span class="token function">done</span><span class="token punctuation">(</span><span class="token keyword">null</span><span class="token punctuation">,</span> user<span class="token punctuation">)</span><span class="token punctuation">;</span>
    <span class="token punctuation">}</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
  <span class="token punctuation">}</span>
<span class="token punctuation">)</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
</code></pre> 
<h5><a id="132__Verify_Callback_171"></a>1.3.2. 验证回调 Verify Callback</h5> 
<p>上面的例子中有个很重要的概念：策略中需要验证回调。验证回调目的是找到拥有认证信息的用户。<br> 当 Passport 验证一个请求时，会解析请求中的认证信息，然后将认证信息发送给验证回调函数同时触发该函数。如果认证信息有效，验证回调函数触发<code>done</code>函数，将认证的用户信息返回给 Passport 。</p> 
<pre><code class="prism language-shell"><span class="token keyword">return</span> done<span class="token punctuation">(</span>null, user<span class="token punctuation">)</span><span class="token punctuation">;</span>
</code></pre> 
<p>如果认证信息无效， <code>done</code> 函数同样也会被触发，但是返回的是<code>false</code>。</p> 
<pre><code class="prism language-shell"><span class="token keyword">return</span> done<span class="token punctuation">(</span>null, false<span class="token punctuation">)</span><span class="token punctuation">;</span>
</code></pre> 
<p>一些附加信息可以追加在 <code>done</code> 函数的第三个参数中，这些信息可用来呈现快报。</p> 
<pre><code class="prism language-shell"><span class="token keyword">return</span> done<span class="token punctuation">(</span>null, false, <span class="token punctuation">{<!-- --></span> message: <span class="token string">'Incorrect password.'</span> <span class="token punctuation">}</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
</code></pre> 
<p>最后如果在验证过程中出现异常，<code>done</code> 函数可以传递一个 Node 风格的 err 信息。</p> 
<pre><code class="prism language-shell"><span class="token keyword">return</span> done<span class="token punctuation">(</span>err<span class="token punctuation">)</span><span class="token punctuation">;</span>
</code></pre> 
<blockquote> 
 <p>注意： 区分开两种验证失败的原因，如果是服务器的异常 <code>done</code>函数的第一个参数 <code>err</code>设置为非空值；验证条件的失败要确保<code>err</code> 为 <code>null</code>。</p> 
</blockquote> 
<p>这种委派方式确保了 Passport 数据库对验证回调函数的透明，应用可任意选择用户信息的存储方式。</p> 
<h5><a id="133__Middleware_193"></a>1.3.3. 中间件 Middleware</h5> 
<p>在 Express 应用中，<code>passport.initialize()</code>中间件可初始化 Passport，<code>passport.session()</code>中间件用来存储用户登录的 session 信息。</p> 
<pre><code class="prism language-js"><span class="token keyword">var</span> app <span class="token operator">=</span> <span class="token function">express</span><span class="token punctuation">(</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
app<span class="token punctuation">.</span><span class="token function">use</span><span class="token punctuation">(</span><span class="token function">require</span><span class="token punctuation">(</span><span class="token string">'serve-static'</span><span class="token punctuation">)</span><span class="token punctuation">(</span>__dirname <span class="token operator">+</span> <span class="token string">'/../../public'</span><span class="token punctuation">)</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
app<span class="token punctuation">.</span><span class="token function">use</span><span class="token punctuation">(</span><span class="token function">require</span><span class="token punctuation">(</span><span class="token string">'body-parser'</span><span class="token punctuation">)</span><span class="token punctuation">.</span><span class="token function">urlencoded</span><span class="token punctuation">(</span><span class="token punctuation">{<!-- --></span> extended<span class="token punctuation">:</span> <span class="token boolean">true</span> <span class="token punctuation">}</span><span class="token punctuation">)</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
app<span class="token punctuation">.</span><span class="token function">use</span><span class="token punctuation">(</span><span class="token function">require</span><span class="token punctuation">(</span><span class="token string">'express-session'</span><span class="token punctuation">)</span><span class="token punctuation">(</span><span class="token punctuation">{<!-- --></span> secret<span class="token punctuation">:</span> <span class="token string">'keyboard cat'</span><span class="token punctuation">,</span> resave<span class="token punctuation">:</span> <span class="token boolean">true</span><span class="token punctuation">,</span> saveUninitialized<span class="token punctuation">:</span> <span class="token boolean">true</span> <span class="token punctuation">}</span><span class="token punctuation">)</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
app<span class="token punctuation">.</span><span class="token function">use</span><span class="token punctuation">(</span>passport<span class="token punctuation">.</span><span class="token function">initialize</span><span class="token punctuation">(</span><span class="token punctuation">)</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
app<span class="token punctuation">.</span><span class="token function">use</span><span class="token punctuation">(</span>passport<span class="token punctuation">.</span><span class="token function">session</span><span class="token punctuation">(</span><span class="token punctuation">)</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
</code></pre> 
<blockquote> 
 <p>注意：<code>express.session()</code>中间件应该在<code>passport.session()</code>中间件前面。</p> 
</blockquote> 
<h5><a id="134__Session_207"></a>1.3.4. 会话 Session</h5> 
<p>在典型的网络应用中，登录请求中包含验证用户的认证信息。如果认证成功，用户浏览器中通过 cookie 创建并保存 sessionID。随后所有的请求不再需要验证，而是通过 sessionID 来识别用户。Passport 可以将 session 中的用户信息序列化或反序列化，以此支持 session 机制。</p> 
<pre><code class="prism language-js">passport<span class="token punctuation">.</span><span class="token function">serializeUser</span><span class="token punctuation">(</span><span class="token keyword">function</span><span class="token punctuation">(</span>user<span class="token punctuation">,</span> done<span class="token punctuation">)</span> <span class="token punctuation">{<!-- --></span>
  <span class="token function">done</span><span class="token punctuation">(</span><span class="token keyword">null</span><span class="token punctuation">,</span> user<span class="token punctuation">.</span>id<span class="token punctuation">)</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span class="token punctuation">;</span>

passport<span class="token punctuation">.</span><span class="token function">deserializeUser</span><span class="token punctuation">(</span><span class="token keyword">function</span><span class="token punctuation">(</span>id<span class="token punctuation">,</span> done<span class="token punctuation">)</span> <span class="token punctuation">{<!-- --></span>
  User<span class="token punctuation">.</span><span class="token function">findById</span><span class="token punctuation">(</span>id<span class="token punctuation">,</span> <span class="token keyword">function</span><span class="token punctuation">(</span>err<span class="token punctuation">,</span> user<span class="token punctuation">)</span> <span class="token punctuation">{<!-- --></span>
    <span class="token function">done</span><span class="token punctuation">(</span>err<span class="token punctuation">,</span> user<span class="token punctuation">)</span><span class="token punctuation">;</span>
  <span class="token punctuation">}</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
</code></pre> 
<p>上述代码中，user ID 被序列化到 session 中，接下来的请求中，通过 user ID 获取用户信息并将其存入到 <code>req.user</code>中。</p> 
<p>序列化和反序列化的逻辑由应用提供，可以选择适合的数据库存储会话，在认证层面这些操作没有任何的限制。</p> 
<h3><a id="14__Username__Password_224"></a>1.4. 用户名和密码 Username &amp; Password</h3> 
<p>网络中最常用的方式就是通过用户名和密码进行认证，提供这种认证的策略是 <code>passport-local</code> 。</p> 
<pre><code class="prism language-shell">$ <span class="token function">npm</span> <span class="token function">install</span> passport-local
</code></pre> 
<h5><a id="141__Configuration_229"></a>1.4.1. 配置 Configuration</h5> 
<pre><code class="prism language-js"><span class="token keyword">var</span> passport <span class="token operator">=</span> <span class="token function">require</span><span class="token punctuation">(</span><span class="token string">'passport'</span><span class="token punctuation">)</span>
  <span class="token punctuation">,</span> LocalStrategy <span class="token operator">=</span> <span class="token function">require</span><span class="token punctuation">(</span><span class="token string">'passport-local'</span><span class="token punctuation">)</span><span class="token punctuation">.</span>Strategy<span class="token punctuation">;</span>

passport<span class="token punctuation">.</span><span class="token function">use</span><span class="token punctuation">(</span><span class="token keyword">new</span> <span class="token class-name">LocalStrategy</span><span class="token punctuation">(</span>
  <span class="token keyword">function</span><span class="token punctuation">(</span>username<span class="token punctuation">,</span> password<span class="token punctuation">,</span> done<span class="token punctuation">)</span> <span class="token punctuation">{<!-- --></span>
    User<span class="token punctuation">.</span><span class="token function">findOne</span><span class="token punctuation">(</span><span class="token punctuation">{<!-- --></span> username<span class="token punctuation">:</span> username <span class="token punctuation">}</span><span class="token punctuation">,</span> <span class="token keyword">function</span><span class="token punctuation">(</span>err<span class="token punctuation">,</span> user<span class="token punctuation">)</span> <span class="token punctuation">{<!-- --></span>
      <span class="token keyword">if</span> <span class="token punctuation">(</span>err<span class="token punctuation">)</span> <span class="token punctuation">{<!-- --></span> <span class="token keyword">return</span> <span class="token function">done</span><span class="token punctuation">(</span>err<span class="token punctuation">)</span><span class="token punctuation">;</span> <span class="token punctuation">}</span>
      <span class="token keyword">if</span> <span class="token punctuation">(</span><span class="token operator">!</span>user<span class="token punctuation">)</span> <span class="token punctuation">{<!-- --></span>
        <span class="token keyword">return</span> <span class="token function">done</span><span class="token punctuation">(</span><span class="token keyword">null</span><span class="token punctuation">,</span> <span class="token boolean">false</span><span class="token punctuation">,</span> 
        <span class="token punctuation">{<!-- --></span> message<span class="token punctuation">:</span> <span class="token string">'Incorrect username.'</span> <span class="token punctuation">}</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
      <span class="token punctuation">}</span>
      <span class="token keyword">if</span> <span class="token punctuation">(</span><span class="token operator">!</span>user<span class="token punctuation">.</span><span class="token function">validPassword</span><span class="token punctuation">(</span>password<span class="token punctuation">)</span><span class="token punctuation">)</span> <span class="token punctuation">{<!-- --></span>
        <span class="token keyword">return</span> <span class="token function">done</span><span class="token punctuation">(</span><span class="token keyword">null</span><span class="token punctuation">,</span> <span class="token boolean">false</span><span class="token punctuation">,</span> 
        <span class="token punctuation">{<!-- --></span> message<span class="token punctuation">:</span> <span class="token string">'Incorrect password.'</span> <span class="token punctuation">}</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
      <span class="token punctuation">}</span>
      <span class="token keyword">return</span> <span class="token function">done</span><span class="token punctuation">(</span><span class="token keyword">null</span><span class="token punctuation">,</span> user<span class="token punctuation">)</span><span class="token punctuation">;</span>
    <span class="token punctuation">}</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
  <span class="token punctuation">}</span>
<span class="token punctuation">)</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
</code></pre> 
<p>本地认证的验证回调函数接受<code>username</code>和<code>password</code>两个参数。</p> 
<h5><a id="142__Form_252"></a>1.4.2. 表格 Form</h5> 
<p>表格提供了<code>username</code> 和 <code>password</code>这两个参数：</p> 
<pre><code class="prism language-html"><span class="token tag"><span class="token tag"><span class="token punctuation">&lt;</span>form</span> <span class="token attr-name">action</span><span class="token attr-value"><span class="token punctuation">=</span><span class="token punctuation">"</span>/login<span class="token punctuation">"</span></span> <span class="token attr-name">method</span><span class="token attr-value"><span class="token punctuation">=</span><span class="token punctuation">"</span>post<span class="token punctuation">"</span></span><span class="token punctuation">&gt;</span></span>
    <span class="token tag"><span class="token tag"><span class="token punctuation">&lt;</span>div</span><span class="token punctuation">&gt;</span></span>
        <span class="token tag"><span class="token tag"><span class="token punctuation">&lt;</span>label</span><span class="token punctuation">&gt;</span></span>Username:<span class="token tag"><span class="token tag"><span class="token punctuation">&lt;/</span>label</span><span class="token punctuation">&gt;</span></span>
        <span class="token tag"><span class="token tag"><span class="token punctuation">&lt;</span>input</span> <span class="token attr-name">type</span><span class="token attr-value"><span class="token punctuation">=</span><span class="token punctuation">"</span>text<span class="token punctuation">"</span></span> <span class="token attr-name">name</span><span class="token attr-value"><span class="token punctuation">=</span><span class="token punctuation">"</span>username<span class="token punctuation">"</span></span><span class="token punctuation">/&gt;</span></span>
    <span class="token tag"><span class="token tag"><span class="token punctuation">&lt;/</span>div</span><span class="token punctuation">&gt;</span></span>
    <span class="token tag"><span class="token tag"><span class="token punctuation">&lt;</span>div</span><span class="token punctuation">&gt;</span></span>
        <span class="token tag"><span class="token tag"><span class="token punctuation">&lt;</span>label</span><span class="token punctuation">&gt;</span></span>Password:<span class="token tag"><span class="token tag"><span class="token punctuation">&lt;/</span>label</span><span class="token punctuation">&gt;</span></span>
        <span class="token tag"><span class="token tag"><span class="token punctuation">&lt;</span>input</span> <span class="token attr-name">type</span><span class="token attr-value"><span class="token punctuation">=</span><span class="token punctuation">"</span>password<span class="token punctuation">"</span></span> <span class="token attr-name">name</span><span class="token attr-value"><span class="token punctuation">=</span><span class="token punctuation">"</span>password<span class="token punctuation">"</span></span><span class="token punctuation">/&gt;</span></span>
    <span class="token tag"><span class="token tag"><span class="token punctuation">&lt;/</span>div</span><span class="token punctuation">&gt;</span></span>
    <span class="token tag"><span class="token tag"><span class="token punctuation">&lt;</span>div</span><span class="token punctuation">&gt;</span></span>
        <span class="token tag"><span class="token tag"><span class="token punctuation">&lt;</span>input</span> <span class="token attr-name">type</span><span class="token attr-value"><span class="token punctuation">=</span><span class="token punctuation">"</span>submit<span class="token punctuation">"</span></span> <span class="token attr-name">value</span><span class="token attr-value"><span class="token punctuation">=</span><span class="token punctuation">"</span>Log In<span class="token punctuation">"</span></span><span class="token punctuation">/&gt;</span></span>
    <span class="token tag"><span class="token tag"><span class="token punctuation">&lt;/</span>div</span><span class="token punctuation">&gt;</span></span>
<span class="token tag"><span class="token tag"><span class="token punctuation">&lt;/</span>form</span><span class="token punctuation">&gt;</span></span>
</code></pre> 
<h5><a id="143__Route_269"></a>1.4.3. 路由 Route</h5> 
<p>登录表格信息通过<code>POST</code>方法提交给服务器，<code>local</code>策略使用<code>authenticate()</code>函数处理登录请求：</p> 
<pre><code class="prism language-js">app<span class="token punctuation">.</span><span class="token function">post</span><span class="token punctuation">(</span><span class="token string">'/login'</span><span class="token punctuation">,</span>
  passport<span class="token punctuation">.</span><span class="token function">authenticate</span><span class="token punctuation">(</span><span class="token string">'local'</span><span class="token punctuation">,</span> 
    <span class="token punctuation">{<!-- --></span> successRedirect<span class="token punctuation">:</span> <span class="token string">'/'</span><span class="token punctuation">,</span>
      failureRedirect<span class="token punctuation">:</span> <span class="token string">'/login'</span><span class="token punctuation">,</span>
      failureFlash<span class="token punctuation">:</span> <span class="token boolean">true</span> 
    <span class="token punctuation">}</span><span class="token punctuation">)</span>
<span class="token punctuation">)</span><span class="token punctuation">;</span>
</code></pre> 
<p>设置<code>failureFlash</code>选项为<code>true</code>，意味着在验证回调函数中返回的<code>message</code>信息将成为错误快报的值。</p> 
<h5><a id="144__Parameters_281"></a>1.4.4. 参数 Parameters</h5> 
<p>默认情况下，<code>localStrategy</code>策略使用<code>username</code> 和 <code>password</code>作为认证机制的参数，实际上其他字段也可以作为参数进行验证：</p> 
<pre><code class="prism language-js">passport<span class="token punctuation">.</span><span class="token function">use</span><span class="token punctuation">(</span><span class="token keyword">new</span> <span class="token class-name">LocalStrategy</span><span class="token punctuation">(</span><span class="token punctuation">{<!-- --></span>
    usernameField<span class="token punctuation">:</span> <span class="token string">'email'</span><span class="token punctuation">,</span>
    passwordField<span class="token punctuation">:</span> <span class="token string">'passwd'</span>
  <span class="token punctuation">}</span><span class="token punctuation">,</span>
  <span class="token keyword">function</span><span class="token punctuation">(</span>username<span class="token punctuation">,</span> password<span class="token punctuation">,</span> done<span class="token punctuation">)</span> <span class="token punctuation">{<!-- --></span>
    <span class="token comment">// ...</span>
  <span class="token punctuation">}</span>
<span class="token punctuation">)</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
</code></pre> 
<h3><a id="15_OpenID_293"></a>1.5. OpenID</h3> 
<p>暂时用不到 _</p> 
<h3><a id="16_OAuth_295"></a>1.6. OAuth</h3> 
<p>暂时用不到 _</p> 
<h1><a id="2__Operations_297"></a>2. 内置操作 Operations</h1> 
<h3><a id="21__Log_In_298"></a>2.1. 登录 Log In</h3> 
<p>Passport 通过暴露给<code>req</code>的<code>login()</code>方法建立登录会话。</p> 
<pre><code class="prism language-js">req<span class="token punctuation">.</span><span class="token function">login</span><span class="token punctuation">(</span>user<span class="token punctuation">,</span> <span class="token keyword">function</span><span class="token punctuation">(</span>err<span class="token punctuation">)</span> <span class="token punctuation">{<!-- --></span>
  <span class="token keyword">if</span> <span class="token punctuation">(</span>err<span class="token punctuation">)</span> <span class="token punctuation">{<!-- --></span> <span class="token keyword">return</span> <span class="token function">next</span><span class="token punctuation">(</span>err<span class="token punctuation">)</span><span class="token punctuation">;</span> <span class="token punctuation">}</span>
  <span class="token keyword">return</span> res<span class="token punctuation">.</span><span class="token function">redirect</span><span class="token punctuation">(</span><span class="token string">'/users/'</span> <span class="token operator">+</span> req<span class="token punctuation">.</span>user<span class="token punctuation">.</span>username<span class="token punctuation">)</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
</code></pre> 
<p>登录操作完成后，用户信息被指派在 <code>req.user</code> 上。</p> 
<blockquote> 
 <p>注意： <code>passport.authenticate()</code>中间件会自动触发 <code>req.login()</code>。 这项功能主要使用在用户注册时，调用 <code>req.login()</code> 方法自动登录新注册的用户。</p> 
</blockquote> 
<h3><a id="22__Log_Out_310"></a>2.2. 注销 Log Out</h3> 
<p>与<code>login()</code>相反，<code>logout()</code>方法用来结束登录会话。 调用 <code>logout()</code>方法会删除<code>req.user</code>属性并清除登录会话。</p> 
<pre><code class="prism language-js">app<span class="token punctuation">.</span><span class="token keyword">get</span><span class="token punctuation">(</span><span class="token string">'/logout'</span><span class="token punctuation">,</span> <span class="token keyword">function</span><span class="token punctuation">(</span>req<span class="token punctuation">,</span> res<span class="token punctuation">)</span><span class="token punctuation">{<!-- --></span>
  req<span class="token punctuation">.</span><span class="token function">logout</span><span class="token punctuation">(</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
  res<span class="token punctuation">.</span><span class="token function">redirect</span><span class="token punctuation">(</span><span class="token string">'/'</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
</code></pre> 
<h3><a id="23__Authorize_318"></a>2.3. 授权 Authorize</h3> 
<p>暂时用不到 _</p> 
<h1><a id="3__320"></a>3. 具体流程</h1> 
<h3><a id="31__GET_321"></a>3.1. 第一次访问 (GET)</h3> 
<ul><li>客户端访问服务器登录页面。</li><li>服务器生成sessionid。 (express-session)</li><li>服务器将seesionid对应的session保存在数据库中。 (express-session)</li><li>在session中添加crsf。 (cursf)</li><li>服务器将sessionid保存到cookie中，返回给客户端，同时将csrf token返回给客户端。 (express-session)</li><li>客户端保存cookie。</li><li>客户端填写登录内容。</li></ul> 
<h3><a id="32__POST_331"></a>3.2. 第二次访问 (POST)</h3> 
<ul><li>客户端将登陆内容、cookie和csrf token发送给服务器。</li><li>服务器查找对应sessionid的session。 (express-session)</li><li>服务器验证csrf token。 (cursf)</li><li>服务器验证登录内容。 (passport/autenticate)</li><li>服务器将用户信息挂载在 req.user。 (passport/req.login)</li><li>将用户信息序列化成userid保存到session中。 (passport/serialize)</li><li>服务器重定向。</li></ul> 
<h3><a id="33__GET_341"></a>3.3. 第三次访问 (GET)</h3> 
<ul><li>客户端访问页面。</li><li>客户端发送cookie和csrf token。</li><li>服务器查找与sessionid对应session。 (express-session)</li><li>服务器验证csrf token。(GET 方法忽略验证)</li><li>服务器将session中的userid反序列化，附加到 req.user。 (passport/deserialize)</li><li>服务器返回用户内容。</li></ul> 
<h3><a id="34__GET_350"></a>3.4. 用户注销 (GET)</h3> 
<ul><li>客户端发送注销信息</li><li>客户端发送出去cookie和csrf token。</li><li>服务器查找sessionid对应的session。 (express-session)</li><li>服务器调用req.logout将userid从session删除。 (passport/req.logout)</li><li>服务器重定向。</li></ul> 
<p>原文链接：<a href="https://www.jianshu.com/p/2a3c178e2e9c">https://www.jianshu.com/p/2a3c178e2e9c</a></p>
                
{% endraw %}
