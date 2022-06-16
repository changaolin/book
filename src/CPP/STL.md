# STL

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

# 分配器（Allocators）

- VC6 的分配器没有特殊设计，调用的是 malloc和free
- BC5 的分配器也没有特殊设计
- GCC
  - <stl_alloc.h>

# 算法（Algorithms）

- 所有的算法，最终的行为无非就是比大小。

# 迭代器（Iterators）

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
