# Python 异步

## 多线程 Threading

### 创建线程的方法

- 获得Thread对象：`Thread(target=func)`
- 派生Thread类后再实例化对象

### 相关参数

#### 函数

- `threading.active_count()`：返回当前存活的Thread对象数量。
- `threading.current_thread()`：返回当前线程的Thread对象。
- `threading.enumerate()`：列表形式返回所有存活的Thread对象。
- `threading.main_thread()`：返回主Thread对象。

#### 属性

- `Thread.name`：线程的名字，没有语义，可以相同名称。
- `Thread.ident`：线程标识符，非零整数。
- `Thread.Daemon`：是否为**后台线程**
  - 当程序只剩下一个Deamon Thread时将退出（后台进程不能单独运行）
  - 设置后台进程必须在进程开始运行之前

#### 方法

- `Thread.Daemon`：是否为守护线程。
- `Thread.is_alive()`：是否存活。
- `Thread.start()`：开始线程活动。若多次调用抛出RuntimeError。
- `Thread.run()`：用来重载的，
- `Thread.join(timeout=None)`：让主线程等待（阻塞）子线程运行，直到子线程状态为正常或异常结束
- `Thread(group=None, target=None, name=None, args=(), kwargs={}, *, deamon=None)`：构造函数。

### 线程安全

一个线程安全的类具有以下特征，通常采用加锁的方式实现资源管理

- 该类的对象可以被多个线程安全地访问
- 每个线程在调用该对象的任意方法后，都将得到正确的结果
- 每个线程在调用该对象的任意方法后，该对象都依然保持合理的状态

#### Lock 和 RLock（重入锁）

Python的threading模块中有**Lock**和**RLock**两个类

- 获取锁（控制权）：`Lock.acquire(blocking=True, timeout=-1)`
  - 返回True/False
  - timeout为等待时间
  - blocking为是否阻塞调用（True时得不到锁就阻塞进程）
- 释放锁：`Lock.release()`
  - 普通Lock可以被任意线程解锁
  - RLock只能被上锁那个线程解锁，否则引发RE



## 多进程 Process

### 线程和进程的区别

- 进程是操作系统分配资源的最小单元, 线程是操作系统调度的最小单元
- 一个应用程序至少包括1个进程，而1个进程包括1个或多个线程
- 每个进程在执行过程中拥有独立的内存单元，而一个线程的多个线程在执行过程中共享内存