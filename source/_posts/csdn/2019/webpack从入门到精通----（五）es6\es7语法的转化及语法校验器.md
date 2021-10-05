---
title: webpack从入门到精通----（五）es6\es7语法的转化及语法校验器
date: 2019-09-25 15:35:22
layout: post
author: 刘泽美
categories:
  - CSDN文章
  - 导入
tags: 代码人生
---

[原链接](https://blog.csdn.net/weixin_41884153/article/details/101368460)
{% raw %}

                    <svg xmlns="http://www.w3.org/2000/svg" style="display: none;">
                        <path stroke-linecap="round" d="M5,0 0,2.5 5,5z" id="raphael-marker-block" style="-webkit-tap-highlight-color: rgba(0, 0, 0, 0);"></path>
                    </svg>
                    <h3><a id="_es6_babel_1"></a>转化 es6 语法(babel)</h3> 
<ol><li>安装<br> <code>yarn add babel-loader @babel/core @babel/preset-env -D</code></li><li>在 webpack.config.js 中 使用</li></ol> 
<pre><code class="prism language-js">module<span class="token punctuation">:</span> <span class="token punctuation">{<!-- --></span> <span class="token comment">// 模块</span>
    rules<span class="token punctuation">:</span> <span class="token punctuation">[</span>
        <span class="token punctuation">{<!-- --></span>
            test<span class="token punctuation">:</span> <span class="token regex">/\.js$/</span><span class="token punctuation">,</span>
            use<span class="token punctuation">:</span> <span class="token punctuation">[</span>
                <span class="token punctuation">{<!-- --></span>
                    loader<span class="token punctuation">:</span> <span class="token string">'babel-loader'</span><span class="token punctuation">,</span>
                    options<span class="token punctuation">:</span> <span class="token punctuation">{<!-- --></span> <span class="token comment">// 用 babel-loader 需要把 es6 -&gt; es5</span>
                        presets<span class="token punctuation">:</span> <span class="token punctuation">[</span>
                            <span class="token string">'@babel/preset-env'</span> <span class="token comment">// 这里面就是把es6 -&gt; es5的模块</span>
                        <span class="token punctuation">]</span>
                    <span class="token punctuation">}</span>
                <span class="token punctuation">}</span><span class="token punctuation">,</span>
            <span class="token punctuation">]</span>
        <span class="token punctuation">}</span>
    <span class="token punctuation">]</span>
<span class="token punctuation">}</span>
</code></pre> 
<blockquote> 
 <p>可以与 uglifyjs 一起用了</p> 
</blockquote> 
<h3><a id="_class__26"></a>支持 class 语法</h3> 
<ol><li> <p>安装插件<br> <code>yarn add @babel/plugin-proposal-class-properties -D</code></p> </li><li> <p>配置插件</p> </li></ol> 
<pre><code class="prism language-js">module<span class="token punctuation">:</span> <span class="token punctuation">{<!-- --></span> <span class="token comment">// 模块</span>
    rules<span class="token punctuation">:</span> <span class="token punctuation">[</span>
        <span class="token punctuation">{<!-- --></span>
            test<span class="token punctuation">:</span> <span class="token regex">/\.js$/</span><span class="token punctuation">,</span>
            use<span class="token punctuation">:</span> <span class="token punctuation">[</span>
                <span class="token punctuation">{<!-- --></span>
                    loader<span class="token punctuation">:</span> <span class="token string">'babel-loader'</span><span class="token punctuation">,</span>
                    options<span class="token punctuation">:</span> <span class="token punctuation">{<!-- --></span> <span class="token comment">// 用 babel-loader 需要把 es6 -&gt; es5</span>
                        presets<span class="token punctuation">:</span> <span class="token punctuation">[</span>
                            <span class="token string">'@babel/preset-env'</span> <span class="token comment">// 这里面就是把es6 -&gt; es5的模块</span>
                        <span class="token punctuation">]</span><span class="token punctuation">,</span>
                        plugins<span class="token punctuation">:</span> <span class="token punctuation">[</span>
                            <span class="token string">'@babel/plugin-proposal-class-properties'</span> <span class="token comment">// 支持类(class)的写法</span>
                        <span class="token punctuation">]</span>
                    <span class="token punctuation">}</span>
                <span class="token punctuation">}</span><span class="token punctuation">,</span>
            <span class="token punctuation">]</span>
        <span class="token punctuation">}</span>
    <span class="token punctuation">]</span>
<span class="token punctuation">}</span>
</code></pre> 
<h3><a id="____54"></a>支持 装饰器写法 @ …</h3> 
<ol><li>安装<br> <code>yarn add @babel/plugin-proposal-decorators -D</code></li><li>使用</li></ol> 
<pre><code class="prism language-js"><span class="token comment">// module.rules[0]</span>
<span class="token punctuation">{<!-- --></span>
    test<span class="token punctuation">:</span> <span class="token regex">/\.js$/</span><span class="token punctuation">,</span>
    use<span class="token punctuation">:</span> <span class="token punctuation">{<!-- --></span>
        loader<span class="token punctuation">:</span> <span class="token string">'babel-loader'</span><span class="token punctuation">,</span>
        options<span class="token punctuation">:</span> <span class="token punctuation">{<!-- --></span> <span class="token comment">// 用 babel-loader 需要把 es6 -&gt; es5</span>
            presets<span class="token punctuation">:</span> <span class="token punctuation">[</span>
                <span class="token string">'@babel/preset-env'</span> <span class="token comment">// 这里面就是把es6 -&gt; es5的模块</span>
            <span class="token punctuation">]</span><span class="token punctuation">,</span>
            plugins<span class="token punctuation">:</span> <span class="token punctuation">[</span>
                <span class="token punctuation">[</span>
                    <span class="token string">'@babel/plugin-proposal-decorators'</span><span class="token punctuation">,</span>
                    <span class="token punctuation">{<!-- --></span> <span class="token string">'legacy'</span><span class="token punctuation">:</span> <span class="token boolean">true</span> <span class="token punctuation">}</span>
                <span class="token punctuation">]</span><span class="token punctuation">,</span>
                <span class="token punctuation">[</span>   <span class="token comment">// 支持类(class)的写法</span>
                    <span class="token string">'@babel/plugin-proposal-class-properties'</span><span class="token punctuation">,</span>
                    <span class="token punctuation">{<!-- --></span> <span class="token string">'loose'</span><span class="token punctuation">:</span> <span class="token boolean">true</span> <span class="token punctuation">}</span> <span class="token comment">// 宽松模式</span>
                <span class="token punctuation">]</span>
            <span class="token punctuation">]</span>
        <span class="token punctuation">}</span>
    <span class="token punctuation">}</span><span class="token punctuation">,</span>
<span class="token punctuation">}</span>
</code></pre> 
<h3><a id="babelplugintransformruntime_83"></a>@babel/plugin-transform-runtime</h3> 
<ol><li> <p>安装<br> <code>yarn add @babel/plugin-transform-runtime -D</code> // 运行时开发依赖<br> <code>yarn add @babel/runtime</code> // 生产环境依赖</p> </li><li> <p>使用</p> </li></ol> 
<pre><code class="prism language-js"><span class="token comment">// module.rules[0]</span>
<span class="token punctuation">{<!-- --></span>
    test<span class="token punctuation">:</span> <span class="token regex">/\.js$/</span><span class="token punctuation">,</span>
    use<span class="token punctuation">:</span> <span class="token punctuation">{<!-- --></span>
        loader<span class="token punctuation">:</span> <span class="token string">'babel-loader'</span><span class="token punctuation">,</span>
        options<span class="token punctuation">:</span> <span class="token punctuation">{<!-- --></span> <span class="token comment">// 用 babel-loader 需要把 es6 -&gt; es5</span>
            presets<span class="token punctuation">:</span> <span class="token punctuation">[</span>
                <span class="token string">'@babel/preset-env'</span> <span class="token comment">// 这里面就是把es6 -&gt; es5的模块</span>
            <span class="token punctuation">]</span><span class="token punctuation">,</span>
            plugins<span class="token punctuation">:</span> <span class="token punctuation">[</span>
                <span class="token punctuation">[</span><span class="token string">'@babel/plugin-proposal-decorators'</span><span class="token punctuation">,</span><span class="token punctuation">{<!-- --></span> <span class="token string">'legacy'</span><span class="token punctuation">:</span> <span class="token boolean">true</span> <span class="token punctuation">}</span><span class="token punctuation">]</span><span class="token punctuation">,</span>
                <span class="token punctuation">[</span><span class="token string">'@babel/plugin-proposal-class-properties'</span><span class="token punctuation">,</span><span class="token punctuation">{<!-- --></span><span class="token string">'loose'</span><span class="token punctuation">:</span> <span class="token boolean">true</span> <span class="token punctuation">}</span> <span class="token punctuation">]</span><span class="token punctuation">,</span>
                <span class="token string">'@babel/plugin-transform-runtime'</span>
            <span class="token punctuation">]</span>
        <span class="token punctuation">}</span>
    <span class="token punctuation">}</span><span class="token punctuation">,</span>
    include<span class="token punctuation">:</span> path<span class="token punctuation">.</span><span class="token function">resolve</span><span class="token punctuation">(</span>__dirname<span class="token punctuation">,</span> <span class="token string">'src'</span><span class="token punctuation">)</span><span class="token punctuation">,</span> <span class="token comment">// 只作用于src下的文件</span>
    exclude<span class="token punctuation">:</span> <span class="token regex">/node_modules/</span><span class="token punctuation">,</span> <span class="token comment">// 不作用的文件夹</span>
<span class="token punctuation">}</span><span class="token punctuation">,</span>
</code></pre> 
<h3><a id="es7__111"></a>es7 语法</h3> 
<ol><li>安装<br> <code>yarn add @babel/polyfill</code></li><li>在入口js文件中<code>index.js</code>使用</li></ol> 
<pre><code class="prism language-js"><span class="token function">require</span><span class="token punctuation">(</span><span class="token string">'@babel/polyfill'</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
<span class="token string">'aaa'</span><span class="token punctuation">.</span><span class="token function">includes</span><span class="token punctuation">(</span><span class="token string">'a'</span><span class="token punctuation">)</span><span class="token punctuation">;</span> <span class="token comment">// ok </span>
<span class="token comment">// 其实底层是直接重新实现了includes方法</span>
</code></pre> 
<h3><a id="_eslint_121"></a>校验器 eslint</h3> 
<ol><li>安装<br> <code>yarn add eslint eslint-loader -D</code></li><li>生成 校验器文件</li></ol> 
<ul><li> 
  <ol><li>打开<code>https://eslint.org/demo/</code></li></ol> </li><li> 
  <ol start="2"><li>选择使用环境、语法、ECMA版本、模块…</li></ol> </li><li> 
  <ol start="3"><li>下载 <code>.eslintrc.json</code> 文件</li></ol> </li><li> 
  <ol start="4"><li>拖到<code>webpack.config.js</code>同级目录下</li></ol> </li></ul> 
<blockquote> 
 <p>注意，文件名须为<code>.eslintrc.json</code>，需要加上一个<code>.</code></p> 
</blockquote> 
<ol start="3"><li>配置 <code>webpack.config.js</code>文件</li></ol> 
<pre><code class="prism language-js">
<span class="token comment">// module.rules[0]</span>
<span class="token punctuation">{<!-- --></span>
    test<span class="token punctuation">:</span> <span class="token regex">/\.js$/</span><span class="token punctuation">,</span>
    use<span class="token punctuation">:</span> <span class="token punctuation">{<!-- --></span>
        loader<span class="token punctuation">:</span> <span class="token string">'eslint-loader'</span><span class="token punctuation">,</span>
        options<span class="token punctuation">:</span> <span class="token punctuation">{<!-- --></span>
            enforce<span class="token punctuation">:</span> <span class="token string">'pre'</span><span class="token punctuation">,</span> <span class="token comment">// 强制这个loader最先执行</span>
        <span class="token punctuation">}</span>
    <span class="token punctuation">}</span>
<span class="token punctuation">}</span><span class="token punctuation">,</span>
</code></pre> 
<blockquote> 
 <ol><li>loader的类型</li></ol> 
 <ul><li>pre 前面执行的loader</li><li>normal 普通的loader</li><li>内联loader</li><li>post 后面执行的loader</li></ul> 
</blockquote> 
<h3><a id="_150"></a>最终代码</h3> 
<pre><code class="prism language-js"><span class="token comment">// webpack 是node 写出来的 node的写法来运行</span>

<span class="token keyword">let</span> path <span class="token operator">=</span> <span class="token function">require</span><span class="token punctuation">(</span><span class="token string">'path'</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
<span class="token keyword">let</span> HtmlWebpackPlugin <span class="token operator">=</span> <span class="token function">require</span><span class="token punctuation">(</span><span class="token string">'html-webpack-plugin'</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
<span class="token keyword">let</span> MiniCssExtractPlugin <span class="token operator">=</span> <span class="token function">require</span><span class="token punctuation">(</span><span class="token string">'mini-css-extract-plugin'</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
<span class="token keyword">let</span> OptimizeCssAssetsWebpackPlugin <span class="token operator">=</span> <span class="token function">require</span><span class="token punctuation">(</span><span class="token string">'optimize-css-assets-webpack-plugin'</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
<span class="token keyword">let</span> UglifyjsWbpackPlugin <span class="token operator">=</span> <span class="token function">require</span><span class="token punctuation">(</span><span class="token string">'uglifyjs-webpack-plugin'</span><span class="token punctuation">)</span><span class="token punctuation">;</span>

module<span class="token punctuation">.</span>exports <span class="token operator">=</span> <span class="token punctuation">{<!-- --></span>
    optimization<span class="token punctuation">:</span> <span class="token punctuation">{<!-- --></span> <span class="token comment">// 优化项</span>
        minimizer<span class="token punctuation">:</span> <span class="token punctuation">[</span>
            <span class="token keyword">new</span> <span class="token class-name">UglifyjsWbpackPlugin</span><span class="token punctuation">(</span><span class="token punctuation">{<!-- --></span>
                cache<span class="token punctuation">:</span> <span class="token boolean">true</span><span class="token punctuation">,</span> <span class="token comment">// 是否用缓存</span>
                parallel<span class="token punctuation">:</span> <span class="token boolean">true</span><span class="token punctuation">,</span> <span class="token comment">// 是否并发打包</span>
                sourceMap<span class="token punctuation">:</span> <span class="token boolean">true</span> <span class="token comment">// es6 -&gt; es5 源码映射 方便调试</span>
            <span class="token punctuation">}</span><span class="token punctuation">)</span><span class="token punctuation">,</span>
            <span class="token keyword">new</span> <span class="token class-name">OptimizeCssAssetsWebpackPlugin</span><span class="token punctuation">(</span><span class="token punctuation">)</span>
        <span class="token punctuation">]</span>
    <span class="token punctuation">}</span><span class="token punctuation">,</span>
    mode<span class="token punctuation">:</span> <span class="token string">'development'</span><span class="token punctuation">,</span> <span class="token comment">// 模式 默认两种 production(会压缩js文件) development</span>
    entry<span class="token punctuation">:</span> <span class="token string">'./src/index.js'</span><span class="token punctuation">,</span> <span class="token comment">//入口</span>
    output<span class="token punctuation">:</span> <span class="token punctuation">{<!-- --></span> <span class="token comment">// 出口</span>
        filename<span class="token punctuation">:</span> <span class="token string">'bundle.js'</span><span class="token punctuation">,</span> <span class="token comment">// 打包后的文件名 [hash:8] 只显示8位的hash文件</span>
        path<span class="token punctuation">:</span> path<span class="token punctuation">.</span><span class="token function">resolve</span><span class="token punctuation">(</span>__dirname<span class="token punctuation">,</span> <span class="token string">'build'</span><span class="token punctuation">)</span> <span class="token comment">// 路径必须是一个绝对路径</span>
    <span class="token punctuation">}</span><span class="token punctuation">,</span>
    plugins<span class="token punctuation">:</span> <span class="token punctuation">[</span> <span class="token comment">// 数组 放着所有的webpack插件</span>
        <span class="token keyword">new</span> <span class="token class-name">HtmlWebpackPlugin</span><span class="token punctuation">(</span><span class="token punctuation">{<!-- --></span>
            template<span class="token punctuation">:</span> <span class="token string">'./src/index.html'</span><span class="token punctuation">,</span> <span class="token comment">// 打包的模板路径</span>
            filename<span class="token punctuation">:</span> <span class="token string">'index.html'</span><span class="token punctuation">,</span> <span class="token comment">// 打包之后的文件名</span>
        <span class="token punctuation">}</span><span class="token punctuation">)</span><span class="token punctuation">,</span>
        <span class="token keyword">new</span> <span class="token class-name">MiniCssExtractPlugin</span><span class="token punctuation">(</span><span class="token punctuation">{<!-- --></span>
            filename<span class="token punctuation">:</span> <span class="token string">'main.css'</span><span class="token punctuation">,</span> <span class="token comment">// 抽离的文件名</span>
        <span class="token punctuation">}</span><span class="token punctuation">)</span>
    <span class="token punctuation">]</span><span class="token punctuation">,</span>
    module<span class="token punctuation">:</span> <span class="token punctuation">{<!-- --></span> <span class="token comment">// 模块</span>
        rules<span class="token punctuation">:</span> <span class="token punctuation">[</span>
            <span class="token punctuation">{<!-- --></span>
                test<span class="token punctuation">:</span> <span class="token regex">/\.js$/</span><span class="token punctuation">,</span>
                use<span class="token punctuation">:</span> <span class="token punctuation">{<!-- --></span>
                    loader<span class="token punctuation">:</span> <span class="token string">'eslint-loader'</span><span class="token punctuation">,</span>
                    options<span class="token punctuation">:</span> <span class="token punctuation">{<!-- --></span>
                        enforce<span class="token punctuation">:</span> <span class="token string">'pre'</span><span class="token punctuation">,</span> <span class="token comment">// 强制这个loader最先执行</span>
                    <span class="token punctuation">}</span>
                <span class="token punctuation">}</span>
            <span class="token punctuation">}</span><span class="token punctuation">,</span>
            <span class="token punctuation">{<!-- --></span>
                test<span class="token punctuation">:</span> <span class="token regex">/\.js$/</span><span class="token punctuation">,</span>
                use<span class="token punctuation">:</span> <span class="token punctuation">{<!-- --></span>
                    loader<span class="token punctuation">:</span> <span class="token string">'babel-loader'</span><span class="token punctuation">,</span>
                    options<span class="token punctuation">:</span> <span class="token punctuation">{<!-- --></span> <span class="token comment">// 用 babel-loader 需要把 es6 -&gt; es5</span>
                        presets<span class="token punctuation">:</span> <span class="token punctuation">[</span>
                            <span class="token string">'@babel/preset-env'</span> <span class="token comment">// 这里面就是把es6 -&gt; es5的模块</span>
                        <span class="token punctuation">]</span><span class="token punctuation">,</span>
                        plugins<span class="token punctuation">:</span> <span class="token punctuation">[</span>
                            <span class="token punctuation">[</span>
                                <span class="token string">'@babel/plugin-proposal-decorators'</span><span class="token punctuation">,</span>
                                <span class="token punctuation">{<!-- --></span> <span class="token string">'legacy'</span><span class="token punctuation">:</span> <span class="token boolean">true</span> <span class="token punctuation">}</span>
                            <span class="token punctuation">]</span><span class="token punctuation">,</span>
                            <span class="token punctuation">[</span>   <span class="token comment">// 支持类(class)的写法</span>
                                <span class="token string">'@babel/plugin-proposal-class-properties'</span><span class="token punctuation">,</span>
                                <span class="token punctuation">{<!-- --></span> <span class="token string">'loose'</span><span class="token punctuation">:</span> <span class="token boolean">true</span> <span class="token punctuation">}</span> <span class="token comment">// 宽松模式</span>
                            <span class="token punctuation">]</span><span class="token punctuation">,</span>
                            <span class="token string">'@babel/plugin-transform-runtime'</span>
                        <span class="token punctuation">]</span>
                    <span class="token punctuation">}</span>
                <span class="token punctuation">}</span><span class="token punctuation">,</span>
                include<span class="token punctuation">:</span> path<span class="token punctuation">.</span><span class="token function">resolve</span><span class="token punctuation">(</span>__dirname<span class="token punctuation">,</span> <span class="token string">'src'</span><span class="token punctuation">)</span><span class="token punctuation">,</span>
                exclude<span class="token punctuation">:</span> <span class="token regex">/node_modules/</span><span class="token punctuation">,</span>
            <span class="token punctuation">}</span><span class="token punctuation">,</span>
            <span class="token punctuation">{<!-- --></span>
                test<span class="token punctuation">:</span> <span class="token regex">/\.css$/</span><span class="token punctuation">,</span>
                use<span class="token punctuation">:</span> <span class="token punctuation">[</span>
                    MiniCssExtractPlugin<span class="token punctuation">.</span>loader<span class="token punctuation">,</span> <span class="token comment">// 将解析完的css代码生成文件，然后以link标签的方式插入到html文档中</span>
                    <span class="token string">'css-loader'</span><span class="token punctuation">,</span>
                    <span class="token punctuation">{<!-- --></span>
                        loader<span class="token punctuation">:</span> <span class="token string">'postcss-loader'</span><span class="token punctuation">,</span>
                        options<span class="token punctuation">:</span> <span class="token punctuation">{<!-- --></span>
                            plugins<span class="token punctuation">:</span> <span class="token punctuation">[</span>
                                <span class="token function">require</span><span class="token punctuation">(</span><span class="token string">"autoprefixer"</span><span class="token punctuation">)</span> <span class="token comment">/*在这里添加*/</span>
                            <span class="token punctuation">]</span>
                        <span class="token punctuation">}</span>
                    <span class="token punctuation">}</span>

                <span class="token punctuation">]</span>
            <span class="token punctuation">}</span><span class="token punctuation">,</span>
            <span class="token punctuation">{<!-- --></span>
                test<span class="token punctuation">:</span> <span class="token regex">/\.less$/</span><span class="token punctuation">,</span>
                use<span class="token punctuation">:</span> <span class="token punctuation">[</span>
                    MiniCssExtractPlugin<span class="token punctuation">.</span>loader<span class="token punctuation">,</span> <span class="token comment">// 将解析完的css代码生成文件，然后以link标签的方式插入到html文档中</span>
                    <span class="token string">'css-loader'</span><span class="token punctuation">,</span>
                    <span class="token punctuation">{<!-- --></span>
                        loader<span class="token punctuation">:</span> <span class="token string">'postcss-loader'</span><span class="token punctuation">,</span>
                        options<span class="token punctuation">:</span> <span class="token punctuation">{<!-- --></span>
                            plugins<span class="token punctuation">:</span> <span class="token punctuation">[</span>
                                <span class="token function">require</span><span class="token punctuation">(</span><span class="token string">"autoprefixer"</span><span class="token punctuation">)</span> <span class="token comment">/*在这里添加*/</span>
                            <span class="token punctuation">]</span>
                        <span class="token punctuation">}</span>
                    <span class="token punctuation">}</span><span class="token punctuation">,</span>
                    <span class="token string">'less-loader'</span>
                <span class="token punctuation">]</span>
            <span class="token punctuation">}</span>
        <span class="token punctuation">]</span>
    <span class="token punctuation">}</span>
<span class="token punctuation">}</span>
</code></pre>
                
{% endraw %}
