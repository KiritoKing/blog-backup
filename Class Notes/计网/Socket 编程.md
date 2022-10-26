---
title: Socket 套接字编程
date: 2022-10-17 19:56
---

# Socket （套接字）

Socket是对网络中不同主机上的**应用进程**之间进行双向通信的端点的抽象



## 概念

一个Socket就是网络通信进程的一端，提供了应用层进程与网络协议交换数据的机制，上联应用进程，下联网络协议栈。

表示方法：`Socket = (IP Address: Port)`

### 主要类型

- 流套接字（SOCK_STREAM）
- 数据报套接字（SOCK_DGRAM）
- 原始套接字（SOCK_RAW）

### 工作流程

1. 服务器监听
2. 客户端请求
3. 连接确认



## JavaScript中的 `WebSocket`

