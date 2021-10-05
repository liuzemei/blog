---
title: webpack从入门到精通----（二）热重载及html插件
date: 2019-09-25 15:32:36
layout: post
author: 刘泽美
categories:
  - CSDN文章
  - 导入
tags: 代码人生
---

[原链接](https://blog.csdn.net/weixin_41884153/article/details/101368267)
{% raw %}

                    <svg xmlns="http://www.w3.org/2000/svg" style="display: none;">
                        <path stroke-linecap="round" d="M5,0 0,2.5 5,5z" id="raphael-marker-block" style="-webkit-tap-highlight-color: rgba(0, 0, 0, 0);"></path>
                    </svg>
                    <h2><a id="_1"></a>第三课</h2> 
<h3><a id="webpackdevserver_2"></a>webpack-dev-server</h3> 
<ol><li>安装<br> <code>yarn add webpack-dev-server -D</code></li><li>启动<br> <code>npx webpack-dev-server</code></li><li>配置 webpack</li></ol> 
<pre><code class="prism language-js">module<span class="token punctuation">.</span>exports <span class="token operator">=</span> <span class="token punctuation">{<!-- --></span>
    devServer<span class="token punctuation">:</span> <span class="token punctuation">{<!-- --></span> <span class="token comment">// 开发服务器的配置</span>
        port<span class="token punctuation">:</span> <span class="token number">3000</span><span class="token punctuation">,</span> <span class="token comment">// 启动端口</span>
        progress<span class="token punctuation">:</span> <span class="token boolean">true</span><span class="token punctuation">,</span> <span class="token comment">// 滚动条</span>
        contentBase<span class="token punctuation">:</span> <span class="token string">'./build'</span><span class="token punctuation">,</span> <span class="token comment">// 启动服务的路径</span>
        compress<span class="token punctuation">:</span> <span class="token boolean">true</span><span class="token punctuation">,</span> <span class="token comment">//压缩</span>
    <span class="token punctuation">}</span><span class="token punctuation">,</span>
    entry<span class="token punctuation">:</span> <span class="token string">'./src/index.js'</span><span class="token punctuation">,</span> <span class="token comment">//入口</span>
    <span class="token operator">...</span>
<span class="token punctuation">}</span>
</code></pre> 
<ol start="4"><li>修改 package.json文件</li></ol> 
<pre><code class="prism language-json"><span class="token string">"script"</span><span class="token punctuation">:</span> <span class="token punctuation">{<!-- --></span>
    <span class="token string">"dev"</span><span class="token punctuation">:</span> <span class="token string">"webpack-dev-server"</span>
<span class="token punctuation">}</span>
</code></pre> 
<h3><a id="webpackplugin_28"></a>webpack-plugin</h3> 
<ol><li>安装插件<br> <code>yarn add html-webpack-plugin -D</code></li><li>在<code>webpack.config.js</code>中引入和使用插件</li></ol> 
<pre><code class="prism language-js"><span class="token keyword">let</span> HtmlWebpackPlugin <span class="token operator">=</span> <span class="token function">require</span><span class="token punctuation">(</span><span class="token string">'html-webpack-plugin'</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
module<span class="token punctuation">.</span>exports <span class="token operator">=</span> <span class="token punctuation">{<!-- --></span>
    <span class="token operator">...</span><span class="token punctuation">,</span>
    plugins<span class="token punctuation">:</span> <span class="token punctuation">[</span> <span class="token comment">// 数组 放着所有的webpack插件</span>
        <span class="token keyword">new</span> <span class="token class-name">HtmlWebpackPlugin</span><span class="token punctuation">(</span><span class="token punctuation">{<!-- --></span>
            template<span class="token punctuation">:</span> <span class="token string">'./src/index.html'</span><span class="token punctuation">,</span> <span class="token comment">// 打包的模板路径</span>
            filename<span class="token punctuation">:</span> <span class="token string">'index.html'</span><span class="token punctuation">,</span> <span class="token comment">// 打包之后的文件名</span>
            minify<span class="token punctuation">:</span> <span class="token punctuation">{<!-- --></span> <span class="token comment">// 格式化html文件</span>
                removeAttributeQuotes<span class="token punctuation">:</span> <span class="token boolean">true</span><span class="token punctuation">,</span> <span class="token comment">// 去除掉双引号</span>
                collapseWhitespace<span class="token punctuation">:</span> <span class="token boolean">true</span> <span class="token comment">// 变成1行</span>
            <span class="token punctuation">}</span><span class="token punctuation">,</span>
            hash<span class="token punctuation">:</span> <span class="token boolean">true</span> <span class="token comment">// 会在 js后面加上 [? + 哈希]</span>
        <span class="token punctuation">}</span><span class="token punctuation">)</span>
    <span class="token punctuation">]</span><span class="token punctuation">,</span>
    output<span class="token punctuation">:</span> <span class="token punctuation">{<!-- --></span>
        <span class="token operator">...</span><span class="token punctuation">,</span>
        filename<span class="token punctuation">:</span> <span class="token string">'index.[hash:8].js'</span> <span class="token comment">// 这个地方也是在名字上加上哈希 后面的:8表示8位</span>
    <span class="token punctuation">}</span>
<span class="token punctuation">}</span>
</code></pre> 
<h3><a id="webpackconfigjs_54"></a>最终webpack.config.js</h3> 
<pre><code class="prism language-js"><span class="token keyword">let</span> path <span class="token operator">=</span> <span class="token function">require</span><span class="token punctuation">(</span><span class="token string">'path'</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
<span class="token keyword">let</span> HtmlWebpackPlugin <span class="token operator">=</span> <span class="token function">require</span><span class="token punctuation">(</span><span class="token string">'html-webpack-plugin'</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
module<span class="token punctuation">.</span>exports <span class="token operator">=</span> <span class="token punctuation">{<!-- --></span>
    devServer<span class="token punctuation">:</span> <span class="token punctuation">{<!-- --></span> <span class="token comment">// 开发服务器的配置</span>
        port<span class="token punctuation">:</span> <span class="token number">3000</span><span class="token punctuation">,</span> <span class="token comment">// 启动端口</span>
        progress<span class="token punctuation">:</span> <span class="token boolean">true</span><span class="token punctuation">,</span> <span class="token comment">// 滚动条</span>
        contentBase<span class="token punctuation">:</span> <span class="token string">'./build'</span><span class="token punctuation">,</span> <span class="token comment">// 启动服务的路径</span>
        compress<span class="token punctuation">:</span> <span class="token boolean">true</span> <span class="token comment">//压缩</span>
    <span class="token punctuation">}</span><span class="token punctuation">,</span>
    mode<span class="token punctuation">:</span> <span class="token string">'development'</span><span class="token punctuation">,</span> <span class="token comment">// 模式 默认两种 production(会压缩js文件) development</span>
    entry<span class="token punctuation">:</span> <span class="token string">'./src/index.js'</span><span class="token punctuation">,</span> <span class="token comment">//入口</span>
    output<span class="token punctuation">:</span> <span class="token punctuation">{<!-- --></span> <span class="token comment">// 出口</span>
        filename<span class="token punctuation">:</span> <span class="token string">'bundle.[hash:8].js'</span><span class="token punctuation">,</span> <span class="token comment">// 打包后的文件名 [hash:8] 只显示8位的hash文件</span>
        path<span class="token punctuation">:</span> path<span class="token punctuation">.</span><span class="token function">resolve</span><span class="token punctuation">(</span>__dirname<span class="token punctuation">,</span> <span class="token string">'build'</span><span class="token punctuation">)</span> <span class="token comment">// 路径必须是一个绝对路径</span>
    <span class="token punctuation">}</span><span class="token punctuation">,</span>
    plugins<span class="token punctuation">:</span> <span class="token punctuation">[</span> <span class="token comment">// 数组 放着所有的webpack插件</span>
        <span class="token keyword">new</span> <span class="token class-name">HtmlWebpackPlugin</span><span class="token punctuation">(</span><span class="token punctuation">{<!-- --></span>
            template<span class="token punctuation">:</span> <span class="token string">'./src/index.html'</span><span class="token punctuation">,</span> <span class="token comment">// 打包的模板路径</span>
            filename<span class="token punctuation">:</span> <span class="token string">'index.html'</span><span class="token punctuation">,</span> <span class="token comment">// 打包之后的文件名</span>
            minify<span class="token punctuation">:</span> <span class="token punctuation">{<!-- --></span>
                removeAttributeQuotes<span class="token punctuation">:</span> <span class="token boolean">true</span><span class="token punctuation">,</span>
                collapseWhitespace<span class="token punctuation">:</span> <span class="token boolean">true</span>
            <span class="token punctuation">}</span><span class="token punctuation">,</span>
            hash<span class="token punctuation">:</span> <span class="token boolean">true</span>
        <span class="token punctuation">}</span><span class="token punctuation">)</span>
    <span class="token punctuation">]</span>
<span class="token punctuation">}</span>
</code></pre>
                
{% endraw %}
