# STL

[参考资料](../resource/Slide.pdf)

[源码](../resource/sample.cpp)

# 容器（Container）

前闭后开

## 结构与分类

- 序列容器
  - Array(固定空间)
  - Vector
  - Deque
  - List
    - Forward-List（单向链表）
- 关联容器（key:value）
  - Set/Multiset
    - Unordered Set/Multiset
  - Map/Multimap
    - Unordered Map/Multimap

## List

- 双向链表
- 迭代器是class，

## Vector

- 2倍动态增长
- 不能原地扩充
- 迭代器是原始指针

## Deque

- 分段Buffer
- 双向扩充
- begin
- end
- iterator
  - cur
  - first
  - end
  - node

# 分配器（Allocators）

- VC6 的分配器没有特殊设计，调用的是 malloc和free
- BC5 的分配器也没有特殊设计
- GCC
  - <stl_alloc.h>

# 算法（Algorithms）

- 所有的算法，最终的行为无非就是比大小。

## 1. 算法是一个函数模板

	- 从语言层次来讲，算法是一个函数模板
	- 其余部件都是一个类模板

## 2. 处理迭代器

# 迭代器（Iterators）

![截屏2022-06-22 12.52.02](../assets/%E8%BF%AD%E4%BB%A3%E5%99%A8%E7%B1%BB%E5%9E%8B.png)

## 1. 五种相关类型

- iterator_category （分类）
- distance（两个iterator之间的距离的类型）
- value_type（数据类型）
- reference
- pointer

## 2. traits（中间层）

- 用于封装原生指针，用以实现上述五种类型的数据。

# 适配器（Adapters）

# 仿函数（Functors）



# 标准库其他

