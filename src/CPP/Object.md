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
    - 函数分为类内函数和全局函数（const 放在 成员函数上，不放在全局函数上）
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
    - 虚指针 && 虚表（静态绑定-- call某个地址 ｜ 动态--绑定看调用方，多态）
      - 一定是指针调用触发 虚链路（多态）
      - 三个条件：指针，虚函数，向上转型

# 1 零散

## 转换函数

## explict（明白的，明确的）

- non-explict-one-argument ctor

## Pointer-likeClass（智能指针，迭代器）

## Function-likeClass（仿函数）

## 类模板

- 使用时指定类型

## 函数模板

## 成员模板

## 模板特化（全/偏特化-范围｜个数缩小）

## 模板模板参数

## 数量不定的模板参数：typename... Types：sizeof...(args)

## auto（编译时推理）

- 声明时需要定义

## ObjectModel

- 虚指针（vptr）
- 虚表（vtbl）
