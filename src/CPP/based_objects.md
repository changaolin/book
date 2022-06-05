# 基于类（对象）

- 类是<font color='red'>**数据**</font>和数据的处理函数的一种组织形式。

- 类的设计要点（优先考虑<font color='red'>**数据**</font>的设计）：
  - 类Header 和 类Body
  - 类分为无指针类，和有指针类（拷贝构造，delete []等）
  - 构造函数无返回值，尽量使用构造参数列表形式。
    - 拷贝构造：String(const String& str)
    - 拷贝赋值：String& operator=(const String& str)  || return *this
    - 委托构造
  - 函数构造需要考虑（名称-参数（类型，权限）-返回值（类型，权限））：
    - 函数分为类内函数和全局函数
    - 参数类型，仅可能的使用引用传递
    - 考虑是否使用const 修饰入参
    - 返回值尽可能使用引用返回
    - 考虑返回值是否使用const
  
  - static
    - 静态函数只能处理静态数据
    - static 数据只有一份：instance

# 面向对象

- 复合 （内存 has a， Container / Component）
  - 构造由内到外
  - 析构由外到内
- 委托（复合 by reference，Handle / Body）
  - 共享，引用计数
- 继承（is a，子类中有一部分父类的信息，继承数据，继承函数的调用权）
  - 构造由内（父类）而外
  - 析构由外而内
  - 虚函数（virtual）
    - 非虚函数：override 不希望子类重写
    - 虚函数：希望子类override 重写，已经有默认实现
    - 纯虚函数：子类必须override vitual func = 0;，没有默认实现