---
title: "it does not contain a package.json file. npm install问题解决"
date: 2018-10-05 19:09:18
layout: post
author: 刘泽美
categories:
  - CSDN文章
  - 导入
tags: 代码人生
---

[原链接](https://blog.csdn.net/weixin_41884153/article/details/82946239)
{% raw %}

                    <svg xmlns="http://www.w3.org/2000/svg" style="display: none;">
                        <path stroke-linecap="round" d="M5,0 0,2.5 5,5z" id="raphael-marker-block" style="-webkit-tap-highlight-color: rgba(0, 0, 0, 0);"></path>
                    </svg>
                    <p>困扰了2个小时终于搞定。</p> 
<p>目的是要安装bignumber.js包</p> 
<p>第一次出现问题：</p> 
<pre class=" language-shell"><code class="prism  language-shell"><span class="token function">npm</span> WARN neo@1.0.0 No repository field.

+ bignumber.js@2.0.7
added 1 package from 1 contributor, updated 1 package and audited 7 packages <span class="token keyword">in</span> 10.393s
found 0 vulnerabilities
</code></pre> 
<p>说明问题主要是使用npm执行安装时，调用repository(库)失败。</p> 
<p>也就是说repository里边可能没有bignumber的文件。</p> 
<p>再次执行：</p> 
<pre class=" language-shell"><code class="prism  language-shell"><span class="token function">npm</span> ERR<span class="token operator">!</span> code ENOLOCAL
<span class="token function">npm</span> ERR<span class="token operator">!</span> Could not <span class="token function">install</span> from <span class="token string">"node_modules/bignumber.js"</span> as it does not contain a package.json file.

<span class="token function">npm</span> ERR<span class="token operator">!</span> A complete log of this run can be found in:
<span class="token function">npm</span> ERR<span class="token operator">!</span>     /Users/neo/.npm/_logs/2018-10-05T09_45_26_493Z-debug.log
</code></pre> 
<p>这次报的错其实就已经很明显了。在package.json指定的库中没有包含这个文件。</p> 
<p>于是，现在的任务主要就是package.json中添加包含这个文件的库。</p> 
<p>直接输入npm命令，会显示npm的简介信息，里面包含npm安装的路径</p> 
<pre class=" language-shell"><code class="prism  language-shell">neo@localhost:~/node_modules/neo$ <span class="token function">npm</span>

Usage: <span class="token function">npm</span> <span class="token operator">&lt;</span>command<span class="token operator">&gt;</span>

where <span class="token operator">&lt;</span>command<span class="token operator">&gt;</span> is one of:
    access, adduser, audit, bin, bugs, c, cache, ci, cit,
    completion, config, create, ddp, dedupe, deprecate,
    dist-tag, docs, doctor, edit, explore, get, help,
    help-search, hook, i, init, install, install-test, it, link,
    list, ln, login, logout, ls, outdated, owner, pack, ping,
    prefix, profile, prune, publish, rb, rebuild, repo, restart,
    root, run, run-script, s, se, search, set, shrinkwrap, star,
    stars, start, stop, t, team, test, token, tst, un,
    uninstall, unpublish, unstar, up, update, v, version, view,
    <span class="token function">whoami</span>

<span class="token function">npm</span> <span class="token operator">&lt;</span>command<span class="token operator">&gt;</span> -h  quick <span class="token function">help</span> on <span class="token operator">&lt;</span>command<span class="token operator">&gt;</span>
<span class="token function">npm</span> -l            display full usage info
<span class="token function">npm</span> <span class="token function">help</span> <span class="token operator">&lt;</span>term<span class="token operator">&gt;</span>   search <span class="token keyword">for</span> <span class="token function">help</span> on <span class="token operator">&lt;</span>term<span class="token operator">&gt;</span>
<span class="token function">npm</span> <span class="token function">help</span> <span class="token function">npm</span>      involved overview

Specify configs <span class="token keyword">in</span> the ini-formatted file:
    /Users/neo/.npmrc
or on the <span class="token function">command</span> line via: <span class="token function">npm</span> <span class="token operator">&lt;</span>command<span class="token operator">&gt;</span> --key value
Config info can be viewed via: <span class="token function">npm</span> <span class="token function">help</span> config

npm@6.4.1 /usr/local/lib/node_modules/npm
</code></pre> 
<p>最后一行就是路径：cd到那个路径下，再cd到npm</p> 
<pre class=" language-shell"><code class="prism  language-shell">$ <span class="token function">cd</span> /usr/local/lib/node_modules
$ <span class="token function">cd</span> npm/
</code></pre> 
<p>里面包含一个package.json，这个文件就是我们要修改的文件。</p> 
<pre class=" language-shell"><code class="prism  language-shell">neo@localhost:/usr/local/lib/node_modules/npm$ <span class="token function">ls</span>
AUTHORS         LICENSE         appveyor.yml    configure       lib             node_modules    scripts
CHANGELOG.md    Makefile        bin             doc             make.bat        npmrc
CONTRIBUTING.md README.md       changelogs      html            <span class="token function">man</span>             package.json
</code></pre> 
<p>然后我们直接启动vi</p> 
<pre class=" language-shell"><code class="prism  language-shell">$ <span class="token function">vi</span> package.json
</code></pre> 
<p>在vi下，输入’/'然后再输入repository，再敲回车，查找到repository的位置</p> 
<pre class=" language-shell"><code class="prism  language-shell">2805   <span class="token string">"repository"</span><span class="token keyword">:</span> <span class="token punctuation">{<!-- --></span>                                                                                                                    
2806     <span class="token string">"type"</span><span class="token keyword">:</span> <span class="token string">"git"</span>,
2807     <span class="token string">"url"</span><span class="token keyword">:</span> <span class="token string">"git+https://github.com/npm/cli.git"</span>
2808   <span class="token punctuation">}</span>,
</code></pre> 
<p>我的是2805行…前面是行号，可以忽略。</p> 
<p>后面的这个url是关键。直接改成<br> <a href="https://github.com/MikeMcl/bignumber.js">https://github.com/MikeMcl/bignumber.js</a></p> 
<p>保存退出，然后再执行</p> 
<pre class=" language-shell"><code class="prism  language-shell">$ <span class="token function">npm</span> <span class="token function">install</span> --save bignumber.js
<span class="token function">npm</span> WARN checkPermissions Missing <span class="token function">write</span> access to /usr/local/lib/node_modules/npm/node_modules
<span class="token function">npm</span> ERR<span class="token operator">!</span> path /usr/local/lib/node_modules/npm/node_modules
<span class="token function">npm</span> ERR<span class="token operator">!</span> code EACCES
<span class="token function">npm</span> ERR<span class="token operator">!</span> errno -13
<span class="token function">npm</span> ERR<span class="token operator">!</span> syscall access
<span class="token function">npm</span> ERR<span class="token operator">!</span> Error: EACCES: permission denied, access <span class="token string">'/usr/local/lib/node_modules/npm/node_modules'</span>
<span class="token function">npm</span> ERR<span class="token operator">!</span>  <span class="token punctuation">{<!-- --></span> Error: EACCES: permission denied, access <span class="token string">'/usr/local/lib/node_modules/npm/node_modules'</span>
<span class="token function">npm</span> ERR<span class="token operator">!</span>   stack: <span class="token string">'Error: EACCES: permission denied, access \'/usr/local/lib/node_modules/npm/node_modules\''</span>,
<span class="token function">npm</span> ERR<span class="token operator">!</span>   errno: -13,
<span class="token function">npm</span> ERR<span class="token operator">!</span>   code: <span class="token string">'EACCES'</span>,
<span class="token function">npm</span> ERR<span class="token operator">!</span>   syscall: <span class="token string">'access'</span>,
<span class="token function">npm</span> ERR<span class="token operator">!</span>   path: <span class="token string">'/usr/local/lib/node_modules/npm/node_modules'</span> <span class="token punctuation">}</span>
<span class="token function">npm</span> ERR<span class="token operator">!</span> 
<span class="token function">npm</span> ERR<span class="token operator">!</span> The operation was rejected by your operating system.
<span class="token function">npm</span> ERR<span class="token operator">!</span> It is likely you <span class="token keyword">do</span> not have the permissions to access this <span class="token function">file</span> as the current user
<span class="token function">npm</span> ERR<span class="token operator">!</span> 
<span class="token function">npm</span> ERR<span class="token operator">!</span> If you believe this might be a permissions issue, please double-check the
<span class="token function">npm</span> ERR<span class="token operator">!</span> permissions of the <span class="token function">file</span> and its containing directories, or try running
<span class="token function">npm</span> ERR<span class="token operator">!</span> the <span class="token function">command</span> again as root/Administrator <span class="token punctuation">(</span>though this is not recommended<span class="token punctuation">)</span>.

<span class="token function">npm</span> ERR<span class="token operator">!</span> A complete log of this run can be found in:
<span class="token function">npm</span> ERR<span class="token operator">!</span>     /Users/neo/.npm/_logs/2018-10-05T10_51_39_317Z-debug.log
</code></pre> 
<p>这个是权限拒绝。所以我们重新执行一下，请求一下权限sudo</p> 
<pre class=" language-shell"><code class="prism  language-shell">$ <span class="token function">sudo</span> <span class="token function">npm</span> <span class="token function">install</span> --save bignumber.js
Password:
<span class="token function">npm</span> notice created a lockfile as package-lock.json. You should commit this file.
+ bignumber.js@7.2.1
added 1 package from 1 contributor and audited 5019 packages <span class="token keyword">in</span> 5.752s
found 0 vulnerabilities
</code></pre> 
<p>回车，输入密码，搞定。</p> 
<p>我们启动一下node，试试。</p> 
<pre class=" language-shell"><code class="prism  language-shell">$ node
<span class="token operator">&gt;</span> require<span class="token punctuation">(</span><span class="token string">'bignumber.js'</span><span class="token punctuation">)</span>
<span class="token punctuation">{<!-- --></span> <span class="token punctuation">[</span>Function: BigNumber<span class="token punctuation">]</span>
  clone: <span class="token punctuation">[</span>Function: clone<span class="token punctuation">]</span>,
  ROUND_UP: 0,
  ROUND_DOWN: 1,
  ROUND_CEIL: 2,
  ROUND_FLOOR: 3,
  ROUND_HALF_UP: 4,
  ROUND_HALF_DOWN: 5,
  ROUND_HALF_EVEN: 6,
  ROUND_HALF_CEIL: 7,
  ROUND_HALF_FLOOR: 8,
  EUCLID: 9,
  set: <span class="token punctuation">[</span>Function<span class="token punctuation">]</span>,
  config: <span class="token punctuation">[</span>Function<span class="token punctuation">]</span>,
  isBigNumber: <span class="token punctuation">[</span>Function<span class="token punctuation">]</span>,
  max: <span class="token punctuation">[</span>Function<span class="token punctuation">]</span>,
  maximum: <span class="token punctuation">[</span>Function<span class="token punctuation">]</span>,
  min: <span class="token punctuation">[</span>Function<span class="token punctuation">]</span>,
  minimum: <span class="token punctuation">[</span>Function<span class="token punctuation">]</span>,
  random: <span class="token punctuation">[</span>Function<span class="token punctuation">]</span>,
  BigNumber: <span class="token punctuation">[</span>Circular<span class="token punctuation">]</span>,
  default: <span class="token punctuation">[</span>Circular<span class="token punctuation">]</span> <span class="token punctuation">}</span>

</code></pre> 
<p>Have done~</p>
                
{% endraw %}
