---
title: 你的 https 请求偶尔会慢几拍？也许你需要看看 OCSP stapling
date: 2020-12-13 15:12:27
layout: post
author: 刘泽美
categories:
  - CSDN文章
  - 导入
tags: 代码人生
---

[原链接](https://blog.csdn.net/weixin_41884153/article/details/107122695)
{% raw %}

                    <svg xmlns="http://www.w3.org/2000/svg" style="display: none;">
                        <path stroke-linecap="round" d="M5,0 0,2.5 5,5z" id="raphael-marker-block" style="-webkit-tap-highlight-color: rgba(0, 0, 0, 0);"></path>
                    </svg>
                    <h1><a id="_https__OCSP_stapling_0"></a>你的 https 请求偶尔会慢几拍？也许你需要看看 OCSP stapling</h1> 
<h2><a id="_2"></a>导读</h2> 
<p>1.1 <code>读完本文，您将收获：</code></p> 
<blockquote> 
 <ol><li>连接速度更快、更稳定的web项目。</li></ol> 
</blockquote> 
<p>1.2 <code>本文面向人群。</code></p> 
<blockquote> 
 <ol><li><strong>服务器在海外</strong></li><li>使用诸如 <strong>letsencrypt</strong> 之类 OCSP 服务器访问慢的 ssl</li><li>服务器使用 <strong>nginx</strong> 或 <strong>caddy</strong> 做网页服务器。</li></ol> 
</blockquote> 
<h2><a id="_13"></a>正文</h2> 
<h3><a id="1_OCSP_15"></a>1. OCSP概述</h3> 
<h4><a id="11__16"></a>1.1 概念</h4> 
<blockquote> 
 <p>OCSP：在线证书状态协议（Online Certificate Status Protocol），被用于检验证书合法性。</p> 
</blockquote> 
<p>浏览器访问从输入域名按下回车开始到服务器开始返回数据，中间包含步骤：</p> 
<ol><li>DNS 查询</li><li>建立 TCP 连接</li><li>SSL证书安全校验（OCSP）</li></ol> 
<h4><a id="12__24"></a>1.2 未优化</h4> 
<blockquote> 
 <p>OCSP是由客户端（浏览器）发起的。</p> 
</blockquote> 
<p>浏览器会直接请求第三方 CA 来获取证书的状态，如果服务端设置的 ssl 证书 网络不稳定或者 速度过慢，则会严重降低 HTTPS 性能，还存在隐私安全问题。</p> 
<h4><a id="13__29"></a>1.3 优化思路</h4> 
<blockquote> 
 <p>OCSP Stapling：OCSP由服务器发起。</p> 
</blockquote> 
<p>服务器直接获取 OCSP 查询结果，并随证书一起发送给客户端，让客户端跳过自己去寻求验证的过程，提高 TLS 握手效率，从而提高 HTTPS 性能。</p> 
<h3><a id="2_OCSP__34"></a>2. OCSP 优化详解</h3> 
<h4><a id="21__OCSP__35"></a>2.1 查询 OCSP 状态</h4> 
<p><a href="https://www.ssllabs.com/ssltest/analyze.html">https://www.ssllabs.com/ssltest/analyze.html</a><br> 访问这个网站，并输入自己的域名，点击submit（可能需要等待2~5分钟完成解析）<br> 等待解析完成之后，在较靠站点末尾的地方，找到图示信息。图示中并没有开启 OCSP 。<br> <img src="https://img-blog.csdnimg.cn/20200704113555816.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MTg4NDE1Mw==,size_16,color_FFFFFF,t_70" alt="在这里插入图片描述"></p> 
<h4><a id="23_Nginx__41"></a>2.3 Nginx 优化</h4> 
<blockquote> 
 <p>本文直接以 <strong>Letsencrypt</strong> 为例进行详解，如果没有证书的，想了解如何安装并使用 Letsencrypt ，<a href="https://www.digitalocean.com/community/tutorials/how-to-secure-nginx-with-let-s-encrypt-on-ubuntu-18-04">请点击这里了解详情</a></p> 
</blockquote> 
<blockquote> 
 <p>到这一步，默认您已经成功使用了 <code>Letsencrypt</code> ，假设您的域名是<code>abc.xyz</code>，此时您可以成功访问 <code>https://abc.xyz</code></p> 
</blockquote> 
<h5><a id="231__46"></a>2.3.1 我们到服务器，输入一下命令</h5> 
<pre><code class="prism language-bash"><span class="token function">sudo</span> <span class="token function">cat</span> /etc/letsencrypt/live/abc.xyz/fullchain.pem
<span class="token function">sudo</span> <span class="token function">cat</span> /etc/letsencrypt/live/abc.xyz/privkey.pem
<span class="token function">sudo</span> <span class="token function">cat</span> /etc/letsencrypt/live/abc.xyz/chain.pem
</code></pre> 
<blockquote> 
 <p>如果成功打印出来，说明，Letsencrypt 配置正确。否则，请参照上方链接自行配置。</p> 
</blockquote> 
<p>前两个是用来配置 ssl 的，由 <code>Letsencrypt</code> 自动帮我们管理，最后一个<code>chain.pem</code>是即将要使用的。</p> 
<h5><a id="232__nginx__55"></a>2.3.2 我们打开 nginx 对应网站的配置文件</h5> 
<p>例：</p> 
<pre><code class="prism language-bash"><span class="token function">sudo</span> vim /etc/nginx/sites-enabled/abc.xyz
</code></pre> 
<p>找到这些信息，（都是 Letsencrypt 自动帮我们配好的）</p> 
<pre><code class="prism language-nginx">listen 443 ssl; # managed by Certbot
ssl_certificate /etc/letsencrypt/live/abc.xyz/fullchain.pem; # managed by Certbot
ssl_certificate_key /etc/letsencrypt/live/abc.xyz/privkey.pem; # managed by Certbot
include /etc/letsencrypt/options-ssl-nginx.conf; # managed by Certbot
ssl_dhparam /etc/letsencrypt/ssl-dhparams.pem; # managed by Certbot
</code></pre> 
<p>在下边增加三行：<br> 修改结果如下：</p> 
<pre><code class="prism language-nginx">listen 443 ssl; # managed by Certbot
ssl_certificate /etc/letsencrypt/live/abc.xyz/fullchain.pem; # managed by Certbot
ssl_certificate_key /etc/letsencrypt/live/abc.xyz/privkey.pem; # managed by Certbot
include /etc/letsencrypt/options-ssl-nginx.conf; # managed by Certbot
ssl_dhparam /etc/letsencrypt/ssl-dhparams.pem; # managed by Certbot
ssl_stapling on;
ssl_stapling_verify on;
ssl_trusted_certificate /etc/letsencrypt/live/abc.xyz/chain.pem;
</code></pre> 
<h5><a id="233__nginx_82"></a>2.3.3 保存退出并重启 nginx</h5> 
<pre><code class="prism language-bash"><span class="token function">sudo</span> nginx -s reload
</code></pre> 
<h5><a id="234__OCSP_86"></a>2.3.4 再查询一下 OCSP</h5> 
<p><img src="https://img-blog.csdnimg.cn/20200704114507865.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MTg4NDE1Mw==,size_16,color_FFFFFF,t_70" alt="在这里插入图片描述"><br> <strong>到这里就优化成功了。</strong><br> 如果看到下边还有 ERROR ，请参照 Canddy 优化继续配置。</p> 
<h4><a id="24_Canddy_92"></a>2.4 Canddy优化</h4> 
<p>Caddy Server 是默认打开了这个设置，那为什么还有问题？可以看看 SSL 报告：</p> 
<p><img src="https://imgconvert.csdnimg.cn/aHR0cHM6Ly93bS1zdGF0aWMtMi5vc3MtY24tc2hhbmdoYWkuYWxpeXVuY3MuY29tL3RlbXAvMi5wbmc?x-oss-process=image/format,png" alt="2"></p> 
<p>显示虽然开启但是过期，这是由于服务器在国内，而需要请求的 Let’s Encrypt OCSP 服务器被墙了。既然这样有一个解决方法是修改服务器的 hosts 文件，可以用众测平台（比如：<a href="http://ping.chinaz.com/ocsp.int-x3.letsencrypt.org">http://ping.chinaz.com/ocsp.int-x3.letsencrypt.org</a>）获取到 <a href="ocsp.int-x3.letsencrypt.org">ocsp.int-x3.letsencrypt.org</a> 对应的多个服务器 IP，然后找到你的服务器可访问的，开启自己服务器上 host 的 multi on，写入多条记录即可。</p> 
<p>完成配置后，来看看更新后的 SSL 报告，状态 Yes，一切正常。</p> 
<p><img src="https://imgconvert.csdnimg.cn/aHR0cHM6Ly93bS1zdGF0aWMtMi5vc3MtY24tc2hhbmdoYWkuYWxpeXVuY3MuY29tL3RlbXAvMS5wbmc?x-oss-process=image/format,png" alt="1"></p> 
<h2><a id="_105"></a>尾记</h2> 
<h3><a id="1__106"></a>1. 问题如何被发现</h3> 
<p>源自 Mixin 团队最新推出的一个接受打赏的服务 Donate 的优化。Donate 用户一般会在自己的文章中粘贴赞赏按钮图片和对应链接，但往往用户点击后浏览器并没有立即跳转，<br> 停顿的好几秒体验是很差的。</p> 
<p>考虑到服务器在国外，首先怀疑的就是是否由于延迟过高或请求返回过大导致。但实际测试也就 300ms 左右，尽管如此，我们还是先上了 Cloudflare 的 CDN 加速，果然停顿数秒不跳转的问题就不存在了。</p> 
<p>那么就这样了吗？No，考虑到还有在国内的服务器，如果上 Cloudflare 反而效果不佳，找到根本原因然后解决才合理。我们发现在首次打开时尽管请求返回数据很少也会出现几秒卡顿，之后的多次请求就正常，于是才意识到应该是 SSL 连接出了问题。</p> 
<p>搜索后不难找到 OCSP Stapling 相关的介绍，一个很容易被忽视但又很重要的 Config，简单实测了多个网站无一开启，所以这也是这篇文章会存在的原因。</p> 
<h3><a id="2__116"></a>2. 如何快速测试是否存在问题</h3> 
<p>使用 Chrome 的无痕模式，打开 Console 切换到 Network Tab，当你第一次（这个是重点）打开一个网址，发现请求的 Timing 中，Connection Start 下 SSL 和 Initial connection 消耗时间接近且异常久时就需要注意了。</p> 
<p><img src="https://imgconvert.csdnimg.cn/aHR0cHM6Ly93bS1zdGF0aWMtMi5vc3MtY24tc2hhbmdoYWkuYWxpeXVuY3MuY29tL3RlbXAvNS5wbmc?x-oss-process=image/format,png" alt="5"></p> 
<h3><a id="3__122"></a>3. 其他</h3> 
<p>这只是 SSL 的一个优化配置，效果虽然明显但是毕竟有限，物理硬伤比如国外用户访问国内的服务器，连接本身就慢些，要追求更快的速度该上 CDN 的还是得上。</p> 
<p>欢迎有其他牛逼操作的大佬留言讨论，一起讨论技术，一起开发 Mixin 机器人。</p>
                
{% endraw %}
