# 浏览器环境（Window）下提供的API

TODO：找到Node环境下的替代

## LocalStorage

`window.localStorage` 属性允许用户访问一个Document源的对象Storage，存储的数据将保存在浏览器会话（当前域名下）中。

`localStorage` 类似 `sessionStorage`，但其区别在于：存储在 `localStorage` 的数据可以长期保留；而当页面会话结束——也就是说，当页面被关闭时，存储在 `sessionStorage` 的数据会被清除。

- `Storage.setItem()` 增加一个数据项目
- `Storage.getItem()` 读取一个数据项目
- `Storage.removeItem()` 移除一个数据项目

## SessionStorage

`window.sessionStorage`属性允许你访问一个，对应当前源的 session [`Storage`](https://developer.mozilla.org/zh-CN/docs/Web/API/Storage) 对象。它与 [`localStorage`](https://developer.mozilla.org/zh-CN/docs/Web/API/Window/localStorage) 相似，不同之处在于 `localStorage` 里面存储的数据没有过期时间设置，而存储在 `sessionStorage` 里面的数据在页面会话结束时会被清除。

在新标签或窗口打开一个页面时会复制顶级浏览会话的上下文作为新会话的上下文，这点和 session cookies 的运行方式不同。

打开多个相同的 URL 的 Tabs 页面，会创建各自的 `sessionStorage`；关闭对应浏览器标签或窗口，会清除对应的 `sessionStorage`。

**其余语法与localStorage一致**



## HTTP Cookie

HTTP Cookie（也叫 Web Cookie 或浏览器 Cookie）是服务器发送到用户浏览器并保存在本地的一小块数据，它会在浏览器下次向同一服务器再发起请求时被携带并发送到服务器上。通常，它用于告知服务端两个请求是否来自同一浏览器，如保持用户的登录状态。Cookie 使基于[无状态](https://developer.mozilla.org/zh-CN/docs/Web/HTTP/Overview#http_is_stateless_but_not_sessionless)的 HTTP 协议记录稳定的状态信息成为了可能。

Cookie 主要用于以下三个方面：

- 会话状态管理（如用户登录状态、购物车、游戏分数或其它需要记录的信息）
- 个性化设置（如用户自定义设置、主题等）
- 浏览器行为跟踪（如跟踪分析用户行为等）

