---
title: ccxt 中文接口文档---（数据结构篇）（一）
date: 2019-09-23 08:06:54
layout: post
author: 刘泽美
categories:
  - CSDN文章
  - 导入
tags: 代码人生
---

[原链接](https://blog.csdn.net/weixin_41884153/article/details/101190821)
{% raw %}

                    <svg xmlns="http://www.w3.org/2000/svg" style="display: none;">
                        <path stroke-linecap="round" d="M5,0 0,2.5 5,5z" id="raphael-marker-block" style="-webkit-tap-highlight-color: rgba(0, 0, 0, 0);"></path>
                    </svg>
                    <h1><a id="ccxtapi_1"></a>ccxt：神器级的数字货币万能api接口</h1> 
<blockquote> 
 <p>此文档为 ccxt 的详细接口解释文档，仅做学习用途。</p> 
</blockquote> 
<p>先简单介绍下ccxt</p> 
<blockquote> 
 <p>ccxt是一个“all-in-one”一站式数字货币万能api接口模块库，目前支持120多个数字货币交易所，包括币安，火币，okex等等这些国内用户常用的数字货币交易所。</p> 
</blockquote> 
<blockquote> 
 <p>下面直接进入正题</p> 
</blockquote> 
<h3><a id="1__12"></a>1. 自有属性</h3> 
<pre><code class="prism language-js"><span class="token keyword">export</span> <span class="token keyword">const</span> version<span class="token punctuation">:</span> string<span class="token punctuation">;</span>  <span class="token comment">// ccxt 的版本号</span>
<span class="token keyword">export</span> <span class="token keyword">const</span> exchanges<span class="token punctuation">:</span> string<span class="token punctuation">[</span><span class="token punctuation">]</span><span class="token punctuation">;</span> <span class="token comment">// ccxt 当前支持的所有交易所</span>
</code></pre> 
<h3><a id="2__23"></a>2. 数据结构（依赖）</h3> 
<blockquote> 
 <ol><li>基础货币：要买入的货币 | 报价货币：要卖出的货币<code>如BTC/USDT = 10000 BTC是基础货币，USDT是报价货币</code></li></ol> 
</blockquote> 
<h4><a id="1___27"></a>1. 基础变量 数据结构</h4> 
<blockquote> 
 <p>该部分暂时不详解，等到介绍交易所数据结构或者使用时再详细解释。</p> 
</blockquote> 
<pre><code class="prism language-js"><span class="token keyword">export</span> <span class="token keyword">interface</span> <span class="token class-name">MinMax</span> <span class="token punctuation">{<!-- --></span>
    max<span class="token punctuation">:</span> number<span class="token punctuation">;</span>
    min<span class="token punctuation">:</span> number<span class="token punctuation">;</span>
<span class="token punctuation">}</span>

<span class="token keyword">export</span> <span class="token keyword">interface</span> <span class="token class-name">Tickers</span> <span class="token punctuation">{<!-- --></span>
    info<span class="token punctuation">:</span> any<span class="token punctuation">;</span> <span class="token comment">// info为交易所返回的原始信息（以下都是）</span>
    <span class="token punctuation">[</span>symbol<span class="token punctuation">:</span> string<span class="token punctuation">]</span><span class="token punctuation">:</span> Ticker<span class="token punctuation">;</span> <span class="token comment">// 行情信息（详情见下文）</span>
<span class="token punctuation">}</span>

<span class="token keyword">export</span> <span class="token keyword">interface</span> <span class="token class-name">Currency</span> <span class="token punctuation">{<!-- --></span>
    id<span class="token punctuation">:</span> string<span class="token punctuation">;</span> 
    code<span class="token punctuation">:</span> string<span class="token punctuation">;</span>
<span class="token punctuation">}</span>

<span class="token keyword">export</span> <span class="token keyword">interface</span> <span class="token class-name">Balance</span> <span class="token punctuation">{<!-- --></span>
    free<span class="token punctuation">:</span> number<span class="token punctuation">;</span>
    used<span class="token punctuation">:</span> number<span class="token punctuation">;</span>
    total<span class="token punctuation">:</span> number<span class="token punctuation">;</span>
<span class="token punctuation">}</span>

<span class="token keyword">export</span> <span class="token keyword">interface</span> <span class="token class-name">PartialBalances</span> <span class="token punctuation">{<!-- --></span>
    <span class="token punctuation">[</span>currency<span class="token punctuation">:</span> string<span class="token punctuation">]</span><span class="token punctuation">:</span> number<span class="token punctuation">;</span>
<span class="token punctuation">}</span>

<span class="token keyword">export</span> <span class="token keyword">interface</span> <span class="token class-name">Balances</span> <span class="token punctuation">{<!-- --></span>
    info<span class="token punctuation">:</span> any<span class="token punctuation">;</span>
    <span class="token punctuation">[</span>key<span class="token punctuation">:</span> string<span class="token punctuation">]</span><span class="token punctuation">:</span> Balance<span class="token punctuation">;</span>
<span class="token punctuation">}</span>

<span class="token keyword">export</span> <span class="token keyword">interface</span> <span class="token class-name">DepositAddress</span> <span class="token punctuation">{<!-- --></span>
    currency<span class="token punctuation">:</span> string<span class="token punctuation">;</span>
    address<span class="token punctuation">:</span> string<span class="token punctuation">;</span>
    status<span class="token punctuation">:</span> string<span class="token punctuation">;</span>
    info<span class="token punctuation">:</span> any<span class="token punctuation">;</span>
<span class="token punctuation">}</span>

<span class="token keyword">export</span> <span class="token keyword">interface</span> <span class="token class-name">Fee</span> <span class="token punctuation">{<!-- --></span>
    type<span class="token punctuation">:</span> <span class="token string">'taker'</span> <span class="token operator">|</span> <span class="token string">'maker'</span><span class="token punctuation">;</span>
    currency<span class="token punctuation">:</span> string<span class="token punctuation">;</span>
    rate<span class="token punctuation">:</span> number<span class="token punctuation">;</span>
    cost<span class="token punctuation">:</span> number<span class="token punctuation">;</span>
<span class="token punctuation">}</span>

<span class="token keyword">export</span> <span class="token keyword">interface</span> <span class="token class-name">WithdrawalResponse</span> <span class="token punctuation">{<!-- --></span>
    info<span class="token punctuation">:</span> any<span class="token punctuation">;</span>
    id<span class="token punctuation">:</span> string<span class="token punctuation">;</span>
<span class="token punctuation">}</span>

<span class="token keyword">export</span> <span class="token keyword">interface</span> <span class="token class-name">DepositAddressResponse</span> <span class="token punctuation">{<!-- --></span>
    currency<span class="token punctuation">:</span> string<span class="token punctuation">;</span>
    address<span class="token punctuation">:</span> string<span class="token punctuation">;</span>
    info<span class="token punctuation">:</span> any<span class="token punctuation">;</span>
    tag<span class="token operator">?</span><span class="token punctuation">:</span> string<span class="token punctuation">;</span>
<span class="token punctuation">}</span>

<span class="token comment">// timestamp, open, high, low, close, volume</span>
<span class="token keyword">export</span> type <span class="token constant">OHLCV</span> <span class="token operator">=</span> <span class="token punctuation">[</span>number<span class="token punctuation">,</span> number<span class="token punctuation">,</span> number<span class="token punctuation">,</span> number<span class="token punctuation">,</span> number<span class="token punctuation">,</span> number<span class="token punctuation">]</span><span class="token punctuation">;</span>

</code></pre> 
<h4><a id="2___91"></a>2. 交易对 数据结构</h4> 
<p>原版接口：</p> 
<pre><code class="prism language-js"><span class="token keyword">export</span> <span class="token keyword">interface</span> <span class="token class-name">Market</span> <span class="token punctuation">{<!-- --></span>
    <span class="token punctuation">[</span>key<span class="token punctuation">:</span> string<span class="token punctuation">]</span><span class="token punctuation">:</span> any
    id<span class="token punctuation">:</span> string<span class="token punctuation">;</span>
    symbol<span class="token punctuation">:</span> string<span class="token punctuation">;</span>
    base<span class="token punctuation">:</span> string<span class="token punctuation">;</span>
    quote<span class="token punctuation">:</span> string<span class="token punctuation">;</span>
    active<span class="token punctuation">:</span> boolean<span class="token punctuation">;</span>
    precision<span class="token punctuation">:</span> <span class="token punctuation">{<!-- --></span> amount<span class="token punctuation">:</span> number<span class="token punctuation">,</span> price<span class="token punctuation">:</span> number<span class="token punctuation">,</span> cost<span class="token punctuation">:</span> number <span class="token punctuation">}</span><span class="token punctuation">;</span>
    limits<span class="token punctuation">:</span> <span class="token punctuation">{<!-- --></span> amount<span class="token punctuation">:</span> MinMax<span class="token punctuation">,</span> price<span class="token punctuation">:</span> MinMax<span class="token punctuation">,</span> cost<span class="token operator">?</span><span class="token punctuation">:</span> MinMax <span class="token punctuation">}</span><span class="token punctuation">;</span>
    info<span class="token punctuation">:</span> any<span class="token punctuation">;</span>
<span class="token punctuation">}</span>
</code></pre> 
<p>接口介绍：</p> 
<pre><code class="prism language-js">
<span class="token punctuation">{<!-- --></span>
    <span class="token string">'id'</span><span class="token punctuation">:</span>     <span class="token string">' btcusd'</span><span class="token punctuation">,</span>  <span class="token comment">// 在交易中引用的代币字符串</span>
    <span class="token string">'symbol'</span><span class="token punctuation">:</span>  <span class="token string">'BTC/USD'</span><span class="token punctuation">,</span> <span class="token comment">// 一对货币的大写字符串文字</span>
    <span class="token string">'base'</span><span class="token punctuation">:</span>    <span class="token string">'BTC'</span><span class="token punctuation">,</span>     <span class="token comment">// 大写字符串。统一的基本货币代码</span>
    <span class="token string">'quote'</span><span class="token punctuation">:</span>   <span class="token string">'USD'</span><span class="token punctuation">,</span>     <span class="token comment">// 大写字符串。统一的报价货币代码</span>
    <span class="token string">'active'</span><span class="token punctuation">:</span> <span class="token boolean">true</span><span class="token punctuation">,</span>       <span class="token comment">// 布尔值。 市场的状态</span>
    <span class="token string">'precision'</span><span class="token punctuation">:</span> <span class="token punctuation">{<!-- --></span>        <span class="token comment">// 小数点后的小数位数（精度）</span>
        <span class="token string">'price'</span><span class="token punctuation">:</span> <span class="token number">8</span><span class="token punctuation">,</span>       <span class="token comment">// 整型。 如果交易所不支持，则可能丢失精度</span>
        <span class="token string">'amount'</span><span class="token punctuation">:</span> <span class="token number">8</span><span class="token punctuation">,</span>      <span class="token comment">// 整型。 如果交易所不支持，则可能丢失精度</span>
        <span class="token string">'cost'</span><span class="token punctuation">:</span> <span class="token number">8</span><span class="token punctuation">,</span>        <span class="token comment">// 整型。 很少交易所支持</span>
    <span class="token punctuation">}</span><span class="token punctuation">,</span>
    <span class="token string">'limits'</span><span class="token punctuation">:</span> <span class="token punctuation">{<!-- --></span>           <span class="token comment">// 下单限制</span>
        <span class="token string">'amount'</span><span class="token punctuation">:</span> <span class="token punctuation">{<!-- --></span>
            <span class="token string">'min'</span><span class="token punctuation">:</span> <span class="token number">0.01</span><span class="token punctuation">,</span>  <span class="token comment">// 订单数量应该大于这个值</span>
            <span class="token string">'max'</span><span class="token punctuation">:</span> <span class="token number">1000</span><span class="token punctuation">,</span>  <span class="token comment">// 订单数量应该小于这个值</span>
        <span class="token punctuation">}</span><span class="token punctuation">,</span>
        <span class="token string">'price'</span><span class="token punctuation">:</span> <span class="token punctuation">{<!-- --></span> <span class="token operator">...</span> <span class="token punctuation">}</span><span class="token punctuation">,</span> <span class="token comment">// 同上的min/max 表示订单的最高价和最低价</span>
        <span class="token string">'cost'</span><span class="token punctuation">:</span>  <span class="token punctuation">{<!-- --></span> <span class="token operator">...</span> <span class="token punctuation">}</span><span class="token punctuation">,</span> <span class="token comment">// 同上的min/max 表示订单的金额(amount * price)</span>
    <span class="token punctuation">}</span><span class="token punctuation">,</span>
    <span class="token string">'info'</span><span class="token punctuation">:</span>      <span class="token punctuation">{<!-- --></span> <span class="token operator">...</span> <span class="token punctuation">}</span><span class="token punctuation">,</span> <span class="token comment">// 交易所原始未解析的市场信息</span>
<span class="token punctuation">}</span>
</code></pre> 
<h4><a id="3___136"></a>3. 订单 数据结构</h4> 
<pre><code class="prism language-js"><span class="token keyword">export</span> <span class="token keyword">interface</span> <span class="token class-name">Order</span> <span class="token punctuation">{<!-- --></span>
    id<span class="token punctuation">:</span> string<span class="token punctuation">;</span>
    datetime<span class="token punctuation">:</span> string<span class="token punctuation">;</span>
    timestamp<span class="token punctuation">:</span> number<span class="token punctuation">;</span>
    lastTradeTimestamp<span class="token punctuation">:</span> number<span class="token punctuation">;</span>
    status<span class="token punctuation">:</span> <span class="token string">'open'</span> <span class="token operator">|</span> <span class="token string">'closed'</span> <span class="token operator">|</span> <span class="token string">'canceled'</span><span class="token punctuation">;</span>
    symbol<span class="token punctuation">:</span> string<span class="token punctuation">;</span>
    type<span class="token punctuation">:</span> <span class="token string">'market'</span> <span class="token operator">|</span> <span class="token string">'limit'</span><span class="token punctuation">;</span>
    side<span class="token punctuation">:</span> <span class="token string">'buy'</span> <span class="token operator">|</span> <span class="token string">'sell'</span><span class="token punctuation">;</span>
    price<span class="token punctuation">:</span> number<span class="token punctuation">;</span>
    amount<span class="token punctuation">:</span> number<span class="token punctuation">;</span>
    filled<span class="token punctuation">:</span> number<span class="token punctuation">;</span>
    remaining<span class="token punctuation">:</span> number<span class="token punctuation">;</span>
    cost<span class="token punctuation">:</span> number<span class="token punctuation">;</span>
    trades<span class="token punctuation">:</span> Trade<span class="token punctuation">[</span><span class="token punctuation">]</span><span class="token punctuation">;</span>
    fee<span class="token punctuation">:</span> Fee<span class="token punctuation">;</span>
    info<span class="token punctuation">:</span> <span class="token punctuation">{<!-- --></span><span class="token punctuation">}</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span>
</code></pre> 
<p>接口介绍：</p> 
<pre><code class="prism language-js"><span class="token punctuation">{<!-- --></span>
    <span class="token string">'id'</span><span class="token punctuation">:</span> <span class="token string">'12345-67890:09876/54321'</span><span class="token punctuation">,</span> <span class="token comment">// 订单的唯一标识</span>
    <span class="token string">'datetime'</span><span class="token punctuation">:</span> <span class="token string">'2017-08-17 12:42:48.000'</span><span class="token punctuation">,</span> <span class="token comment">// ISO8601 时间戳</span>
    <span class="token string">'timestamp'</span><span class="token punctuation">:</span> <span class="token number">1502962946216</span><span class="token punctuation">,</span> <span class="token comment">// 时间戳</span>
    <span class="token string">'lastTradeTimestamp'</span><span class="token punctuation">:</span> <span class="token number">1502962956216</span><span class="token punctuation">,</span> <span class="token comment">// 此订单上最后交易的时间戳</span>
    <span class="token string">'status'</span><span class="token punctuation">:</span> <span class="token string">'open'</span><span class="token punctuation">,</span>         <span class="token comment">// 'open', 'closed', 'canceled'  //订单状态：分别为：打开/关闭/取消</span>
    <span class="token string">'symbol'</span><span class="token punctuation">:</span> <span class="token string">'ETH/BTC'</span><span class="token punctuation">,</span>      <span class="token comment">// 交易对信息</span>
    <span class="token string">'type'</span><span class="token punctuation">:</span> <span class="token string">'limit'</span><span class="token punctuation">,</span>        <span class="token comment">// 'market', 'limit'  //  交易方式： 市价交易   现价交易</span>
    <span class="token string">'side'</span><span class="token punctuation">:</span> <span class="token string">'buy'</span><span class="token punctuation">,</span>          <span class="token comment">// 'buy', 'sell' // 交易方向： 买入 卖出</span>
    <span class="token string">'price'</span><span class="token punctuation">:</span> <span class="token number">0.06917684</span><span class="token punctuation">,</span>    <span class="token comment">// 基础货币/报价货币  的浮动价格</span>
    <span class="token string">'amount'</span><span class="token punctuation">:</span> <span class="token number">1.5</span><span class="token punctuation">,</span>           <span class="token comment">// 下单数量（基于报价货币）</span>
    <span class="token string">'filled'</span><span class="token punctuation">:</span> <span class="token number">1.1</span><span class="token punctuation">,</span>           <span class="token comment">// 成交数量（基于报价货币）</span>
    <span class="token string">'remaining'</span><span class="token punctuation">:</span> <span class="token number">0.4</span><span class="token punctuation">,</span>           <span class="token comment">// 未成交数量（基于报价货币）</span>
    <span class="token string">'cost'</span><span class="token punctuation">:</span> <span class="token number">0.076094524</span><span class="token punctuation">,</span>   <span class="token comment">// 'filled' * 'price' (总花费金额（基于报价货币）)</span>
    <span class="token string">'trades'</span><span class="token punctuation">:</span> <span class="token punctuation">[</span><span class="token operator">...</span> <span class="token punctuation">]</span><span class="token punctuation">,</span>         <span class="token comment">// 这笔订单交易执行的列表（可能有多笔交易）</span>
    <span class="token string">'fee'</span><span class="token punctuation">:</span> <span class="token punctuation">{<!-- --></span>                      <span class="token comment">// 手续费</span>
        <span class="token string">'currency'</span><span class="token punctuation">:</span> <span class="token string">'BTC'</span><span class="token punctuation">,</span>        <span class="token comment">// 手续费计价货币（通常是报价）</span>
        <span class="token string">'cost'</span><span class="token punctuation">:</span> <span class="token number">0.0009</span><span class="token punctuation">,</span>           <span class="token comment">// 实际手续费用</span>
        <span class="token string">'rate'</span><span class="token punctuation">:</span> <span class="token number">0.002</span><span class="token punctuation">,</span>            <span class="token comment">// 费率</span>
    <span class="token punctuation">}</span><span class="token punctuation">,</span>
    <span class="token string">'info'</span><span class="token punctuation">:</span> <span class="token punctuation">{<!-- --></span> <span class="token operator">...</span> <span class="token punctuation">}</span><span class="token punctuation">,</span>              <span class="token comment">// 原始未解析的数据</span>
<span class="token punctuation">}</span>
</code></pre> 
<h4><a id="4___186"></a>4. 订单列表 数据结构</h4> 
<pre><code class="prism language-js"><span class="token keyword">export</span> <span class="token keyword">interface</span> <span class="token class-name">OrderBook</span> <span class="token punctuation">{<!-- --></span>
    asks<span class="token punctuation">:</span> <span class="token punctuation">[</span>number<span class="token punctuation">,</span> number<span class="token punctuation">]</span><span class="token punctuation">[</span><span class="token punctuation">]</span><span class="token punctuation">;</span>
    bids<span class="token punctuation">:</span> <span class="token punctuation">[</span>number<span class="token punctuation">,</span> number<span class="token punctuation">]</span><span class="token punctuation">[</span><span class="token punctuation">]</span><span class="token punctuation">;</span>
    datetime<span class="token punctuation">:</span> string<span class="token punctuation">;</span>
    timestamp<span class="token punctuation">:</span> number<span class="token punctuation">;</span>
    nonce<span class="token punctuation">:</span> number<span class="token punctuation">;</span>
<span class="token punctuation">}</span>
</code></pre> 
<p>接口介绍：</p> 
<pre><code class="prism language-js"><span class="token punctuation">{<!-- --></span>
    <span class="token string">'asks'</span><span class="token punctuation">:</span> <span class="token punctuation">[</span> <span class="token comment">// 询问价格 -&gt; 买入价格 （询问数组）</span>
        <span class="token punctuation">[</span> price<span class="token punctuation">,</span> amount <span class="token punctuation">]</span><span class="token punctuation">,</span> <span class="token comment">// 价格 , 数量</span>
        <span class="token punctuation">[</span> price<span class="token punctuation">,</span> amount <span class="token punctuation">]</span><span class="token punctuation">,</span>
        <span class="token operator">...</span>
    <span class="token punctuation">]</span><span class="token punctuation">,</span>
    <span class="token string">'bids'</span><span class="token punctuation">:</span> <span class="token punctuation">[</span> <span class="token comment">// 投标价格 -&gt; 卖出价格</span>
        <span class="token punctuation">[</span> price<span class="token punctuation">,</span> amount <span class="token punctuation">]</span><span class="token punctuation">,</span> <span class="token comment">// [ float, float ]</span>
        <span class="token punctuation">[</span> price<span class="token punctuation">,</span> amount <span class="token punctuation">]</span><span class="token punctuation">,</span>
        <span class="token operator">...</span>
    <span class="token punctuation">]</span><span class="token punctuation">,</span>
    <span class="token string">'timestamp'</span><span class="token punctuation">:</span> <span class="token number">1499280391811</span><span class="token punctuation">,</span> <span class="token comment">// Unix Timestamp in milliseconds (seconds * 1000)</span>
    <span class="token string">'datetime'</span><span class="token punctuation">:</span> <span class="token string">'2017-07-05T18:47:14.692Z'</span><span class="token punctuation">,</span> <span class="token comment">// ISO8601 datetime string with milliseconds</span>
<span class="token punctuation">}</span>
</code></pre> 
<blockquote> 
 <p>价格和金额是浮动的。投标数组按价格降序排列。最佳(最高)投标价格是第一个要素，最差(最低)投标价格是最后一个要素。询问数组按价格升序排序。最佳(最低)要价是第一个要素，最差(最高)要价是最后一个要素。如果在交易所的订单簿中没有对应的订单，则出价/要价数组可以为空。</p> 
</blockquote> 
<blockquote> 
 <p>交易所可能会返回各个层次的订单堆栈的详细信息以供分析。它要么包含每个订单的详细信息，要么包含稍微少一点的详细信息，其中订单按价格和数量进行分组和合并。拥有更多的细节需要更多的流量和带宽，一般来说速度较慢，但具有更高的精度。拥有更少的细节通常更快，但在某些非常特殊的情况下可能还不够。</p> 
</blockquote> 
<h4><a id="5___221"></a>5. 交易信息 数据结构</h4> 
<pre><code class="prism language-js">
<span class="token keyword">export</span> <span class="token keyword">interface</span> <span class="token class-name">Trade</span> <span class="token punctuation">{<!-- --></span>
    amount<span class="token punctuation">:</span> number<span class="token punctuation">;</span>                  <span class="token comment">// amount of base currency</span>
    datetime<span class="token punctuation">:</span> string<span class="token punctuation">;</span>                <span class="token comment">// ISO8601 datetime with milliseconds;</span>
    id<span class="token punctuation">:</span> string<span class="token punctuation">;</span>                      <span class="token comment">// string trade id</span>
    info<span class="token punctuation">:</span> <span class="token punctuation">{<!-- --></span><span class="token punctuation">}</span><span class="token punctuation">;</span>                        <span class="token comment">// the original decoded JSON as is</span>
    order<span class="token operator">?</span><span class="token punctuation">:</span> string<span class="token punctuation">;</span>                  <span class="token comment">// string order id or undefined/None/null</span>
    price<span class="token punctuation">:</span> number<span class="token punctuation">;</span>                   <span class="token comment">// float price in quote currency</span>
    timestamp<span class="token punctuation">:</span> number<span class="token punctuation">;</span>               <span class="token comment">// Unix timestamp in milliseconds</span>
    type<span class="token operator">?</span><span class="token punctuation">:</span> <span class="token string">'market'</span> <span class="token operator">|</span> <span class="token string">'limit'</span><span class="token punctuation">;</span>       <span class="token comment">// order type, 'market', 'limit' or undefined/None/null</span>
    side<span class="token punctuation">:</span> <span class="token string">'buy'</span> <span class="token operator">|</span> <span class="token string">'sell'</span><span class="token punctuation">;</span>            <span class="token comment">// direction of the trade, 'buy' or 'sell'</span>
    symbol<span class="token punctuation">:</span> string<span class="token punctuation">;</span>                  <span class="token comment">// symbol in CCXT format</span>
    takerOrMaker<span class="token punctuation">:</span> <span class="token string">'taker'</span> <span class="token operator">|</span> <span class="token string">'maker'</span><span class="token punctuation">;</span> <span class="token comment">// string, 'taker' or 'maker'</span>
    cost<span class="token punctuation">:</span> number<span class="token punctuation">;</span>                    <span class="token comment">// total cost (including fees), `price * amount`</span>
    fee<span class="token punctuation">:</span> Fee<span class="token punctuation">;</span>
<span class="token punctuation">}</span>
</code></pre> 
<p>接口介绍：</p> 
<pre><code class="prism language-js"><span class="token punctuation">{<!-- --></span>
    <span class="token string">'info'</span><span class="token punctuation">:</span> <span class="token punctuation">{<!-- --></span> <span class="token operator">...</span> <span class="token punctuation">}</span><span class="token punctuation">,</span> <span class="token comment">// 原始的JSON返回信息</span>
    <span class="token string">'id'</span><span class="token punctuation">:</span> <span class="token string">'12345-67890:09876/54321'</span><span class="token punctuation">,</span>  <span class="token comment">// 交易ID</span>
    <span class="token string">'timestamp'</span><span class="token punctuation">:</span> <span class="token number">1502962946216</span><span class="token punctuation">,</span> <span class="token comment">// 时间戳</span>
    <span class="token string">'datetime'</span><span class="token punctuation">:</span> <span class="token string">'2017-08-17 12:42:48.000'</span><span class="token punctuation">,</span>  <span class="token comment">// ISO8601 时间</span>
    <span class="token string">'symbol'</span><span class="token punctuation">:</span> <span class="token string">'ETH/BTC'</span><span class="token punctuation">,</span>   <span class="token comment">// 交易对</span>
    <span class="token string">'order'</span><span class="token punctuation">:</span> <span class="token string">'12345-67890:09876/54321'</span><span class="token punctuation">,</span>  <span class="token comment">// string/None/None/undefined</span>
    <span class="token string">'type'</span><span class="token punctuation">:</span> <span class="token string">'limit'</span><span class="token punctuation">,</span> <span class="token comment">// 订单类型, 'market', 'limit' or undefined/None/null</span>
    <span class="token string">'side'</span><span class="token punctuation">:</span> <span class="token string">'buy'</span><span class="token punctuation">,</span> <span class="token comment">// 交易方向, 'buy' or 'sell'</span>
    <span class="token string">'takerOrMaker'</span><span class="token punctuation">:</span> <span class="token string">'taker'</span><span class="token punctuation">,</span> <span class="token comment">// string, 'taker' or 'maker' 订单接受者 / 订单创建者</span>
    <span class="token string">'price'</span><span class="token punctuation">:</span> <span class="token number">0.06917684</span><span class="token punctuation">,</span>  <span class="token comment">// 基础货币/报价货币 的浮动价格</span>
    <span class="token string">'amount'</span><span class="token punctuation">:</span> <span class="token number">1.5</span><span class="token punctuation">,</span>  <span class="token comment">// 基于报价货币</span>
    <span class="token string">'cost'</span><span class="token punctuation">:</span> <span class="token number">0.10376526</span><span class="token punctuation">,</span> <span class="token comment">// 总花费（包括手续费） price * amount</span>
    <span class="token string">'fee'</span><span class="token punctuation">:</span> <span class="token punctuation">{<!-- --></span> <span class="token comment">// 同上（3.订单接口）</span>
        <span class="token string">'cost'</span><span class="token punctuation">:</span> <span class="token number">0.0015</span><span class="token punctuation">,</span>
        <span class="token string">'currency'</span><span class="token punctuation">:</span> <span class="token string">'ETH'</span><span class="token punctuation">,</span>
        <span class="token string">'rate'</span><span class="token punctuation">:</span> <span class="token number">0.002</span>
    <span class="token punctuation">}</span><span class="token punctuation">,</span>
<span class="token punctuation">}</span>
</code></pre> 
<h4><a id="6___266"></a>6. 行情信息 数据结构</h4> 
<pre><code class="prism language-js"><span class="token keyword">export</span> <span class="token keyword">interface</span> <span class="token class-name">Ticker</span> <span class="token punctuation">{<!-- --></span>
    symbol<span class="token punctuation">:</span> string<span class="token punctuation">;</span>
    info<span class="token punctuation">:</span> object<span class="token punctuation">;</span>
    timestamp<span class="token punctuation">:</span> number<span class="token punctuation">;</span>
    datetime<span class="token punctuation">:</span> string<span class="token punctuation">;</span>
    high<span class="token punctuation">:</span> number<span class="token punctuation">;</span>
    low<span class="token punctuation">:</span> number<span class="token punctuation">;</span>
    bid<span class="token punctuation">:</span> number<span class="token punctuation">;</span>
    bidVolume<span class="token operator">?</span><span class="token punctuation">:</span> number<span class="token punctuation">;</span>
    ask<span class="token punctuation">:</span> number<span class="token punctuation">;</span>
    askVolume<span class="token operator">?</span><span class="token punctuation">:</span> number<span class="token punctuation">;</span>
    vwap<span class="token operator">?</span><span class="token punctuation">:</span> number<span class="token punctuation">;</span>
    open<span class="token operator">?</span><span class="token punctuation">:</span> number<span class="token punctuation">;</span>
    close<span class="token operator">?</span><span class="token punctuation">:</span> number<span class="token punctuation">;</span>
    last<span class="token operator">?</span><span class="token punctuation">:</span> number<span class="token punctuation">;</span>
    previousClose<span class="token operator">?</span><span class="token punctuation">:</span> number<span class="token punctuation">;</span>
    change<span class="token operator">?</span><span class="token punctuation">:</span> number<span class="token punctuation">;</span>
    percentage<span class="token operator">?</span><span class="token punctuation">:</span> number<span class="token punctuation">;</span>
    average<span class="token operator">?</span><span class="token punctuation">:</span> number<span class="token punctuation">;</span>
    quoteVolume<span class="token operator">?</span><span class="token punctuation">:</span> number<span class="token punctuation">;</span>
    baseVolume<span class="token operator">?</span><span class="token punctuation">:</span> number<span class="token punctuation">;</span>
<span class="token punctuation">}</span>
</code></pre> 
<pre><code class="prism language-js"><span class="token punctuation">{<!-- --></span>
    <span class="token string">'symbol'</span><span class="token punctuation">:</span>        <span class="token comment">// eg.('BTC/USD', 'ETH/BTC', ...)</span>
    <span class="token string">'info'</span><span class="token punctuation">:</span>          <span class="token comment">// 交易所API返回原始的数据</span>
    <span class="token string">'timestamp'</span><span class="token punctuation">:</span>     <span class="token comment">// 时间戳</span>
    <span class="token string">'datetime'</span><span class="token punctuation">:</span>      <span class="token comment">//  ISO8601 时间</span>
    <span class="token string">'high'</span><span class="token punctuation">:</span>          float<span class="token punctuation">,</span> <span class="token comment">// 最高价</span>
    <span class="token string">'low'</span><span class="token punctuation">:</span>           float<span class="token punctuation">,</span> <span class="token comment">// 最低价</span>
    <span class="token string">'bid'</span><span class="token punctuation">:</span>           float<span class="token punctuation">,</span> <span class="token comment">// 当前最高买价</span>
    <span class="token string">'bidVolume'</span><span class="token punctuation">:</span>     float<span class="token punctuation">,</span> <span class="token comment">// 最高买价深度(可能为undefined)</span>
    <span class="token string">'ask'</span><span class="token punctuation">:</span>           float<span class="token punctuation">,</span> <span class="token comment">// 当前最高卖价</span>
    <span class="token string">'askVolume'</span><span class="token punctuation">:</span>     float<span class="token punctuation">,</span> <span class="token comment">// 最高卖价深度(可能为undefined)</span>
    <span class="token string">'vwap'</span><span class="token punctuation">:</span>          float<span class="token punctuation">,</span> <span class="token comment">// 成交量加权平均价格</span>
    <span class="token string">'open'</span><span class="token punctuation">:</span>          float<span class="token punctuation">,</span> <span class="token comment">// 开盘价</span>
    <span class="token string">'close'</span><span class="token punctuation">:</span>         float<span class="token punctuation">,</span> <span class="token comment">// 上次成交价格(本期收盘价)</span>
    <span class="token string">'last'</span><span class="token punctuation">:</span>          float<span class="token punctuation">,</span> <span class="token comment">// 与'close'一样，方便复制= =</span>
    <span class="token string">'previousClose'</span><span class="token punctuation">:</span> float<span class="token punctuation">,</span> <span class="token comment">// 前期收市价</span>
    <span class="token string">'change'</span><span class="token punctuation">:</span>        float<span class="token punctuation">,</span> <span class="token comment">// 涨跌金额 (上次成交价-开盘价)</span>
    <span class="token string">'percentage'</span><span class="token punctuation">:</span>    float<span class="token punctuation">,</span> <span class="token comment">// 涨跌幅度 (上次成交价/开盘价 * 100%)</span>
    <span class="token string">'average'</span><span class="token punctuation">:</span>       float<span class="token punctuation">,</span> <span class="token comment">// 平均价格 (上次成交价+开盘价)/2</span>
    <span class="token string">'baseVolume'</span><span class="token punctuation">:</span>    float<span class="token punctuation">,</span> <span class="token comment">// 24小时基本货币交易量</span>
    <span class="token string">'quoteVolume'</span><span class="token punctuation">:</span>   float<span class="token punctuation">,</span> <span class="token comment">// 24小时报价货币交易量</span>
<span class="token punctuation">}</span>
</code></pre> 
<h4><a id="7___319"></a>7. 链上信息 交易结构</h4> 
<pre><code class="prism language-js"><span class="token keyword">export</span> <span class="token keyword">interface</span> <span class="token class-name">Transaction</span> <span class="token punctuation">{<!-- --></span>
    info<span class="token punctuation">:</span> <span class="token punctuation">{<!-- --></span><span class="token punctuation">}</span><span class="token punctuation">;</span>
    id<span class="token punctuation">:</span> string<span class="token punctuation">;</span>
    txid<span class="token operator">?</span><span class="token punctuation">:</span> string<span class="token punctuation">;</span>
    timestamp<span class="token punctuation">:</span> number<span class="token punctuation">;</span>
    datetime<span class="token punctuation">:</span> string<span class="token punctuation">;</span>
    address<span class="token punctuation">:</span> string<span class="token punctuation">;</span>
    type<span class="token punctuation">:</span> <span class="token string">"deposit"</span> <span class="token operator">|</span> <span class="token string">"withdrawal"</span><span class="token punctuation">;</span>
    amount<span class="token punctuation">:</span> number<span class="token punctuation">;</span>
    currency<span class="token punctuation">:</span> string<span class="token punctuation">;</span>
    status<span class="token punctuation">:</span> <span class="token string">"pending"</span> <span class="token operator">|</span> <span class="token string">"ok"</span><span class="token punctuation">;</span>
    updated<span class="token punctuation">:</span> number<span class="token punctuation">;</span>
    fee<span class="token punctuation">:</span> Fee<span class="token punctuation">;</span>
<span class="token punctuation">}</span>
</code></pre> 
<p>接口详情：</p> 
<pre><code class="prism language-js"><span class="token punctuation">{<!-- --></span>
    <span class="token string">'info'</span><span class="token punctuation">:</span>      <span class="token punctuation">{<!-- --></span> <span class="token operator">...</span> <span class="token punctuation">}</span><span class="token punctuation">,</span>    <span class="token comment">// 交易所原始信息</span>
    <span class="token string">'id'</span><span class="token punctuation">:</span>       <span class="token string">'123456'</span><span class="token punctuation">,</span>    <span class="token comment">// 交易所提供的id</span>
    <span class="token string">'txid'</span><span class="token punctuation">:</span>     <span class="token string">'0x68bfb29821c50ca35ef3762f887fd3211e4405aba1a94e448a4f218b850358f0'</span><span class="token punctuation">,</span><span class="token comment">//事务ID</span>
    <span class="token string">'timestamp'</span><span class="token punctuation">:</span> <span class="token number">1534081184515</span><span class="token punctuation">,</span>
    <span class="token string">'datetime'</span><span class="token punctuation">:</span> <span class="token string">'2018-08-12T13:39:44.515Z'</span><span class="token punctuation">,</span>
    <span class="token string">'addressFrom'</span><span class="token punctuation">:</span> <span class="token string">'0x38b1F8644ED1Dbd5DcAedb3610301Bf5fa640D6f'</span><span class="token punctuation">,</span> <span class="token comment">// 发送者</span>
    <span class="token string">'address'</span><span class="token punctuation">:</span>  <span class="token string">'0x02b0a9b7b4cDe774af0f8e47cb4f1c2ccdEa0806'</span><span class="token punctuation">,</span> <span class="token comment">// "from" or "to"</span>
    <span class="token string">'addressTo'</span><span class="token punctuation">:</span> <span class="token string">'0x304C68D441EF7EB0E2c056E836E8293BD28F8129'</span><span class="token punctuation">,</span> <span class="token comment">// 接收者</span>
    <span class="token string">'tagFrom'</span><span class="token punctuation">,</span> <span class="token string">'0xabcdef'</span><span class="token punctuation">,</span> <span class="token comment">// "tag" or "memo" or "payment_id" 与发送者相关</span>
    <span class="token string">'tag'</span><span class="token punctuation">:</span>      <span class="token string">'0xabcdef'</span> <span class="token comment">// "tag" or "memo" or "payment_id" associated with the address</span>
    <span class="token string">'tagTo'</span><span class="token punctuation">:</span> <span class="token string">'0xhijgklmn'</span><span class="token punctuation">,</span> <span class="token comment">// "tag" or "memo" or "payment_id" 与接收者相关</span>
    <span class="token string">'type'</span><span class="token punctuation">:</span>     <span class="token string">'deposit'</span><span class="token punctuation">,</span>   <span class="token comment">// or 'withdrawal', string 存入或者取出</span>
    <span class="token string">'amount'</span><span class="token punctuation">:</span>    <span class="token number">1.2345</span><span class="token punctuation">,</span>     <span class="token comment">// float (不包含手续费)</span>
    <span class="token string">'currency'</span><span class="token punctuation">:</span> <span class="token string">'ETH'</span><span class="token punctuation">,</span>       <span class="token comment">// a common unified currency code, string</span>
    <span class="token string">'status'</span><span class="token punctuation">:</span>   <span class="token string">'pending'</span><span class="token punctuation">,</span>   <span class="token comment">// 'ok', 'failed', 'canceled', string 状态</span>
    <span class="token string">'updated'</span><span class="token punctuation">:</span>   undefined<span class="token punctuation">,</span>  <span class="token comment">// 状态最后更改的UTC时间戳(精确到ms)</span>
    <span class="token string">'comment'</span><span class="token punctuation">:</span>  <span class="token string">'由用于定义的注释或消息'</span><span class="token punctuation">,</span>
    <span class="token string">'fee'</span><span class="token punctuation">:</span> <span class="token punctuation">{<!-- --></span>                 <span class="token comment">// 同上</span>
        <span class="token string">'currency'</span><span class="token punctuation">:</span> <span class="token string">'ETH'</span><span class="token punctuation">,</span>   
        <span class="token string">'cost'</span><span class="token punctuation">:</span> <span class="token number">0.1234</span><span class="token punctuation">,</span>      
        <span class="token string">'rate'</span><span class="token punctuation">:</span> undefined
    <span class="token punctuation">}</span><span class="token punctuation">,</span>
<span class="token punctuation">}</span>
</code></pre> 
<blockquote> 
 <p>最后还有一个最重要的<code>Exchange</code>类的数据格式，下一章再详细翻译</p> 
</blockquote>
                
{% endraw %}
