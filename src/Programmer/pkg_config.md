# PKG-CONFIG
## [地址](https://www.freedesktop.org/wiki/Software/pkg-config/)

## 一般用法
```shell
 gcc -o test test.c `pkg-config --libs --cflags glib-2.0`
```
## 环境变量
```shell
export PKG_CONGIG_PATH=$PKG_CONFIG_PATH
```
## 常用参数
```
--cflags # -I/usr/include/***

--libs # -L/usr/lib/***

--list-all # 查看所有模块信息

```
