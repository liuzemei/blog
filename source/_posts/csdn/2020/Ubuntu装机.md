---
title: Ubuntu装机
date: 2020-08-02 07:11:44
layout: post
author: 刘泽美
categories:
  - CSDN文章
  - 导入
tags: 代码人生
---

[原链接](https://blog.csdn.net/weixin_41884153/article/details/107739947)
{% raw %}

                    <svg xmlns="http://www.w3.org/2000/svg" style="display: none;">
                        <path stroke-linecap="round" d="M5,0 0,2.5 5,5z" id="raphael-marker-block" style="-webkit-tap-highlight-color: rgba(0, 0, 0, 0);"></path>
                    </svg>
                    <h2><a id="1_git_node_0"></a>1. git node</h2> 
<h3><a id="11_git__1"></a>1.1 git 安装</h3> 
<pre><code class="prism language-shell"><span class="token function">sudo</span> <span class="token function">apt-get</span> <span class="token function">install</span> <span class="token function">git</span>
<span class="token function">git</span> -v
</code></pre> 
<h3><a id="12_node__7"></a>1.2 node 安装</h3> 
<pre><code class="prism language-shell"><span class="token function">sudo</span> apt <span class="token function">install</span> <span class="token function">curl</span> <span class="token comment"># 安装 curl</span>
<span class="token function">curl</span> -sL https://deb.nodesource.com/setup_14.x <span class="token operator">|</span> <span class="token function">sudo</span> -E <span class="token function">bash</span> - <span class="token comment"># 更新最新版14.x的源文件</span>

<span class="token comment"># 更新 阿里源</span>
deb http://mirrors.aliyun.com/ubuntu/ bionic main restricted universe multiverse
deb http://mirrors.aliyun.com/ubuntu/ bionic-security main restricted universe multiverse
deb http://mirrors.aliyun.com/ubuntu/ bionic-updates main restricted universe multiverse
deb http://mirrors.aliyun.com/ubuntu/ bionic-proposed main restricted universe multiverse
deb http://mirrors.aliyun.com/ubuntu/ bionic-backports main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ bionic main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ bionic-security main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ bionic-updates main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ bionic-proposed main restricted universe multiverse
<span class="token function">cd</span> /etc/apt/
<span class="token function">cp</span> sources.list sources.list.bak
<span class="token function">sudo</span> <span class="token function">cp</span> sources.list sources.list.bak
<span class="token function">sudo</span> <span class="token boolean">true</span> <span class="token operator">&gt;</span> sources.list
<span class="token function">sudo</span> apt update

<span class="token comment"># 安装 nodejs</span>
<span class="token function">sudo</span> <span class="token function">apt-get</span> <span class="token function">install</span> -y nodejs
node -v
<span class="token function">npm</span> -v
</code></pre> 
<h3><a id="13_python3__35"></a>1.3 python3 安装</h3> 
<pre><code class="prism language-shell"><span class="token comment"># 安装 python3</span>
<span class="token function">sudo</span> <span class="token function">apt-get</span> <span class="token function">install</span> python3.4

<span class="token comment"># 将 python 软链到 python3</span>
<span class="token function">whereis</span> python3
<span class="token function">cd</span> /usr/bin/
<span class="token function">sudo</span> <span class="token function">cp</span> python3 python

<span class="token comment"># 安装 pip3</span>
<span class="token function">sudo</span> <span class="token function">apt-get</span> <span class="token function">install</span> python3-pip

</code></pre> 
<h3><a id="14_mongodb_50"></a>1.4 mongodb安装</h3> 
<pre><code class="prism language-shell"><span class="token function">sudo</span> <span class="token function">apt-get</span> update
<span class="token function">sudo</span> <span class="token function">apt-get</span> <span class="token function">install</span> mongodb
mongo --version
</code></pre> 
<h3><a id="15_postgresql__57"></a>1.5 postgresql 安装</h3> 
<pre><code class="prism language-shell"><span class="token function">sudo</span> <span class="token function">apt-get</span> update
<span class="token function">sudo</span> <span class="token function">apt-get</span> <span class="token function">install</span> postgresql-12 -y
psql --version

<span class="token comment"># 简单配置</span>
<span class="token function">sudo</span> -u postgres psql <span class="token comment"># 进入</span>
ALTER USER postgres WITH PASSWORD <span class="token string">'postgres'</span><span class="token punctuation">;</span> 
CREATE USER <span class="token string">"neo"</span> with password <span class="token string">'1234'</span><span class="token punctuation">;</span>
CREATE DATABASE <span class="token string">"neo"</span> with owner <span class="token operator">=</span> <span class="token string">"neo"</span><span class="token punctuation">;</span>
</code></pre> 
<h2><a id="2__wine_71"></a>2. 安装 wine</h2> 
<p>wine 可以直接用来安装 windows 环境下的安装包，安装后可以直接在 Linux 下跑 windows 的软件。</p> 
<pre><code class="prism language-shell"><span class="token comment"># 1. 安装 wine</span>
<span class="token function">sudo</span> dpkg --add-architecture i386
<span class="token function">sudo</span> apt update
<span class="token function">sudo</span> apt <span class="token function">install</span> wine-stable

<span class="token comment"># 2. 安装 winetricks 修复不能输入的问题</span>
<span class="token function">sudo</span> apt <span class="token function">install</span> winetricks
winetricks riched20

<span class="token comment"># 2. 安装 exe</span>
<span class="token comment"># 首先得去官网下载 安装文件 WeChatSetup.exe</span>
wine WeChatSetup.ext
<span class="token comment"># ...</span>
</code></pre>
                
{% endraw %}
