---
title: webpack从入门到精通----（一）什么是webpack及webpack基础配置
date: 2019-09-23 08:13:06
layout: post
author: 刘泽美
categories:
  - CSDN文章
  - 导入
tags: 代码人生
---

[原链接](https://blog.csdn.net/weixin_41884153/article/details/101191152)
{% raw %}

                    <svg xmlns="http://www.w3.org/2000/svg" style="display: none;">
                        <path stroke-linecap="round" d="M5,0 0,2.5 5,5z" id="raphael-marker-block" style="-webkit-tap-highlight-color: rgba(0, 0, 0, 0);"></path>
                    </svg>
                    <h3><a id="1_webpack_1"></a>1. 什么是webpack</h3> 
<p>webpack可以看做是模块打包机：它做的事情是，分析你的项目结构，找到JavaScript模块以及其他的一些浏览器不能直接运行的拓展语言（scss，ts等），并将其打包为合适的格式以供浏览器使用。<br> 可以做的事情：</p> 
<blockquote> 
 <p>代码转换、文件优化、代码分割、模块合并、自动刷新、代码校验、自动发布</p> 
</blockquote> 
<h3><a id="2__6"></a>2. 需要提前掌握的内容</h3> 
<ul><li>需要node基础，以及npm的使用</li><li>掌握es6语法</li></ul> 
<h3><a id="3_webpack_11"></a>3. webpack安装</h3> 
<ul><li>安装本地的webpack</li><li><code>npm install webpack webpack-cli -D</code></li></ul> 
<blockquote> 
 <p><code>-D</code>的意思是开发依赖，上线后不需要打包</p> 
</blockquote> 
<h3><a id="4_webpack0_16"></a>4. webpack可以进行0配置</h3> 
<ul><li>打包工具 -&gt; 输出后的结果（js模块）</li><li>打包（支持模块化）</li></ul> 
<h3><a id="5__webpack_20"></a>5. 手动配置 webpack</h3> 
<ul><li>默认配置文件的名字 webpack.config.js</li></ul> 
<pre><code class="prism language-js"><span class="token keyword">let</span> path <span class="token operator">=</span> <span class="token function">require</span><span class="token punctuation">(</span><span class="token string">'path'</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
console<span class="token punctuation">.</span><span class="token function">log</span><span class="token punctuation">(</span>path<span class="token punctuation">.</span><span class="token function">resolve</span><span class="token punctuation">(</span><span class="token string">'dist'</span><span class="token punctuation">)</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
module<span class="token punctuation">.</span>exports <span class="token operator">=</span> <span class="token punctuation">{<!-- --></span>
    mode<span class="token punctuation">:</span> <span class="token string">'production'</span><span class="token punctuation">,</span> <span class="token comment">// 模式 默认两种 production development</span>
    entry<span class="token punctuation">:</span> <span class="token string">'./src/index.js'</span><span class="token punctuation">,</span> <span class="token comment">//入口</span>
    output<span class="token punctuation">:</span> <span class="token punctuation">{<!-- --></span> <span class="token comment">// 出口</span>
        filename<span class="token punctuation">:</span> <span class="token string">'bundle.js'</span><span class="token punctuation">,</span> <span class="token comment">// 打包后的文件名</span>
        path<span class="token punctuation">:</span> path<span class="token punctuation">.</span><span class="token function">resolve</span><span class="token punctuation">(</span>__dirname<span class="token punctuation">,</span> <span class="token string">'dist'</span><span class="token punctuation">)</span> <span class="token comment">// 路径必须是一个绝对路径</span>
    <span class="token punctuation">}</span>
<span class="token punctuation">}</span>
</code></pre> 
<blockquote> 
 <p>以下为打包出来的js文件</p> 
</blockquote> 
<pre><code class="prism language-js"><span class="token operator">!</span><span class="token keyword">function</span> <span class="token punctuation">(</span>modules<span class="token punctuation">)</span> <span class="token punctuation">{<!-- --></span>
    <span class="token comment">// 先定义一个缓存</span>
    <span class="token keyword">var</span> installedModules <span class="token operator">=</span> <span class="token punctuation">{<!-- --></span><span class="token punctuation">}</span><span class="token punctuation">;</span>

    <span class="token comment">// 配置了 实现了 require    </span>
    <span class="token keyword">function</span> <span class="token function">__webpack_require__</span><span class="token punctuation">(</span>moduleId<span class="token punctuation">)</span> <span class="token punctuation">{<!-- --></span>
        <span class="token comment">// 检查一下模块是否在缓存中</span>
        <span class="token keyword">if</span> <span class="token punctuation">(</span>installedModules<span class="token punctuation">[</span>moduleId<span class="token punctuation">]</span><span class="token punctuation">)</span> <span class="token keyword">return</span> installedModules<span class="token punctuation">[</span>moduleId<span class="token punctuation">]</span><span class="token punctuation">.</span>exports<span class="token punctuation">;</span>

        <span class="token comment">// 不在缓存中，则开始安装模块,并推入缓存中</span>
        <span class="token keyword">var</span> module <span class="token operator">=</span> installedModules<span class="token punctuation">[</span>moduleId<span class="token punctuation">]</span> <span class="token operator">=</span> <span class="token punctuation">{<!-- --></span>
            i<span class="token punctuation">:</span> moduleId<span class="token punctuation">,</span> <span class="token comment">// index</span>
            l<span class="token punctuation">:</span> <span class="token operator">!</span><span class="token number">1</span><span class="token punctuation">,</span>  <span class="token comment">// 是否加载完成</span>
            exports<span class="token punctuation">:</span> <span class="token punctuation">{<!-- --></span><span class="token punctuation">}</span>
        <span class="token punctuation">}</span><span class="token punctuation">;</span>
        <span class="token comment">// 执行这个模块函数</span>
        modules<span class="token punctuation">[</span>moduleId<span class="token punctuation">]</span><span class="token punctuation">.</span><span class="token function">call</span><span class="token punctuation">(</span>module<span class="token punctuation">.</span>exports<span class="token punctuation">,</span> module<span class="token punctuation">,</span> module<span class="token punctuation">.</span>exports<span class="token punctuation">,</span> __webpack_require__<span class="token punctuation">)</span><span class="token punctuation">;</span>
        module<span class="token punctuation">.</span>l <span class="token operator">=</span> <span class="token operator">!</span><span class="token number">0</span><span class="token punctuation">;</span>
        <span class="token keyword">return</span> module<span class="token punctuation">.</span>exports
    <span class="token punctuation">}</span>
    __webpack_require__<span class="token punctuation">.</span>m <span class="token operator">=</span> modules<span class="token punctuation">,</span>
        __webpack_require__<span class="token punctuation">.</span>c <span class="token operator">=</span> installedModules<span class="token punctuation">,</span>
        __webpack_require__<span class="token punctuation">.</span><span class="token function-variable function">d</span> <span class="token operator">=</span> <span class="token keyword">function</span> <span class="token punctuation">(</span>e<span class="token punctuation">,</span> t<span class="token punctuation">,</span> r<span class="token punctuation">)</span> <span class="token punctuation">{<!-- --></span>
            __webpack_require__<span class="token punctuation">.</span><span class="token function">o</span><span class="token punctuation">(</span>e<span class="token punctuation">,</span> t<span class="token punctuation">)</span> <span class="token operator">||</span> Object<span class="token punctuation">.</span><span class="token function">defineProperty</span><span class="token punctuation">(</span>e<span class="token punctuation">,</span> t<span class="token punctuation">,</span> <span class="token punctuation">{<!-- --></span> enumerable<span class="token punctuation">:</span> <span class="token operator">!</span><span class="token number">0</span><span class="token punctuation">,</span> <span class="token keyword">get</span><span class="token punctuation">:</span> r <span class="token punctuation">}</span><span class="token punctuation">)</span>
        <span class="token punctuation">}</span><span class="token punctuation">,</span>
        __webpack_require__<span class="token punctuation">.</span><span class="token function-variable function">r</span> <span class="token operator">=</span> <span class="token keyword">function</span> <span class="token punctuation">(</span>e<span class="token punctuation">)</span> <span class="token punctuation">{<!-- --></span>
            <span class="token string">"undefined"</span> <span class="token operator">!=</span> <span class="token keyword">typeof</span> Symbol <span class="token operator">&amp;&amp;</span>
                Symbol<span class="token punctuation">.</span>toStringTag <span class="token operator">&amp;&amp;</span>
                Object<span class="token punctuation">.</span><span class="token function">defineProperty</span><span class="token punctuation">(</span>e<span class="token punctuation">,</span> Symbol<span class="token punctuation">.</span>toStringTag<span class="token punctuation">,</span> <span class="token punctuation">{<!-- --></span> value<span class="token punctuation">:</span> <span class="token string">"Module"</span> <span class="token punctuation">}</span><span class="token punctuation">)</span><span class="token punctuation">,</span>
                Object<span class="token punctuation">.</span><span class="token function">defineProperty</span><span class="token punctuation">(</span>e<span class="token punctuation">,</span> <span class="token string">"__esModule"</span><span class="token punctuation">,</span> <span class="token punctuation">{<!-- --></span> value<span class="token punctuation">:</span> <span class="token operator">!</span><span class="token number">0</span> <span class="token punctuation">}</span><span class="token punctuation">)</span>
        <span class="token punctuation">}</span><span class="token punctuation">,</span>
        __webpack_require__<span class="token punctuation">.</span><span class="token function-variable function">t</span> <span class="token operator">=</span> <span class="token keyword">function</span> <span class="token punctuation">(</span>e<span class="token punctuation">,</span> t<span class="token punctuation">)</span> <span class="token punctuation">{<!-- --></span>
            <span class="token keyword">if</span> <span class="token punctuation">(</span><span class="token number">1</span> <span class="token operator">&amp;</span> t <span class="token operator">&amp;&amp;</span> <span class="token punctuation">(</span>e <span class="token operator">=</span> <span class="token function">__webpack_require__</span><span class="token punctuation">(</span>e<span class="token punctuation">)</span><span class="token punctuation">)</span><span class="token punctuation">,</span> <span class="token number">8</span> <span class="token operator">&amp;</span> t<span class="token punctuation">)</span> <span class="token keyword">return</span> e<span class="token punctuation">;</span> <span class="token keyword">if</span> <span class="token punctuation">(</span><span class="token number">4</span> <span class="token operator">&amp;</span> t <span class="token operator">&amp;&amp;</span> <span class="token string">"object"</span> <span class="token operator">==</span> <span class="token keyword">typeof</span> e <span class="token operator">&amp;&amp;</span> e <span class="token operator">&amp;&amp;</span> e<span class="token punctuation">.</span>__esModule<span class="token punctuation">)</span> <span class="token keyword">return</span> e<span class="token punctuation">;</span>
            <span class="token keyword">var</span> r <span class="token operator">=</span> Object<span class="token punctuation">.</span><span class="token function">create</span><span class="token punctuation">(</span><span class="token keyword">null</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
            <span class="token keyword">if</span> <span class="token punctuation">(</span>__webpack_require__<span class="token punctuation">.</span><span class="token function">r</span><span class="token punctuation">(</span>r<span class="token punctuation">)</span><span class="token punctuation">,</span> Object<span class="token punctuation">.</span><span class="token function">defineProperty</span><span class="token punctuation">(</span>r<span class="token punctuation">,</span> <span class="token string">"default"</span><span class="token punctuation">,</span> <span class="token punctuation">{<!-- --></span> enumerable<span class="token punctuation">:</span> <span class="token operator">!</span><span class="token number">0</span><span class="token punctuation">,</span> value<span class="token punctuation">:</span> e <span class="token punctuation">}</span><span class="token punctuation">)</span><span class="token punctuation">,</span> <span class="token number">2</span> <span class="token operator">&amp;</span> t <span class="token operator">&amp;&amp;</span> <span class="token string">"string"</span> <span class="token operator">!=</span> <span class="token keyword">typeof</span> e<span class="token punctuation">)</span>
                <span class="token keyword">for</span> <span class="token punctuation">(</span><span class="token keyword">var</span> o <span class="token keyword">in</span> e<span class="token punctuation">)</span> __webpack_require__<span class="token punctuation">.</span><span class="token function">d</span><span class="token punctuation">(</span>r<span class="token punctuation">,</span> o<span class="token punctuation">,</span> <span class="token keyword">function</span> <span class="token punctuation">(</span>t<span class="token punctuation">)</span> <span class="token punctuation">{<!-- --></span> <span class="token keyword">return</span> e<span class="token punctuation">[</span>t<span class="token punctuation">]</span> <span class="token punctuation">}</span><span class="token punctuation">.</span><span class="token function">bind</span><span class="token punctuation">(</span><span class="token keyword">null</span><span class="token punctuation">,</span> o<span class="token punctuation">)</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
            <span class="token keyword">return</span> r
        <span class="token punctuation">}</span><span class="token punctuation">,</span>
        __webpack_require__<span class="token punctuation">.</span><span class="token function-variable function">n</span> <span class="token operator">=</span> <span class="token keyword">function</span> <span class="token punctuation">(</span>e<span class="token punctuation">)</span> <span class="token punctuation">{<!-- --></span>
            <span class="token keyword">var</span> t <span class="token operator">=</span> e <span class="token operator">&amp;&amp;</span> e<span class="token punctuation">.</span>__esModule <span class="token operator">?</span> <span class="token keyword">function</span> <span class="token punctuation">(</span><span class="token punctuation">)</span> <span class="token punctuation">{<!-- --></span>
                <span class="token keyword">return</span> e<span class="token punctuation">.</span><span class="token keyword">default</span>
            <span class="token punctuation">}</span> <span class="token punctuation">:</span> <span class="token keyword">function</span> <span class="token punctuation">(</span><span class="token punctuation">)</span> <span class="token punctuation">{<!-- --></span>
                <span class="token keyword">return</span> e
            <span class="token punctuation">}</span><span class="token punctuation">;</span>
            <span class="token keyword">return</span> __webpack_require__<span class="token punctuation">.</span><span class="token function">d</span><span class="token punctuation">(</span>t<span class="token punctuation">,</span> <span class="token string">"a"</span><span class="token punctuation">,</span> t<span class="token punctuation">)</span><span class="token punctuation">,</span> t
        <span class="token punctuation">}</span><span class="token punctuation">,</span>
        __webpack_require__<span class="token punctuation">.</span><span class="token function-variable function">o</span> <span class="token operator">=</span> <span class="token keyword">function</span> <span class="token punctuation">(</span>e<span class="token punctuation">,</span> t<span class="token punctuation">)</span> <span class="token punctuation">{<!-- --></span>
            <span class="token keyword">return</span> Object<span class="token punctuation">.</span>prototype<span class="token punctuation">.</span>hasOwnProperty<span class="token punctuation">.</span><span class="token function">call</span><span class="token punctuation">(</span>e<span class="token punctuation">,</span> t<span class="token punctuation">)</span>
        <span class="token punctuation">}</span><span class="token punctuation">,</span>
        __webpack_require__<span class="token punctuation">.</span>p <span class="token operator">=</span> <span class="token string">""</span><span class="token punctuation">,</span>
        <span class="token function">__webpack_require__</span><span class="token punctuation">(</span>__webpack_require__<span class="token punctuation">.</span>s <span class="token operator">=</span> <span class="token number">0</span><span class="token punctuation">)</span><span class="token punctuation">;</span> <span class="token comment">// 入口模块</span>
<span class="token punctuation">}</span><span class="token punctuation">(</span>
    <span class="token punctuation">[</span>
        <span class="token keyword">function</span> <span class="token punctuation">(</span>module<span class="token punctuation">,</span> exports<span class="token punctuation">,</span> __webpack_require__<span class="token punctuation">)</span> <span class="token punctuation">{<!-- --></span>
            <span class="token keyword">let</span> r <span class="token operator">=</span> <span class="token function">__webpack_require__</span><span class="token punctuation">(</span><span class="token number">1</span><span class="token punctuation">)</span><span class="token punctuation">;</span> <span class="token comment">// 获取导出对象（其他的js文件）</span>
            <span class="token comment">// 执行导出任务的逻辑</span>
            console<span class="token punctuation">.</span><span class="token function">log</span><span class="token punctuation">(</span>r<span class="token punctuation">)</span><span class="token punctuation">,</span>
                console<span class="token punctuation">.</span><span class="token function">log</span><span class="token punctuation">(</span><span class="token string">"hello webpack"</span><span class="token punctuation">)</span>
        <span class="token punctuation">}</span><span class="token punctuation">,</span>
        <span class="token keyword">function</span> <span class="token punctuation">(</span>module<span class="token punctuation">,</span> exports<span class="token punctuation">)</span> <span class="token punctuation">{<!-- --></span>
            module<span class="token punctuation">.</span>exports <span class="token operator">=</span> <span class="token string">"a"</span> <span class="token comment">//  在这里完成了真正的对象导出。</span>
        <span class="token punctuation">}</span>
    <span class="token punctuation">]</span>
<span class="token punctuation">)</span><span class="token punctuation">;</span>
</code></pre> 
<blockquote> 
 <p>目前来看，其实webpack也就是自己实现了<code>module.exports</code>，然后通过加载入口模块，按照顺序加载其他的导出模块。</p> 
</blockquote> 
<h3><a id="6__webpack__103"></a>6. 修改 webpack 的默认名字</h3> 
<p>比如说修改成<code>webpack.config.my.js</code></p> 
<ol><li>命令行<br> <code>npx webpack --config webpack.config.my.js</code></li><li>修改package.json文件</li></ol> 
<pre><code class="prism language-json"><span class="token string">"script"</span><span class="token punctuation">:</span> <span class="token punctuation">{<!-- --></span>
    <span class="token string">"build"</span><span class="token punctuation">:</span> <span class="token string">"webpack --config webpack.config.my.js"</span>
<span class="token punctuation">}</span>
</code></pre> 
<blockquote> 
 <p>采用第二种方法之后就可以使用<code>npm run build</code>的操作了</p> 
</blockquote>
                
{% endraw %}
