# Effective Moderc C++

# 零

## 类型，名称，值，址，权限

int a = 10;

const char* val; 

char* const val;

# 一、类型推导

## 1.1 理解模版类型推导

```c++
template<typename T>
void f(ParamType param);
f(expr)
```

### 1.1.1 ParamType 是指针或者引用，但不是万能引用（万能引用对左值和右值的处理方式不一样）

- 忽略*expt*的引用类型
- 对*expr*的类型和*ParamType* 进行模式匹配，确定*T*的类型

```c++
template<typename T>
void f(T& param); // param是个引用

int X = 27;  // x的型别是int
const int ex= x;  // ex 的型别是 const int
const int& rx = x; // rx 是 x 的型别为 const int 的引用

f(x); // T 的型别是 int. param 的型别是 int&
f(cx); // T 的型别是 const int, param 的型别是 const int& 
f(rx); // T 的和别是 const int, param 的和别是 const int&
```

### 1.1.2 ParamType 是个万能引用

- 如果 *expr* 是个左值，*T*和*ParamType*都会被推导为左值引用
  - 首先，这是在模板型别推导中， T 被推导为引用型别的唯一情形。 
  - 其次，尽管在声明时使用的是右值引用语法，它的型别推导结果却是左值引用。
- 如果 *expr* 是个右值，则使用 1.1.1 的规则

```c++
template<typename T> 
void f(T&& param); // param现在是个万能引用

int X = 27;
const int ex= x;
const int& rx = x;

f(x);  // X 是个左值，所以 T 的型别是 int&, param 的 型别也是 int&
f(cx); // ex 是个左值，所以 T 的型别是 const int&, param 的型别也是 const int&
f(rx); // rx 是个左值，所以 T 的型别是 const int&, param 的型别也是 const int&
f(27); //27 是个右值，所以 T 的型别是 int, 这么 一来, param的型别就成 int&&
```

### 1.1.3 ParamType既不是指针或者引用，也不是万能指针

- 若 expr具有引用型别，则忽略其引用部分。
- 忽略 expr 的引用性之后，若 expr 是个 const 对象，也忽略之。若其是个 volatile 对象，同忽略之

```c++
template<typename T>
void f(T param); // param现在是按值传递

intX =27;
const int cx= x; 
const int& rx = x;

f(x); // T 和 param 的节别都是 int
f(cx); //T 和 param 的型别还都是 int
f(rx); //T 和 param 的型别仍都是 int
/*
请注意，即使 cx 和 rx 代表 const 值， param 仍然不具有 const 型别。这是合理的 。 param 是个完全独立千 cx 和 rx 存在的对象 cx 和 rx 的 一 个副本。从而 cx 和 rx 不可修改这一事实并不能说明 param是否可以修改。正是由于这一原因， expr 的常址 性以及挥发性 (volatileness, 若有)可以在推导 param 的型别时加以忽略:仅仅由千 expr 不可修改，并不能断定其副本也不可修改。
*/
```



## 1.1 auto

## 1.2 decltype