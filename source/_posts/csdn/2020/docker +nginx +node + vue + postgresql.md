---
title: docker +nginx +node + vue + postgresql
date: 2020-08-06 22:01:21
layout: post
author: 刘泽美
categories:
  - CSDN文章
  - 导入
tags: 代码人生
---

[原链接](https://blog.csdn.net/weixin_41884153/article/details/107850603)
{% raw %}

                    <svg xmlns="http://www.w3.org/2000/svg" style="display: none;">
                        <path stroke-linecap="round" d="M5,0 0,2.5 5,5z" id="raphael-marker-block" style="-webkit-tap-highlight-color: rgba(0, 0, 0, 0);"></path>
                    </svg>
                    <h2><a id="0__0"></a>0. 写在前面</h2> 
<p>nginx + vue + node + postgresql<br> 两个镜像</p> 
<pre><code>ccr.ccs.tencentyun.com/node_test/vue_test_3 # vue + nginx
ccr.ccs.tencentyun.com/node_test/vue_express_3 # express + postgresql
</code></pre> 
<p><a href="https://github.com/liuzemei/docker-node-postgres-vue-nginx">https://github.com/liuzemei/docker-node-postgres-vue-nginx</a></p> 
<h2><a id="1__docker_10"></a>1. 安装 docker</h2> 
<h3><a id="1__12"></a>1. 安装</h3> 
<pre><code class="prism language-shell">yum <span class="token function">install</span> -y yum-utils device-mapper-persistent-data lvm2
<span class="token function">sudo</span> yum-config-manager --add-repo http://mirrors.aliyun.com/docker-ce/linux/centos/docker-ce.repo
yum <span class="token function">install</span> -y docker-ce --nobest
systemctl start docker
systemctl <span class="token function">enable</span> docker
</code></pre> 
<h3><a id="2__21"></a>2. 换源</h3> 
<ul><li>(阿里云容器镜像服务)[https://cr.console.aliyun.com/]</li><li>(腾讯云镜像服务)[https://cloud.tencent.com/document/product/1207/45596]</li></ul> 
<pre><code class="prism language-shell">vim /etc/docker/daemon.json
</code></pre> 
<pre><code class="prism language-vim">{
"registry-mirrors": [
  "https://mirror.ccs.tencentyun.com"
],
"insecure-registries" : [
  "https://ccr.ccs.tencentyun.com"
]
}
```shell
systemctl restart docker
</code></pre> 
<h2><a id="2__dockercompose_44"></a>2. 安装 docker-compose</h2> 
<pre><code class="prism language-shell">yum <span class="token function">install</span> -y epel-release
yum <span class="token function">install</span> -y python3-pip
pip3 <span class="token function">install</span> docker-compose
docker-compose --version
</code></pre> 
<h3><a id="dockercompose__51"></a>docker-compose 文件编写</h3> 
<pre><code class="prism language-yml"><span class="token key atrule">version</span><span class="token punctuation">:</span> <span class="token string">'3'</span>
<span class="token key atrule">services</span><span class="token punctuation">:</span>
  <span class="token key atrule">postgres</span><span class="token punctuation">:</span>
    <span class="token key atrule">image</span><span class="token punctuation">:</span> postgres<span class="token punctuation">:</span>latest
    <span class="token key atrule">restart</span><span class="token punctuation">:</span> always
    <span class="token key atrule">environment</span><span class="token punctuation">:</span>
      <span class="token key atrule">POSTGRES_PASSWORD</span><span class="token punctuation">:</span> postgres
      <span class="token key atrule">PGDATA</span><span class="token punctuation">:</span> /var/lib/postgresql/data/pgdata
    <span class="token key atrule">volumes</span><span class="token punctuation">:</span>
      <span class="token punctuation">-</span> /home/postgres/data<span class="token punctuation">:</span>/var/lib/postgresql/data/pgdata
  <span class="token key atrule">backend</span><span class="token punctuation">:</span>
    <span class="token key atrule">image</span><span class="token punctuation">:</span> ccr.ccs.tencentyun.com/node_test/vue_express_3
    <span class="token key atrule">restart</span><span class="token punctuation">:</span> always
    <span class="token key atrule">depends_on</span><span class="token punctuation">:</span>
     <span class="token punctuation">-</span> postgres
  <span class="token key atrule">proxy</span><span class="token punctuation">:</span>
    <span class="token key atrule">image</span><span class="token punctuation">:</span> ccr.ccs.tencentyun.com/node_test/vue_test_3
    <span class="token key atrule">restart</span><span class="token punctuation">:</span> always
    <span class="token key atrule">ports</span><span class="token punctuation">:</span>
     <span class="token punctuation">-</span> <span class="token datetime number">80:80</span>
    <span class="token key atrule">depends_on</span><span class="token punctuation">:</span>
     <span class="token punctuation">-</span> backend
    <span class="token key atrule">volumes</span><span class="token punctuation">:</span>
     <span class="token punctuation">-</span> /home/nginx/logs<span class="token punctuation">:</span>/var/log/nginx
</code></pre> 
<h2><a id="3__79"></a>3. 运行容器</h2> 
<pre><code class="prism language-shell">docker-compose up -d
</code></pre> 
<h2><a id="4__84"></a>4. 结束</h2> 
<p>可以直接去访问自己的端口了。已经部署好了nginx代理前后端，后端连接了postgres数据库。</p>
                
{% endraw %}
