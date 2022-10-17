# Promise与异步请求

## Promise概念详解

Promise用于处理一个异步请求，提供统一的回调函数接口，不用手写回调。

### Promise对象

<img src="https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Promise/promises.png" alt="img" style="zoom:80%;" />

#### 构造函数

```javascript
let promise = new Promise((resolve, reject) => { ... });
```

- 构造函数接收一个`executor`函数（就是上文的Lambda表达式）作为参数，该函数以resolve和reject作为参数，这两个参数都是函数且**由JS引擎提供（名称不可更改）**
  - 在Promise成功后调用resolve，并将**其操作结果作为参数传递出去**
  - 在Promise失败后调用reject，并将**错误本身作为参数传递出去**
  - 上述参数传递表示对应的回调函数可以获得`res`和`err`作为参数输入
  - Promise创建后executor立即执行
- resolve调用后PromiseState变为fulfilled，PromiseResult变成value
- reject调用后PromiseState变为rejected，PromiseResult变成error
- 函数体中调用定义的`resolve`和`reject`接口表示异步请求状态



#### 属性

- PromiseState
  - pending（待定）
  - fulfilled
  - rejected
- PromiseResut
  - undefined（初始状态）
  - resolve(value)
  - reject(error)

#### 方法

- `Promise.prototype.then(resolve, reject)`
  - 调用then可以为Promise注册两种回调函数，分别在对应**状态转换时**执行
  - then中缺少处理promise对象的函数时就会跳过，直接进入下一层，因此可以缺省参数
  - **then返回的仍是Promise对象**，以此来保证链式传递
  - **【React】使用时应在回调函数体内把得到的返回值更新到状态**
- `Promise.prototype.catch()`
  - 只注册reject调用的回调函数
- `Promise.prototype.finally()`
  - 状态变化时一定会执行，且后续操作不会执行
  - 通常用于收尾工作

### await和async

任意一个名称都是有意义的，先从字面意思来理解。async是“异步”的简写，而await可以认为是async wait的简写。所以应该很好理解async用于申明一个function是异步的，而await用于等待一个异步方法执行完成. 

**await只能出现在async函数中**，如果只能用await调用async则陷入了无意义的 循环调用中，那么async到底有什么用呢？async函数直接调用的返回值是一个**Promise对象**

await等待的实质是一个表达式（不一定是Promise对象），但如果等待的是一个Promise对象则会**阻塞**后面的代码，因此await只能在async里调用

await/async的意义在于优化then链的处理





## Fetch指令

`fetch()`的功能与 XMLHttpRequest 基本相同，但使用Promise，且API封装更加现代化

### 构造函数

```javascript
fetch(url, optionObj)

// 完整API
const response = fetch(url, {
  method: "GET",
  headers: {
    "Content-Type": "text/plain;charset=UTF-8"
  },
  body: undefined,
  referrer: "about:client",
  referrerPolicy: "no-referrer-when-downgrade",
  mode: "cors", 
  credentials: "same-origin",
  cache: "default",
  redirect: "follow",
  integrity: "",
  keepalive: false,
  signal: undefined
});
```

- url是请求的目标链接
- optionObj包含了HTTP请求所需的参数
  - method: 请求方法
    - GET
    - POST
  - headers: HTTP请求标头
  - body

### Response对象

fetch成功后得到的HTTP响应的封装对象，它内部的数据通过Stream接口异步读取

#### 属性

- HTTP Response标头（Headers）
  - Response.headers：返回一个Headers对象，包含以下全部信息
  - Response.ok：返回bool，表示请求是否成功
    - **注意：只有网络错误时才会报错**
  - Response.status：返回int，表示HTTP状态码
  - Response.statusText: 返回string，表示回应信息
  - Response.url: 返回string，表示返回链接
  - Response.redirect：返回bool，表示是否发生过跳转
  - Response.type: 返回string，表示请求类型
    - `basic`：普通请求，即同源请求。
    - `cors`：跨域请求。
    - `error`：网络错误，主要用于 Service Worker。
    - `opaque`：如果`fetch()`请求的`type`属性设为`no-cors`，就会返回这个值，详见请求部分。表示发出的是简单的跨域请求，类似`<form>`表单的那种跨域请求。
    - `opaqueredirect`：如果`fetch()`请求的`redirect`属性设为`manual`，就会返回这个值，详见请求部分。

#### 方法

- 读取内容的方法
  - `response.text()`：得到文本字符串。
  - `response.json()`：得到 JSON 对象。
  - `response.blob()`：得到二进制 Blob 对象（如图片、视频等）
  - `response.formData()`：得到 FormData 表单对象。
  - `response.arrayBuffer()`：得到二进制 ArrayBuffer 对象。

- 克隆方法：Stream 对象只能读取一次，读取完就没了。这意味着，前一节的五个读取方法，只能使用一个，否则会报错，因此需要拷贝
  - `Response.clone()`方法，创建`Response`对象的副本，实现多次读取