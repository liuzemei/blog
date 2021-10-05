---
title: ubuntu服务器从零开始搭建 nginx https node pm2 postgres github
date: 2020-06-15 08:27:46
layout: post
author: 刘泽美
categories:
  - CSDN文章
  - 导入
tags: 代码人生
---

[原链接](https://blog.csdn.net/weixin_41884153/article/details/106755565)
{% raw %}

                    <svg xmlns="http://www.w3.org/2000/svg" style="display: none;">
                        <path stroke-linecap="round" d="M5,0 0,2.5 5,5z" id="raphael-marker-block" style="-webkit-tap-highlight-color: rgba(0, 0, 0, 0);"></path>
                    </svg>
                    <p></p>
<div class="toc">
 <h3>ubuntu服务器从零开始搭建</h3>
 <ul><li><a href="#1_nginx__2">1. nginx 安装及配置</a></li><li><ul><li><a href="#11__4">1.1. 安装</a></li><li><a href="#12__10">1.2. 配置</a></li><li><ul><li><a href="#121__71">1.2.1 字体跨域</a></li></ul>
   </li><li><a href="#13__Lets_encrypt_78">1.3. 配置 Let's encrypt</a></li><li><ul><li><a href="#Ubuntu_20xxxx__79">Ubuntu 20.xx.xx 以下的</a></li><li><a href="#Ubuntu_20xxxx__88">Ubuntu 20.xx.xx 以上的</a></li><li><a href="#_92">接下来都是一样的</a></li></ul>
  </li></ul>
  </li><li><a href="#2_node_106">2. node</a></li><li><ul><li><a href="#1_node_108">1. node环境安装</a></li><li><a href="#2__115">2. 主要包安装</a></li></ul>
  </li><li><a href="#3_Postgres_sql__177">3. Postgres sql 数据库安装</a></li><li><a href="#4_GitHub__203">4. GitHub 配置</a></li></ul>
</div>
<p></p> 
<h1><a id="1_nginx__2"></a>1. nginx 安装及配置</h1> 
<h2><a id="11__4"></a>1.1. 安装</h2> 
<p><code>sudo apt-get update</code></p> 
<p><code>sudo apt-get install nginx -y</code></p> 
<h2><a id="12__10"></a>1.2. 配置</h2> 
<p><code>cd /etc/nginx/sites-enabled/xxxx</code></p> 
<pre><code>upstream test_com_http_server {
  server 127.0.0.1:xxxx fail_timeout=0;
}

server {
  listen 443 ssl http2;
  ssl_certificate /home/one/xxxx/config/ssl/server.crt;
  ssl_certificate_key /home/one/xxxx/config/ssl/server.key;
  server_name xxxx.com;
  root /home/one/xxxx/html;
  index index.html index.htm;
  charset utf-8;

  location ~* ^/api {
    proxy_set_header  X-Real-IP  $remote_addr;
    proxy_set_header  X-Forwarded-For $proxy_add_x_forwarded_for;
    proxy_set_header  X_FORWARDED_PROTO $scheme;
    proxy_set_header  Host $http_host;
    proxy_redirect    off;
    client_max_body_size 10M;

    proxy_pass http://test_com_http_server;
  }

  gzip            on;
  gzip_comp_level 5;
  gzip_min_length 256;
  gzip_proxied    any;
  gzip_types
    application/atom+xml
    application/javascript
    application/json
    application/ld+json
    application/manifest+json
    application/rss+xml
    application/vnd.geo+json
    application/vnd.ms-fontobject
    application/x-font-ttf
    application/x-web-app-manifest+json
    application/xhtml+xml
    application/xml
    font/opentype
    image/bmp
    image/svg+xml
    image/x-icon
    text/cache-manifest
    text/css
    text/plain
    text/vcard
    text/vnd.rim.location.xloc
    text/vtt
    text/x-component
    text/x-cross-domain-policy;

}
</code></pre> 
<h3><a id="121__71"></a>1.2.1 字体跨域</h3> 
<pre><code>location ~* \.(eot|ttf|woff|woff2|svg|otf)$ {
   add_header Access-Control-Allow-Origin *;
}
</code></pre> 
<h2><a id="13__Lets_encrypt_78"></a>1.3. 配置 Let’s encrypt</h2> 
<h3><a id="Ubuntu_20xxxx__79"></a>Ubuntu 20.xx.xx 以下的</h3> 
<ol><li> <p>添加存储库</p> <p><code>sudo add-apt-repository ppa:certbot/certbot</code></p> </li></ol> 
<blockquote> 
 <p>如果报错 <code>sudo apt-get install software-properties-common</code></p> 
</blockquote> 
<ol start="2"><li> <p>安装 nginx 软件包</p> <p><code>sudo apt install python-certbot-nginx</code></p> </li></ol> 
<h3><a id="Ubuntu_20xxxx__88"></a>Ubuntu 20.xx.xx 以上的</h3> 
<ol><li>安装 certbot 和 python3-certbot-nginx<br> <code>sudo apt install certbot python3-certbot-nginx</code></li></ol> 
<h3><a id="_92"></a>接下来都是一样的</h3> 
<ol><li> <p>确认 nginx 成功运行</p> </li><li> <p>获取 ssl 证书</p> <p><code>sudo certbot --nginx</code></p> </li><li> <p>自动续订</p> <p><code>sudo certbot renew --dry-run</code></p> </li></ol> 
<blockquote> 
 <p><a href="https://www.digitalocean.com/community/tutorials/how-to-secure-nginx-with-let-s-encrypt-on-ubuntu-18-04">原文链接</a></p> 
</blockquote> 
<p>/usr/bin/certbot /usr/sbin/nginx</p> 
<h1><a id="2_node_106"></a>2. node</h1> 
<h2><a id="1_node_108"></a>1. node环境安装</h2> 
<pre><code class="prism language-bash"><span class="token function">curl</span> -sL https://deb.nodesource.com/setup_14.x <span class="token operator">|</span> <span class="token function">sudo</span> -E <span class="token function">bash</span> -
<span class="token function">sudo</span> <span class="token function">apt-get</span> <span class="token function">install</span> -y nodejs
</code></pre> 
<h2><a id="2__115"></a>2. 主要包安装</h2> 
<ol><li> <p>Yarn | npm 安装</p> <pre><code class="prism language-bash"><span class="token function">sudo</span> <span class="token function">npm</span> i -g <span class="token function">yarn</span>
<span class="token function">sudo</span> <span class="token function">npm</span> i -g cnpm
</code></pre> <p>安装完了之后</p> <pre><code class="prism language-bash"><span class="token function">sudo</span> <span class="token function">chown</span> -R <span class="token environment constant">$USER</span><span class="token builtin class-name">:</span><span class="token variable">$GROUP</span> ~/.npm
<span class="token function">sudo</span> <span class="token function">chown</span> -R <span class="token environment constant">$USER</span><span class="token builtin class-name">:</span><span class="token variable">$GROUP</span> ~/.config
</code></pre> </li><li> <p>pm2 安装</p> <p><code>sudo npm i -g pm2</code></p> </li><li> <p>pm2 使用</p> <pre><code class="prism language-bash">pm2 start app.js -o ./log/out.log -e ./log/err.log
<span class="token assign-left variable">NODE_ENV</span><span class="token operator">=</span>production pm2 reload      
</code></pre> </li><li> <p>pm2 fork</p> <pre><code class="prism language-js">module<span class="token punctuation">.</span>exports <span class="token operator">=</span> <span class="token punctuation">{<!-- --></span>
  apps <span class="token operator">:</span> <span class="token punctuation">[</span><span class="token punctuation">{<!-- --></span>
    name<span class="token operator">:</span> <span class="token string">'xxxx'</span><span class="token punctuation">,</span>
    script<span class="token operator">:</span> <span class="token string">'app.js'</span><span class="token punctuation">,</span>
    autorestart<span class="token operator">:</span> <span class="token boolean">true</span><span class="token punctuation">,</span>
    watch<span class="token operator">:</span> <span class="token boolean">false</span><span class="token punctuation">,</span>
    max_memory_restart<span class="token operator">:</span> <span class="token string">'1G'</span><span class="token punctuation">,</span>
    out_file<span class="token operator">:</span> <span class="token string">'./log/out.log'</span><span class="token punctuation">,</span>
    error_file<span class="token operator">:</span> <span class="token string">'./log/err.log'</span>
  <span class="token punctuation">}</span><span class="token punctuation">]</span>
<span class="token punctuation">}</span><span class="token punctuation">;</span>
</code></pre> </li><li> <p>pm2 cluster</p> <pre><code class="prism language-js">module<span class="token punctuation">.</span>exports <span class="token operator">=</span> <span class="token punctuation">{<!-- --></span>
  apps <span class="token operator">:</span> <span class="token punctuation">[</span><span class="token punctuation">{<!-- --></span>
    name<span class="token operator">:</span> <span class="token string">'xxxx'</span><span class="token punctuation">,</span>
    script<span class="token operator">:</span> <span class="token string">'app.js'</span><span class="token punctuation">,</span>
    instances<span class="token operator">:</span> <span class="token string">'max'</span><span class="token punctuation">,</span>
    autorestart<span class="token operator">:</span> <span class="token boolean">true</span><span class="token punctuation">,</span>
    watch<span class="token operator">:</span> <span class="token boolean">false</span><span class="token punctuation">,</span>
    max_memory_restart<span class="token operator">:</span> <span class="token string">'1G'</span><span class="token punctuation">,</span>
    exec_mode<span class="token operator">:</span> <span class="token string">'cluster'</span><span class="token punctuation">,</span>
    out_file<span class="token operator">:</span> <span class="token string">'./log/out.log'</span><span class="token punctuation">,</span>
    error_file<span class="token operator">:</span> <span class="token string">'./log/err.log'</span>
  <span class="token punctuation">}</span><span class="token punctuation">]</span>
<span class="token punctuation">}</span><span class="token punctuation">;</span>
</code></pre> </li></ol> 
<h1><a id="3_Postgres_sql__177"></a>3. Postgres sql 数据库安装</h1> 
<ol><li> <p>安装</p> <p><code>sudo apt-get install postgresql</code></p> </li><li> <p>进入管理员账号</p> <p><code>sudo -u postgres psql</code></p> </li><li> <p>创建用户</p> <p><code>CREATE USER username WITH PASSWORD '****';</code></p> </li><li> <p>创建数据库</p> <p><code>CREATE DATABASE databasename OWNER username</code></p> </li><li> <p>赋予创建用户数据库权限</p> <p>如果上一步指定了 <code>OWNER</code>则可以省略</p> <p><code>GRANT ALL ON DATABASE databasename TO username</code></p> </li></ol> 
<h1><a id="4_GitHub__203"></a>4. GitHub 配置</h1> 
<pre><code class="prism language-bash"><span class="token builtin class-name">cd</span> ~/.ssh
<span class="token function">vi</span> id_rsa
<span class="token function">chmod</span> <span class="token number">600</span> id_rsa
<span class="token function">ssh</span> -T git@github.com
</code></pre> 
<blockquote> 
 <p><code>ssh-keygen -t rsa -b 4096 -C "your_email@example.com"</code></p> 
</blockquote>
                
{% endraw %}
