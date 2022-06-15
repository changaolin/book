# Thread

# 一、主要函数

```C
 #include <pthread.h>

int pthread_create(pthread_t *thread, const pthread_attr_t *attr, void *(*start_routine)(void *), void *arg)
int pthread_join(pthread_t thread, void **value_ptr)
 # ps -Lf pid 
int pthread_cancel(pthread_t thread)
int pthread_detach(pthread_t thread)
void pthread_exit(void *value_ptr)
int pthread_kill(pthread_t thread, int sig)
int pthread_once(pthread_once_t *once_control, void (*init_routine)(void))
pthread_t pthread_self(void)
pthread_equal(tid1, tid2)
```

# 二、具体功能

## 2.1 线程的创建

## 2.2 线程的中止

### 2.2.1 异常终止

- 主线程退出，子线程被强行终止
- 子线程中调用 exit()，则整个**进程**全部退出
- 缺省行为是终止程序的信号，会终止整个**进程**

### 2.2.2 正常终止

- 线程使用 return 返回，return 0 无需转换，return (void*) 1; 返回值是线程的结束码。
- 线程可以被同一进程的其他线程调用 pthread_cancel() 结束。
- 在线程中调用 pthread_exit((void*)1) 退出

## 2.3 线程的参数传递

- 线程创建顺序和线程运行顺序并不保证一致。
- 全局变量不能代替线程的参数传递
- 参数需要类型类型强制转换
- 传递整型参数
  - pthread_create(&pid, NULL, func, (void*)(long) number))
  - printf("%d", (int)(long)arg)
- 传递地址参数(需要给每个线程传递一个单独的地址，不能使用同一个地址：全局变量)
  - int* var1 = new int; *var = 1;
  - pthread_create(&pid, NULL, func, var1))
  - printf("%xx", \*(int\*)arg)
  - var1 需要在线程中释放内存。 delete  (int*)arg;
- 线程退出状态
  - void* pv = 0;
  - pthread_join(pid, &pv);
  - pv 保存线程 返回的值。

## 2.4 线程资源的回收

- 线程分离
  - joinable(默认状态)，在线程结束时，之后不会释放全部的资源，而是等待join，join之后资源才会释放（因此只能join一次）
    - pthread_join()
    - pthread_tryjoin_np()
    - pthread_timedjoin_np()
  - unjoinable（不可分离）
    - pthread_detach(tid);
      - 可以放在线程函数中 pthread_detach(pthread_self());
    - 创建线程前，调用pthread_attr_setdetachstat()设置线程属性。
- 线程清理函数释放资源
  - pthread_cleanup_push(func)
  - pthread_cleanup_pop(1)
    - 填 0 标识 只退出不执行清理函数
    - 非 0 则会退出并执行清理函数
  - 可以有多个线程清理函数，但必须push和pop成对在**同一语句块**中出现
  - 在线程退出时 会调用线程清理函数。
    - pthread_exit()
    - return
    - Pthread_cancel()

## 2.5 线程取消

- 可以被join
- 返回值 为 PTHREAD_CANCELED ，即 -1
- pthread_setcancelstate() 设置线程的取消状态
  - 只能放在线程的主函数中
  - 可以被取消
  - 不可以被取消
- pthread_setcacheltype() 设置线程的取消类型
  - 立即取消
  - 执行到 取消点是进行取消（默认）
    - accept()
    - close()
    - pthread_testcancel()； 设置取消点

## 2.6 线程与信号

- 在多线程程序中，外部向进程发送信号不会中断系统调用
- 在多线程程序中，信号的处理是所有线程共享的
- 进程中的信号可以送达单个线程，会中断系统调用
  - pthread_kill(tid, sig)
- 如果某个线程因为信号被终止，则整个进程都会被终止

## 2.7 线程安全

- 原子性，可见行，顺序性
  - volatile
    -  不从缓存中读取数据，而是从内存中读取
    - 禁止代码重排序
    - 不是原子的
- 原子操作
  - 原子操作函数
  - CAS执行
  - 原子类型 std::atomic\<int\> var;
- 线程同步锁

## 2.8 线程同步

### 2.8.1 互斥锁

- 加锁解锁，其他等待
- mutex

### 2.8.2 自旋锁

- 加锁解锁，其他不等待
- spin
- 共享标志

### 2.8.3 读写锁

- 读模式加锁（可以多个持有读锁）
- 写模式加锁（只有不加锁的时候才能申请写锁，只能有一个持有写锁）
- 不加锁
- rw

### 2.8.4 条件变量（专为生产消费者设计）

- 与互斥锁一起使用

- pthread_cond_wait() 等待被唤醒

  - 把互斥锁解锁
  - 阻塞，等待信号唤醒
  - 条件被触发+互斥锁加锁 （原子操作）

  ```c
  pthread_cond_timedwait();  // 等待被唤醒，带超时机制
  pthread_cond_signal();  // 唤醒一个等待中的线程
  pthread_cond_broadcast(); // 唤醒全部等待中的线程
  ```

### 2.8.5 （匿名）信号量

- 一个整数计数器，数值表示空闲的临界资源的数量

- 申请资源时，信号量减少

- 释放资源后，信号量增加

  ```C
  sem_t sem;
  int sem_init();
  int sem_destroy();
  int sem_wait(sem_t* sem); //P操作
  int sem_trywait(sem_t* sem); // P操作，不阻塞
  int sem_timedwait(sem_t* sem); // P操作，超时
  int sem_post(sem_t* sem); //V操作
  int sem_getvalue(); // 获取信号想的值
  ```

### 2.8.6 生产消费者模型

- 基本概念
- 互斥锁 + 条件变量实现生产消费者模型
  - 在线程清理函数中需要释放 互斥锁
- 信号量 实现生产消费者模型
  - 需要手动加锁解锁（或者使用信号量代替互斥锁）

### 2.8.7 多线程程序

- 全局变量的线程安全
- 是否有不可重入函数

![安全函数](../assets/%E5%AE%89%E5%85%A8%E5%87%BD%E6%95%B0.png)
