---
title: Linux下安装Oracle Database 11g Express Edition
date: 2018-10-11 10:52:28
layout: post
author: 刘泽美
categories:
  - CSDN文章
  - 导入
tags: 代码人生
---

[原链接](https://blog.csdn.net/weixin_41884153/article/details/83009162)
{% raw %}

                    <svg xmlns="http://www.w3.org/2000/svg" style="display: none;">
                        <path stroke-linecap="round" d="M5,0 0,2.5 5,5z" id="raphael-marker-block" style="-webkit-tap-highlight-color: rgba(0, 0, 0, 0);"></path>
                    </svg>
                    <p>原文链接：https://blog.csdn.net/hqs_1992/article/details/41895389</p> 
<p>前言：</p> 
<p>Oracle Database 11g 快捷版 (Oracle Database XE) 是一款基于 Oracle Database 11g 第 2 版代码库的小型入门级数据库，它具备以下优点：免费开发、部署和分发；下载速度快；并且管理简单。</p> 
<p>相较于oracle database 标准版与企业版动则2、3G的大小。XE版总共才三百多兆，它定位的是免费入门级数据库，最适合初学者进行oracle数据库的学习。</p> 
<p>目前最新版本为Oracle Database XE 11g，只提供32位window和64位Linux的下载。</p> 
<p>下载官网：http://www.oracle.com/technetwork/cn/database/database-technologies/express-edition/downloads/index.html</p> 
<p>1.在Linux中增加swap空间</p> 
<p>将下载后的oracle压缩包解压到Linux系统下，利用root用户权限指令操作：</p> 
<p>[root@localhost Disk1]# rpm -i oracle-xe-11.2.0-1.0.x86_64.rpm</p> 
<p>会有以下提示：</p> 
<p>This system does not meet the minimum requirements for swap space. Based on<br> the amount of physical memory available on the system, Oracle Database 11g<br> Express Edition requires 2048 MB of swap space. This system has 2042 MB<br> of swap space. Configure more swap space on the system and retry the<br> installation.</p> 
<p>错误：%pre(oracle-xe-11.2.0-1.0.x86_64) 脚本执行失败，退出状态码为 1<br> 错误：oracle-xe-11.2.0-1.0.x86_64: 安裝 已失败</p> 
<p>这是由于在安装Linux的时候，不知道swap空间分配多少比较好，所以会随便分配一个，而安装Oracle11g会要求很大的swap空间，所以swap空间不够用，所以需要增加swap空间大小。</p> 
<pre><code>    以下的操作都要在root用户下进行，首先先建立一个分区，采用dd命令比如
</code></pre> 
<p>dd if=/dev/zero of=/home/swap bs=1024 count=512000<br> 这样就会创建/home/swap这么一个分区文件。文件的大小是512000个block，一般情况下1个block为1K，所以这里空间是512M。接着再把这个分区变成swap分区。</p> 
<p>/sbin/mkswap /home/swap<br> 再接着使用这个swap分区。使其成为有效状态。</p> 
<p>/sbin/swapon /home/swap<br> 现在再用free -m命令查看一下内存和swap分区大小，就发现增加了512M的空间了。不过当计算机重启了以后，发现swap还是原来那么大，新的swap没有自动启动，还要手动启动。那我们需要修改/etc/fstab文件，增加如下一行</p> 
<p>/home/swap swap swap defaults 0 0<br> 你就会发现你的机器自动启动以后swap空间也增大了。</p> 
<p>2.组的创建</p> 
<p>（1）先查看这些组和用户是否存在:</p> 
<p># grep oinstall /etc/group</p> 
<p># grep dba /etc/group</p> 
<p>（2）创建安装oracle 所需的组和用户</p> 
<p># groupadd oinstall</p> 
<p># groupadd dba</p> 
<h1><a id="useradd_m_g_oinstall_G_dba_oracle_63"></a>useradd –m –g oinstall –G dba oracle</h1> 
<p>检查一下oracle 是否属于组 oinstall 和 dba (#id oracle) ：</p> 
<h1><a id="id_oracle_67"></a>id oracle</h1> 
<p>uid=1001(oracle) gid=1000(oinstall) groups=1001(dba)</p> 
<p>再给oracle 设置一个用户口令</p> 
<h1><a id="passwd_oracle__73"></a>passwd oracle 输入两次密码。</h1> 
<p>3.oracle安装</p> 
<p>再次输入指令：</p> 
<p>[root@localhost Disk1]# rpm -i oracle-xe-11.2.0-1.0.x86_64.rpm</p> 
<p>输出：</p> 
<p>Executing post-install steps…<br> You must run ‘/etc/init.d/oracle-xe configure’ as the root user to configure the database.</p> 
<p>按所给提示输入：</p> 
<p>[root@localhost Disk1]# /etc/init.d/oracle-xe configure</p> 
<p>根据提示设置8080、1521端口，还有sys和system的密码，开机是否启动等。</p> 
<p>最后输出：</p> 
<p>Starting Oracle Net Listener…Done<br> Configuring database…Done<br> Starting Oracle Database 11g Express Edition instance…Done<br> Installation completed successfully.</p> 
<p>说明安装成功。</p> 
<p>然后以super user身份运行以下脚本进行配置：</p> 
<h1><a id="etcinitdoraclexe_configure_105"></a>/etc/init.d/oracle-xe configure</h1> 
<p>4.设置环境变量：</p> 
<p>修改/etc/profile文件，添加如下内容：</p> 
<h1><a id="Oracle_Settings_112"></a>Oracle Settings</h1> 
<p>TMP=/tmp; export TMP<br> TMPDIR=<span class="katex--inline"><span class="katex"><span class="katex-mathml">
    
     
      
       
        T
       
       
        M
       
       
        P
       
       
        ;
       
       
        e
       
       
        x
       
       
        p
       
       
        o
       
       
        r
       
       
        t
       
       
        T
       
       
        M
       
       
        P
       
       
        D
       
       
        I
       
       
        R
       
       
        O
       
       
        R
       
       
        A
       
       
        C
       
       
        L
       
       
        
         E
        
        
         B
        
       
       
        A
       
       
        S
       
       
        E
       
       
        =
       
       
        /
       
       
        u
       
       
        01
       
       
        /
       
       
        a
       
       
        p
       
       
        p
       
       
        /
       
       
        o
       
       
        r
       
       
        a
       
       
        c
       
       
        l
       
       
        e
       
       
        ;
       
       
        e
       
       
        x
       
       
        p
       
       
        o
       
       
        r
       
       
        t
       
       
        O
       
       
        R
       
       
        A
       
       
        C
       
       
        L
       
       
        
         E
        
        
         B
        
       
       
        A
       
       
        S
       
       
        E
       
       
        O
       
       
        R
       
       
        A
       
       
        C
       
       
        L
       
       
        
         E
        
        
         H
        
       
       
        O
       
       
        M
       
       
        E
       
       
        =
       
      
      
       TMP; export TMPDIR ORACLE_BASE=/u01/app/oracle; export ORACLE_BASE ORACLE_HOME=
      
     
    </span><span class="katex-html"><span class="base"><span class="strut" style="height: 0.87777em; vertical-align: -0.19444em;"></span><span class="mord mathdefault" style="margin-right: 0.13889em;">T</span><span class="mord mathdefault" style="margin-right: 0.10903em;">M</span><span class="mord mathdefault" style="margin-right: 0.13889em;">P</span><span class="mpunct">;</span><span class="mspace" style="margin-right: 0.166667em;"></span><span class="mord mathdefault">e</span><span class="mord mathdefault">x</span><span class="mord mathdefault">p</span><span class="mord mathdefault">o</span><span class="mord mathdefault" style="margin-right: 0.02778em;">r</span><span class="mord mathdefault">t</span><span class="mord mathdefault" style="margin-right: 0.13889em;">T</span><span class="mord mathdefault" style="margin-right: 0.10903em;">M</span><span class="mord mathdefault" style="margin-right: 0.13889em;">P</span><span class="mord mathdefault" style="margin-right: 0.02778em;">D</span><span class="mord mathdefault" style="margin-right: 0.07847em;">I</span><span class="mord mathdefault" style="margin-right: 0.00773em;">R</span><span class="mord mathdefault" style="margin-right: 0.02778em;">O</span><span class="mord mathdefault" style="margin-right: 0.00773em;">R</span><span class="mord mathdefault">A</span><span class="mord mathdefault" style="margin-right: 0.07153em;">C</span><span class="mord mathdefault">L</span><span class="mord"><span class="mord mathdefault" style="margin-right: 0.05764em;">E</span><span class="msupsub"><span class="vlist-t vlist-t2"><span class="vlist-r"><span class="vlist" style="height: 0.328331em;"><span class="" style="top: -2.55em; margin-left: -0.05764em; margin-right: 0.05em;"><span class="pstrut" style="height: 2.7em;"></span><span class="sizing reset-size6 size3 mtight"><span class="mord mathdefault mtight" style="margin-right: 0.05017em;">B</span></span></span></span><span class="vlist-s">​</span></span><span class="vlist-r"><span class="vlist" style="height: 0.15em;"><span class=""></span></span></span></span></span></span><span class="mord mathdefault">A</span><span class="mord mathdefault" style="margin-right: 0.05764em;">S</span><span class="mord mathdefault" style="margin-right: 0.05764em;">E</span><span class="mspace" style="margin-right: 0.277778em;"></span><span class="mrel">=</span><span class="mspace" style="margin-right: 0.277778em;"></span></span><span class="base"><span class="strut" style="height: 1em; vertical-align: -0.25em;"></span><span class="mord">/</span><span class="mord mathdefault">u</span><span class="mord">0</span><span class="mord">1</span><span class="mord">/</span><span class="mord mathdefault">a</span><span class="mord mathdefault">p</span><span class="mord mathdefault">p</span><span class="mord">/</span><span class="mord mathdefault">o</span><span class="mord mathdefault" style="margin-right: 0.02778em;">r</span><span class="mord mathdefault">a</span><span class="mord mathdefault">c</span><span class="mord mathdefault" style="margin-right: 0.01968em;">l</span><span class="mord mathdefault">e</span><span class="mpunct">;</span><span class="mspace" style="margin-right: 0.166667em;"></span><span class="mord mathdefault">e</span><span class="mord mathdefault">x</span><span class="mord mathdefault">p</span><span class="mord mathdefault">o</span><span class="mord mathdefault" style="margin-right: 0.02778em;">r</span><span class="mord mathdefault">t</span><span class="mord mathdefault" style="margin-right: 0.02778em;">O</span><span class="mord mathdefault" style="margin-right: 0.00773em;">R</span><span class="mord mathdefault">A</span><span class="mord mathdefault" style="margin-right: 0.07153em;">C</span><span class="mord mathdefault">L</span><span class="mord"><span class="mord mathdefault" style="margin-right: 0.05764em;">E</span><span class="msupsub"><span class="vlist-t vlist-t2"><span class="vlist-r"><span class="vlist" style="height: 0.328331em;"><span class="" style="top: -2.55em; margin-left: -0.05764em; margin-right: 0.05em;"><span class="pstrut" style="height: 2.7em;"></span><span class="sizing reset-size6 size3 mtight"><span class="mord mathdefault mtight" style="margin-right: 0.05017em;">B</span></span></span></span><span class="vlist-s">​</span></span><span class="vlist-r"><span class="vlist" style="height: 0.15em;"><span class=""></span></span></span></span></span></span><span class="mord mathdefault">A</span><span class="mord mathdefault" style="margin-right: 0.05764em;">S</span><span class="mord mathdefault" style="margin-right: 0.05764em;">E</span><span class="mord mathdefault" style="margin-right: 0.02778em;">O</span><span class="mord mathdefault" style="margin-right: 0.00773em;">R</span><span class="mord mathdefault">A</span><span class="mord mathdefault" style="margin-right: 0.07153em;">C</span><span class="mord mathdefault">L</span><span class="mord"><span class="mord mathdefault" style="margin-right: 0.05764em;">E</span><span class="msupsub"><span class="vlist-t vlist-t2"><span class="vlist-r"><span class="vlist" style="height: 0.328331em;"><span class="" style="top: -2.55em; margin-left: -0.05764em; margin-right: 0.05em;"><span class="pstrut" style="height: 2.7em;"></span><span class="sizing reset-size6 size3 mtight"><span class="mord mathdefault mtight" style="margin-right: 0.08125em;">H</span></span></span></span><span class="vlist-s">​</span></span><span class="vlist-r"><span class="vlist" style="height: 0.15em;"><span class=""></span></span></span></span></span></span><span class="mord mathdefault" style="margin-right: 0.02778em;">O</span><span class="mord mathdefault" style="margin-right: 0.10903em;">M</span><span class="mord mathdefault" style="margin-right: 0.05764em;">E</span><span class="mspace" style="margin-right: 0.277778em;"></span><span class="mrel">=</span></span></span></span></span>ORACLE_BASE/product/11.2.0/xe; export ORACLE_HOME<br> ORACLE_SID=XE; export ORACLE_SID<br> ORACLE_TERM=xterm; export ORACLE_TERM<br> PATH=/usr/sbin:<span class="katex--inline"><span class="katex"><span class="katex-mathml">
    
     
      
       
        P
       
       
        A
       
       
        T
       
       
        H
       
       
        ;
       
       
        e
       
       
        x
       
       
        p
       
       
        o
       
       
        r
       
       
        t
       
       
        P
       
       
        A
       
       
        T
       
       
        H
       
       
        P
       
       
        A
       
       
        T
       
       
        H
       
       
        =
       
      
      
       PATH; export PATH PATH=
      
     
    </span><span class="katex-html"><span class="base"><span class="strut" style="height: 0.87777em; vertical-align: -0.19444em;"></span><span class="mord mathdefault" style="margin-right: 0.13889em;">P</span><span class="mord mathdefault">A</span><span class="mord mathdefault" style="margin-right: 0.13889em;">T</span><span class="mord mathdefault" style="margin-right: 0.08125em;">H</span><span class="mpunct">;</span><span class="mspace" style="margin-right: 0.166667em;"></span><span class="mord mathdefault">e</span><span class="mord mathdefault">x</span><span class="mord mathdefault">p</span><span class="mord mathdefault">o</span><span class="mord mathdefault" style="margin-right: 0.02778em;">r</span><span class="mord mathdefault">t</span><span class="mord mathdefault" style="margin-right: 0.13889em;">P</span><span class="mord mathdefault">A</span><span class="mord mathdefault" style="margin-right: 0.13889em;">T</span><span class="mord mathdefault" style="margin-right: 0.08125em;">H</span><span class="mord mathdefault" style="margin-right: 0.13889em;">P</span><span class="mord mathdefault">A</span><span class="mord mathdefault" style="margin-right: 0.13889em;">T</span><span class="mord mathdefault" style="margin-right: 0.08125em;">H</span><span class="mspace" style="margin-right: 0.277778em;"></span><span class="mrel">=</span></span></span></span></span>ORACLE_HOME/bin:<span class="katex--inline"><span class="katex"><span class="katex-mathml">
    
     
      
       
        P
       
       
        A
       
       
        T
       
       
        H
       
       
        ;
       
       
        e
       
       
        x
       
       
        p
       
       
        o
       
       
        r
       
       
        t
       
       
        P
       
       
        A
       
       
        T
       
       
        H
       
       
        T
       
       
        N
       
       
        
         S
        
        
         A
        
       
       
        D
       
       
        M
       
       
        I
       
       
        N
       
       
        =
       
      
      
       PATH; export PATH TNS_ADMIN=
      
     
    </span><span class="katex-html"><span class="base"><span class="strut" style="height: 0.87777em; vertical-align: -0.19444em;"></span><span class="mord mathdefault" style="margin-right: 0.13889em;">P</span><span class="mord mathdefault">A</span><span class="mord mathdefault" style="margin-right: 0.13889em;">T</span><span class="mord mathdefault" style="margin-right: 0.08125em;">H</span><span class="mpunct">;</span><span class="mspace" style="margin-right: 0.166667em;"></span><span class="mord mathdefault">e</span><span class="mord mathdefault">x</span><span class="mord mathdefault">p</span><span class="mord mathdefault">o</span><span class="mord mathdefault" style="margin-right: 0.02778em;">r</span><span class="mord mathdefault">t</span><span class="mord mathdefault" style="margin-right: 0.13889em;">P</span><span class="mord mathdefault">A</span><span class="mord mathdefault" style="margin-right: 0.13889em;">T</span><span class="mord mathdefault" style="margin-right: 0.08125em;">H</span><span class="mord mathdefault" style="margin-right: 0.13889em;">T</span><span class="mord mathdefault" style="margin-right: 0.10903em;">N</span><span class="mord"><span class="mord mathdefault" style="margin-right: 0.05764em;">S</span><span class="msupsub"><span class="vlist-t vlist-t2"><span class="vlist-r"><span class="vlist" style="height: 0.328331em;"><span class="" style="top: -2.55em; margin-left: -0.05764em; margin-right: 0.05em;"><span class="pstrut" style="height: 2.7em;"></span><span class="sizing reset-size6 size3 mtight"><span class="mord mathdefault mtight">A</span></span></span></span><span class="vlist-s">​</span></span><span class="vlist-r"><span class="vlist" style="height: 0.15em;"><span class=""></span></span></span></span></span></span><span class="mord mathdefault" style="margin-right: 0.02778em;">D</span><span class="mord mathdefault" style="margin-right: 0.10903em;">M</span><span class="mord mathdefault" style="margin-right: 0.07847em;">I</span><span class="mord mathdefault" style="margin-right: 0.10903em;">N</span><span class="mspace" style="margin-right: 0.277778em;"></span><span class="mrel">=</span></span></span></span></span>ORACLE_HOME/network/admin<br> LD_LIBRARY_PATH=<span class="katex--inline"><span class="katex"><span class="katex-mathml">
    
     
      
       
        O
       
       
        R
       
       
        A
       
       
        C
       
       
        L
       
       
        
         E
        
        
         H
        
       
       
        O
       
       
        M
       
       
        E
       
       
        /
       
       
        l
       
       
        i
       
       
        b
       
       
        :
       
       
        /
       
       
        l
       
       
        i
       
       
        b
       
       
        :
       
       
        /
       
       
        u
       
       
        s
       
       
        r
       
       
        /
       
       
        l
       
       
        i
       
       
        b
       
       
        ;
       
       
        e
       
       
        x
       
       
        p
       
       
        o
       
       
        r
       
       
        t
       
       
        L
       
       
        
         D
        
        
         L
        
       
       
        I
       
       
        B
       
       
        R
       
       
        A
       
       
        R
       
       
        
         Y
        
        
         P
        
       
       
        A
       
       
        T
       
       
        H
       
       
        C
       
       
        L
       
       
        A
       
       
        S
       
       
        S
       
       
        P
       
       
        A
       
       
        T
       
       
        H
       
       
        =
       
      
      
       ORACLE_HOME/lib:/lib:/usr/lib; export LD_LIBRARY_PATH CLASSPATH=
      
     
    </span><span class="katex-html"><span class="base"><span class="strut" style="height: 1em; vertical-align: -0.25em;"></span><span class="mord mathdefault" style="margin-right: 0.02778em;">O</span><span class="mord mathdefault" style="margin-right: 0.00773em;">R</span><span class="mord mathdefault">A</span><span class="mord mathdefault" style="margin-right: 0.07153em;">C</span><span class="mord mathdefault">L</span><span class="mord"><span class="mord mathdefault" style="margin-right: 0.05764em;">E</span><span class="msupsub"><span class="vlist-t vlist-t2"><span class="vlist-r"><span class="vlist" style="height: 0.328331em;"><span class="" style="top: -2.55em; margin-left: -0.05764em; margin-right: 0.05em;"><span class="pstrut" style="height: 2.7em;"></span><span class="sizing reset-size6 size3 mtight"><span class="mord mathdefault mtight" style="margin-right: 0.08125em;">H</span></span></span></span><span class="vlist-s">​</span></span><span class="vlist-r"><span class="vlist" style="height: 0.15em;"><span class=""></span></span></span></span></span></span><span class="mord mathdefault" style="margin-right: 0.02778em;">O</span><span class="mord mathdefault" style="margin-right: 0.10903em;">M</span><span class="mord mathdefault" style="margin-right: 0.05764em;">E</span><span class="mord">/</span><span class="mord mathdefault" style="margin-right: 0.01968em;">l</span><span class="mord mathdefault">i</span><span class="mord mathdefault">b</span><span class="mspace" style="margin-right: 0.277778em;"></span><span class="mrel">:</span><span class="mspace" style="margin-right: 0.277778em;"></span></span><span class="base"><span class="strut" style="height: 1em; vertical-align: -0.25em;"></span><span class="mord">/</span><span class="mord mathdefault" style="margin-right: 0.01968em;">l</span><span class="mord mathdefault">i</span><span class="mord mathdefault">b</span><span class="mspace" style="margin-right: 0.277778em;"></span><span class="mrel">:</span><span class="mspace" style="margin-right: 0.277778em;"></span></span><span class="base"><span class="strut" style="height: 1em; vertical-align: -0.25em;"></span><span class="mord">/</span><span class="mord mathdefault">u</span><span class="mord mathdefault">s</span><span class="mord mathdefault" style="margin-right: 0.02778em;">r</span><span class="mord">/</span><span class="mord mathdefault" style="margin-right: 0.01968em;">l</span><span class="mord mathdefault">i</span><span class="mord mathdefault">b</span><span class="mpunct">;</span><span class="mspace" style="margin-right: 0.166667em;"></span><span class="mord mathdefault">e</span><span class="mord mathdefault">x</span><span class="mord mathdefault">p</span><span class="mord mathdefault">o</span><span class="mord mathdefault" style="margin-right: 0.02778em;">r</span><span class="mord mathdefault">t</span><span class="mord mathdefault">L</span><span class="mord"><span class="mord mathdefault" style="margin-right: 0.02778em;">D</span><span class="msupsub"><span class="vlist-t vlist-t2"><span class="vlist-r"><span class="vlist" style="height: 0.328331em;"><span class="" style="top: -2.55em; margin-left: -0.02778em; margin-right: 0.05em;"><span class="pstrut" style="height: 2.7em;"></span><span class="sizing reset-size6 size3 mtight"><span class="mord mathdefault mtight">L</span></span></span></span><span class="vlist-s">​</span></span><span class="vlist-r"><span class="vlist" style="height: 0.15em;"><span class=""></span></span></span></span></span></span><span class="mord mathdefault" style="margin-right: 0.07847em;">I</span><span class="mord mathdefault" style="margin-right: 0.05017em;">B</span><span class="mord mathdefault" style="margin-right: 0.00773em;">R</span><span class="mord mathdefault">A</span><span class="mord mathdefault" style="margin-right: 0.00773em;">R</span><span class="mord"><span class="mord mathdefault" style="margin-right: 0.22222em;">Y</span><span class="msupsub"><span class="vlist-t vlist-t2"><span class="vlist-r"><span class="vlist" style="height: 0.328331em;"><span class="" style="top: -2.55em; margin-left: -0.22222em; margin-right: 0.05em;"><span class="pstrut" style="height: 2.7em;"></span><span class="sizing reset-size6 size3 mtight"><span class="mord mathdefault mtight" style="margin-right: 0.13889em;">P</span></span></span></span><span class="vlist-s">​</span></span><span class="vlist-r"><span class="vlist" style="height: 0.15em;"><span class=""></span></span></span></span></span></span><span class="mord mathdefault">A</span><span class="mord mathdefault" style="margin-right: 0.13889em;">T</span><span class="mord mathdefault" style="margin-right: 0.08125em;">H</span><span class="mord mathdefault" style="margin-right: 0.07153em;">C</span><span class="mord mathdefault">L</span><span class="mord mathdefault">A</span><span class="mord mathdefault" style="margin-right: 0.05764em;">S</span><span class="mord mathdefault" style="margin-right: 0.05764em;">S</span><span class="mord mathdefault" style="margin-right: 0.13889em;">P</span><span class="mord mathdefault">A</span><span class="mord mathdefault" style="margin-right: 0.13889em;">T</span><span class="mord mathdefault" style="margin-right: 0.08125em;">H</span><span class="mspace" style="margin-right: 0.277778em;"></span><span class="mrel">=</span></span></span></span></span>ORACLE_HOME/jlib:$ORACLE_HOME/rdbms/jlib; export CLASSPATH</p> 
<p>if [ $USER = “oracle” ]; then<br> if [ $SHELL = “/bin/ksh” ]; then<br> ulimit -p 16384<br> ulimit -n 65536<br> else<br> ulimit -u 16384 -n 65536<br> fi<br> fi</p> 
<p>注意：以下几点：</p> 
<p>XE版本里只能有一个instance， 我将SID修改了以后貌似会报错，所以SID就不用修改了。</p> 
<p>BASE和HOME两个变量后尽量不要加斜线 ‘/’ ,有可能会报错，虽然不知到为什么… 同时，TNS_ADMIN这个变量一定要有。</p> 
<p>修改完后使用命令 # source /etc/profile 重新加载改文件。</p> 
<p>输入 echo $ORACLE_BASE修改是否成功。</p> 
<p>5.初始化数据库：</p> 
<h1><a id="su_Oracle_152"></a>su Oracle</h1> 
<p>如果不知道密码 可以用 # passwd oracle重新设置</p> 
<p>修改init.ora：</p> 
<p>cd /u01/app/oracle/product/11.2.0/xe/dbs/</p> 
<p>cp init.ora initXE.ora</p> 
<p>vi initXE.ora</p> 
<p>将该文件修改成如下内容：</p> 
<p>db_name=‘XE’<br> memory_target=1G<br> processes = 150<br> audit_file_dest=’/u01/app/oracle/admin/orcl/adump’<br> audit_trail =‘db’<br> db_block_size=8192<br> db_domain=’’<br> db_recovery_file_dest=’/u01/app/oracle/fast_recovery_area’<br> db_recovery_file_dest_size=2G<br> diagnostic_dest=’/u01/app/oracle’<br> dispatchers=’(PROTOCOL=TCP) (SERVICE=ORCLXDB)’<br> open_cursors=300<br> remote_login_passwordfile=‘EXCLUSIVE’<br> undo_tablespace=‘UNDOTBS1’</p> 
<h1><a id="You_may_want_to_ensure_that_control_files_are_created_on_separate_physical_180"></a>You may want to ensure that control files are created on separate physical</h1> 
<h1><a id="devices_181"></a>devices</h1> 
<p>control_files = (’/u01/app/oracle/oradata/’, ‘/u01/app/oracle/oradata/’)<br> compatible =‘11.2.0’</p> 
<p>切换到oracle用户 使用sqlplus链接数据库</p> 
<p>sqlplus /nolog</p> 
<p>进入sqlplus控制台</p> 
<p>SQL&gt; connect as sysdba</p> 
<p>提示输入用户名密码： 使用sys/password登录</p> 
<p>启动并装载数据库</p> 
<p>SQL&gt; startup mount</p> 
<p>11g xe版本已经内置了一个设置好的数据库 XE， 因此不许要手动创建数据库，但是需要初始化数据库结构</p> 
<p>运行一下两行代码：</p> 
<p>SQL&gt; @?/rdbms/admin/catalog.sql<br> SQL&gt; @?/rdbms/admin/catproc.sql</p> 
<p>等待出现提示complete之后，进行下一步。</p> 
<p>如果运行过程中出现database didn‘t open 则需要重新启动并装载数据库。 【Linux公社 http://www.linuxidc.com 】</p> 
<p>接下来创建用户，初始数据库中应当已经存在users表，因此直接插入数据就可以了：</p> 
<p>SQL&gt; create user myaccount<br> 2 identified by “mypassword”<br> 3 default tablespace users;</p> 
<p>授权用户：</p> 
<p>SQL&gt; grant dba to myaccount;</p> 
<p>之后可以exit然后用该用户登录。</p> 
<p>插表测试：</p> 
<p>SQL&gt; create table test_table (txt varchar2(100) not null);<br> SQL&gt; insert into test_table values(‘Hello world !’);</p> 
<p>插入数据成功后查询</p> 
<p>SQL&gt; select * from test_table；</p> 
<p>如果查询成功，那么恭喜你，大功告成了！</p> 
<p>6.oracle启动关闭简单步骤</p> 
<p>a.启动监听与数据库</p> 
<h1><a id="su_oracle_243"></a>su oracle</h1> 
<p>bash-4.1$ lsnrctl start</p> 
<p>b.启动数据库：<br> su oracle<br> bash-4.1$ sqlplus /nolog</p> 
<p>以sysdba登陆，并执行命令startup<br> SQL&gt; conn /as sysdba<br> Connected to an idle instance.<br> SQL&gt; startup</p> 
<p>c.关闭数据库</p> 
<p>SQL&gt; shutdown immediate</p> 
<p>d.退出sqlplus</p> 
<p>SQL&gt; exit</p> 
<p>bash-4.1$ lsnrctl stop // oracle用户下执行</p> 
<p>7.其它</p> 
<p>web界面：http://127.0.0.1:8080/apex</p> 
<p>手工启动和关闭Oracle XE的命令是</p> 
<p>/etc/init.d/oracle-xe start</p> 
<p>/etc/init.d/oracle-xe stop</p> 
<p>注：在Linux的应用程序菜单中有oracle的一些选项，可进行图形化的操作</p>
                
{% endraw %}
