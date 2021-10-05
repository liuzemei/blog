---
title: webpack从入门到精通----（四）css\js打包及格式化插件
date: 2019-09-25 15:34:37
layout: post
author: 刘泽美
categories:
  - CSDN文章
  - 导入
tags: 代码人生
---

[原链接](https://blog.csdn.net/weixin_41884153/article/details/101368402)
{% raw %}

                    <svg xmlns="http://www.w3.org/2000/svg" style="display: none;">
                        <path stroke-linecap="round" d="M5,0 0,2.5 5,5z" id="raphael-marker-block" style="-webkit-tap-highlight-color: rgba(0, 0, 0, 0);"></path>
                    </svg>
                    <h3><a id="css__link__1"></a>将css 代码以 link标签方式 引入</h3> 
<ol><li>安装插件<br> <code>yarn add mini-css-extract-plugin -D</code></li></ol> 
<blockquote> 
 <p>专门抽离 css 样式文件的插件</p> 
</blockquote> 
<ol start="2"><li>在 webpack.config.js 文件中使用</li></ol> 
<pre><code class="prism language-js"><span class="token keyword">let</span> MiniCssExtractPlugin <span class="token operator">=</span> <span class="token function">require</span><span class="token punctuation">(</span><span class="token string">'mini-css-extract-plugin'</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
module<span class="token punctuation">.</span>exports <span class="token operator">=</span> <span class="token punctuation">{<!-- --></span>
    <span class="token operator">...</span><span class="token punctuation">,</span>
    plugins<span class="token punctuation">:</span> <span class="token punctuation">[</span>
        <span class="token keyword">new</span> <span class="token class-name">MiniCssExtractPlugin</span><span class="token punctuation">(</span><span class="token punctuation">{<!-- --></span>
            filename<span class="token punctuation">:</span> <span class="token string">'main.css'</span> <span class="token comment">// 打包之后的css文件名</span>
        <span class="token punctuation">}</span><span class="token punctuation">)</span>
    <span class="token punctuation">]</span><span class="token punctuation">,</span>
    module<span class="token punctuation">:</span> <span class="token punctuation">{<!-- --></span>
        rules<span class="token punctuation">:</span> <span class="token punctuation">[</span>
            <span class="token punctuation">{<!-- --></span>
                test<span class="token punctuation">:</span> <span class="token string">'/\.css$/'</span><span class="token punctuation">,</span>
                use<span class="token punctuation">:</span> <span class="token punctuation">[</span>
                    MiniCssExtractPlugin<span class="token punctuation">.</span>loader<span class="token punctuation">,</span><span class="token comment">// 将解析完的css代码生成文件，然后以link标签的方式插入到html文档中</span>
                    <span class="token string">'css-loader'</span>
                <span class="token punctuation">]</span>
            <span class="token punctuation">}</span><span class="token punctuation">,</span>
            <span class="token punctuation">{<!-- --></span>
                test<span class="token punctuation">:</span> <span class="token string">'/\.less$/'</span><span class="token punctuation">,</span>
                use<span class="token punctuation">:</span> <span class="token punctuation">[</span>
                    MiniCssExtractPlugin<span class="token punctuation">.</span>loader<span class="token punctuation">,</span><span class="token comment">// 将解析完的css代码生成文件，然后以link标签的方式插入到html文档中</span>
                    <span class="token string">'css-loader'</span><span class="token punctuation">,</span> 
                    <span class="token string">'less-loader'</span>
                <span class="token punctuation">]</span>
            <span class="token punctuation">}</span>
        <span class="token punctuation">]</span>
    <span class="token punctuation">}</span>
<span class="token punctuation">}</span>
</code></pre> 
<h3><a id="_css___36"></a>自动在 css 中 加上各个浏览器的适配前缀</h3> 
<ol><li>安装插件 和 loader<br> <code>yarn add postcss-loader autoprefixer -D</code></li><li>配置 postcss-loader</li></ol> 
<blockquote> 
 <p>在<code>webpack.config.js</code>同级创建文件<code>postcss.config.js</code></p> 
</blockquote> 
<pre><code class="prism language-js">module<span class="token punctuation">.</span>exports <span class="token operator">=</span> <span class="token punctuation">{<!-- --></span>
    plugins<span class="token punctuation">:</span> <span class="token punctuation">[</span><span class="token function">require</span><span class="token punctuation">(</span><span class="token string">'autoprefixer'</span><span class="token punctuation">)</span><span class="token punctuation">]</span>
<span class="token punctuation">}</span>
</code></pre> 
<ol start="3"><li>在 webpack.config.js 文件中使用</li></ol> 
<pre><code class="prism language-js">module<span class="token punctuation">:</span> <span class="token punctuation">{<!-- --></span>
    rules<span class="token punctuation">:</span> <span class="token punctuation">[</span>
        <span class="token punctuation">{<!-- --></span>
            test<span class="token punctuation">:</span> <span class="token string">'/\.css$/'</span><span class="token punctuation">,</span>
            use<span class="token punctuation">:</span> <span class="token punctuation">[</span>
                MiniCssExtractPlugin<span class="token punctuation">.</span>loader<span class="token punctuation">,</span><span class="token comment">// 将解析完的css代码生成文件，然后以link标签的方式插入到html文档中</span>
                <span class="token string">'css-loader'</span><span class="token punctuation">,</span>
                <span class="token string">'postcss-loader'</span>
            <span class="token punctuation">]</span>
        <span class="token punctuation">}</span><span class="token punctuation">,</span>
        <span class="token punctuation">{<!-- --></span>
            test<span class="token punctuation">:</span> <span class="token string">'/\.less$/'</span><span class="token punctuation">,</span>
            use<span class="token punctuation">:</span> <span class="token punctuation">[</span>
                MiniCssExtractPlugin<span class="token punctuation">.</span>loader<span class="token punctuation">,</span><span class="token comment">// 将解析完的css代码生成文件，然后以link标签的方式插入到html文档中</span>
                <span class="token string">'css-loader'</span><span class="token punctuation">,</span>
                <span class="token string">'postcss-loader'</span><span class="token punctuation">,</span>
                <span class="token string">'less-loader'</span>
            <span class="token punctuation">]</span>
        <span class="token punctuation">}</span>
    <span class="token punctuation">]</span>
<span class="token punctuation">}</span>
</code></pre> 
<blockquote> 
 <p>跟随着教程走，结果还是没有出现预期的结果，并没有出现自动加上浏览器适配前缀。</p> 
</blockquote> 
<h3><a id="_css__72"></a>格式化打包后的 css 文件</h3> 
<ol><li>安装插件<br> <code>yarn add optimize-css-assets-webpack-plugin -D</code></li><li>配置 webpack.config.js</li></ol> 
<pre><code class="prism language-js"><span class="token keyword">let</span> OptimizeCssAssetsWebpackPlugin <span class="token operator">=</span> <span class="token function">require</span><span class="token punctuation">(</span><span class="token string">'optimize-css-assets-webpack-plugin'</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
module<span class="token punctuation">.</span>exports <span class="token operator">=</span> <span class="token punctuation">{<!-- --></span>
    optimization<span class="token punctuation">:</span> <span class="token punctuation">{<!-- --></span> <span class="token comment">// 优化项</span>
        minimizer<span class="token punctuation">:</span> <span class="token punctuation">[</span>
            <span class="token keyword">new</span> <span class="token class-name">OptimizeCssAssetsWebpackPlugin</span><span class="token punctuation">(</span><span class="token punctuation">)</span>
        <span class="token punctuation">]</span>
    <span class="token punctuation">}</span><span class="token punctuation">,</span>
    <span class="token operator">...</span>
<span class="token punctuation">}</span>
</code></pre> 
<blockquote> 
 <ul><li>发现 css 压缩了，但是 js 文件并没有被压缩</li><li>所以使用了 <code>optimize-css-assets-webpack-plugin</code> 之后，还得使用<code>uglifyjs-webpack-plugin</code> 来格式化压缩 js 文件</li></ul> 
</blockquote> 
<h3><a id="_js__90"></a>格式化打包后的 js 文件</h3> 
<ol><li>安装插件<br> <code>yarn add uglifyjs-webpack-plugin -D</code></li><li>使用插件(webpack.config.js)</li></ol> 
<pre><code class="prism language-js">optimization<span class="token punctuation">:</span> <span class="token punctuation">{<!-- --></span> <span class="token comment">// 优化项</span>
    minimizer<span class="token punctuation">:</span> <span class="token punctuation">[</span>
        <span class="token keyword">new</span> <span class="token class-name">UglifyjsWbpackPlugin</span><span class="token punctuation">(</span><span class="token punctuation">{<!-- --></span>
            cache<span class="token punctuation">:</span> <span class="token boolean">true</span><span class="token punctuation">,</span> <span class="token comment">// 是否用缓存</span>
            parallel<span class="token punctuation">:</span> <span class="token boolean">true</span><span class="token punctuation">,</span> <span class="token comment">// 是否并发打包</span>
            sourceMap<span class="token punctuation">:</span> <span class="token boolean">true</span> <span class="token comment">// es6 -&gt; es5 源码映射 方便调试</span>
        <span class="token punctuation">}</span><span class="token punctuation">)</span><span class="token punctuation">,</span>
        <span class="token keyword">new</span> <span class="token class-name">OptimizeCssAssetsWebpackPlugin</span><span class="token punctuation">(</span><span class="token punctuation">)</span>
    <span class="token punctuation">]</span>
<span class="token punctuation">}</span><span class="token punctuation">,</span>
</code></pre> 
<blockquote> 
 <ul><li>注意： 这里再进行build时可能会产生报错，由于js文件还没有额外(babel)的处理，如果想看到效果的话，需要把所有<code>require</code>js的代码都注释掉。</li></ul> 
</blockquote> 
<h3><a id="_108"></a>最终源码：</h3> 
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
    mode<span class="token punctuation">:</span> <span class="token string">'production'</span><span class="token punctuation">,</span> <span class="token comment">// 模式 默认两种 production(会压缩js文件) development</span>
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
