---
title: MAC中安装oracle11g，并导入数据
date: 2018-10-11 11:28:45
layout: post
author: 刘泽美
categories:
  - CSDN文章
  - 导入
tags: 代码人生
---

[原链接](https://blog.csdn.net/weixin_41884153/article/details/83009991)
{% raw %}

                    <svg xmlns="http://www.w3.org/2000/svg" style="display: none;">
                        <path stroke-linecap="round" d="M5,0 0,2.5 5,5z" id="raphael-marker-block" style="-webkit-tap-highlight-color: rgba(0, 0, 0, 0);"></path>
                    </svg>
                    <p>mac下想要使用oracle，可以先安装虚拟机，然后在虚拟机中安装oracle。虽说oracle有mac版，但据本人所知只有10g，且官网上已无法下载。虚拟机的安装和在虚拟机中安装oracle，百度有很多教程，不再赘述。另外一种比较简单的方式是使用docker，如果网速好的话，从开始动手到可以使用大概也不用20分钟。安装步骤如下：</p> 
<p>1、安装docker 文件下载：下载docker</p> 
<p>2、安装oracle 在终端中执行：</p> 
<pre><code class="prism language-s">docker pull alexeiled/docker-oracle-xe-11g    
</code></pre> 
<p>下载完成后，启动镜像为容器：</p> 
<pre><code class="prism language-s">docker run -h "oracle" --name "oracle" -d -p 49160:22 -p 49161:1521 -p 49162:8080 alexeiled/docker-oracle-xe-11g    
</code></pre> 
<p>执行成功后，可使用数据库连接工具进行访问： 默认用户是system，密码oracle。当然一般的做法是创建一个普通用户，使用这个用户进行操作。</p> 
<p>3、创建用户 在终端中执行以下命令进入容器：</p> 
<pre><code class="prism language-s">docker exec -it 806ebe7f5231  /bin/bash    
</code></pre> 
<p>其中806ebe7f5231是容器id，可使用如下命令获得：</p> 
<pre><code class="prism language-s">docker ps           
</code></pre> 
<p>进入容器后，使用如下命令登录：</p> 
<pre><code class="prism language-s">sqlplus system/oracle
</code></pre> 
<p>然后再创建用户，授权等。</p> 
<p>4、导入数据 创建用户、表空间成功后，下一步就要导入数据。<br> 注意：先要将数据库备份文件复制到容器中才能导入。<br> 退出oracle连接后，使用root在容器中创建一个目录，用于放置数据库文件：</p> 
<pre><code class="prism language-s">mkdir dbfile    
</code></pre> 
<p>exit退出容器，在终端中执行命令，将备份复制到容器：</p> 
<pre><code class="prism language-s">sudo docker cp /Users/xxx/Desktop/backup.dbf bf939e7c2bd8:/dbfile    
</code></pre> 
<p>以上命令中，/Users/xxx/Desktop/backup.dbf是数据库备份在mac中的全路径，bf939e7c2bd8是容器id，/dbfile是在容器中的存放目录。 复制完成后，再次进入容器，使用sqlplus连接到数据库，按一般步骤进行imp导入即可。</p> 
<p>停止/启动oracle服务：</p> 
<pre><code class="prism language-shell">docker stop oracle
docker start oracle
</code></pre> 
<p>---------------------原文：<a href="https://blog.csdn.net/qq_22481167/article/details/79951160?utm_source=copy">https://blog.csdn.net/qq_22481167/article/details/79951160?utm_source=copy</a></p>
                
{% endraw %}
