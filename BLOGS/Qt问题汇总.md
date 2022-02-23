# 测试环境
Win11 + AMD R9 + Visual Studio 2021 + QT 6.2.1

---

# Q1：Visual Studio 环境生成报错

默认设置生成WidgetAPP后VS会报一大堆错误，进行以下设置后可以正常生成（不能消除所有错误）
- 解决方案属性 → 常规 → C++标准 改为 "ISO C++ 17 标准"
- 解决方案属性 → 命令行 → 其他选项添加 /Zc:__cplusplus 

---

# Q2：不能通过Codec来设置中文编码

- QT5中删除了以下代码

``` c++
 QTextCodec::setCodecForTr(...)
 QTextCodec::setCodecForCStrings(...)
 QTextCodec::setCodecForLocale(...)
```

- QT6中直接移除了整个了QTextcodec库
- 可以通过安装QT5兼容模块，然后在QTCreator中配置pro文件来获得该库

``` c++	
greaterThan(QT_MAJOR_VERSION, 5):  QT += core5compat
```

- QT5及其以后版本，文件将默认使用UTF-8编码
- Visual Studio无法配置兼容模块，无法使用上述代码，也不能设置UTF-8
- 在C++11以后的代码中，字符串可以用以下形式来声明为u8

```c++
QString s= u8"中文测试";
```

---

# Q3：Visual Studio 与 Qt Creator 生成的项目相互兼容问题

### QtCreator生成项目没有sln文件

在Visual Studio中选择扩展 → QT Tools → Launch Qt Project File(.pro) 会自动生成sln文件，打开后根据提示解决兼容性问题
**报错问题参照上文Q1**

### Visual Studio生成项目没有pro文件
右击解决方案 → Qt → Create Basic.pro File 根据提示生成pro文件，可以进行相关配置，也可以在Creator中打开

---

# Q4：Visual Studio中生成的ui文件不生成头文件与源文件

**最新解决方案：右键Add时选择 Add Qt Class**
QTCreator中新建ui窗体会生成.ui文件并附带头文件.h和源文件.cpp，VS中新建则只会生成ui文件，并不会附带头文件和源文件

- 在Visual Studio中必须右键ui文件→编译才会生成ui头文件，编译生成的头文件存储在 ./x64/Debug/uic中
- 实测编译后不需要在设置中添加包含目录就可以直接include
- 项目内对应的头文件与源文件需要自己创建
- 头文件与源文件命名应与ui文件相同
- 头文件需要包含以下部分
- include 窗体基础类型<QXXXClass> 和对应的ui头文件"ui_xxx.h" 
- 新建项目时默认的主窗体的头文件已经预编译生成，具有自定义的名称
- **在QTCreator中新建的项目文件不会include生成的ui头文件**，声明在项目内就完成（命名空间的宏定义声明就包含在项目中的头文件里）
- 自定义的ui文件编译的头文件中Class的名称默认为Ui_className，namespace中定义的Class名称默认为上述的className【**className为ui文件中窗体对象的名字**】
- **指针声明与后续定义中的className为此处的名称应为对应的ui头文件中的className**
- 类的基础声明
- 声明与当前文件名同名的类
- 继承基础类型，并声明Q_OBJECT宏
- 其他基础声明
- 构造函数与析构函数
- 声明与ui挂钩的指针 Ui::className *ui; 
- 源文件需要包含以下部分
- include 上面声明的头文件
- 定义构造函数
- 执行窗口基类构造函数
- 初始化ui指针：堆分配空间给ui（**调用ui::className() 构造函数**）
- 函数体中调用 ui->setupUi(this)  来将组件挂载到ui指针指向的类里
- 定义析构函数：delete ui指针

---

# Q5：Visual Studio 中打开ui文件闪退

### 解决方式
右键 ui 文件 → 打开方式 → 添加 → 找到QT目录下 /版本号/msvc_xxxx/bin/designer.exe   添加到 程序 → 参数留空，名字自己起 → 确定，选择新建的打开方式为默认
### 问题原因
默认的打开方式有点问题
