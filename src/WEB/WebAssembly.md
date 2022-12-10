# [WebAssembly](https://juejin.cn/post/7038540255510659109)

# 1. 安装C/C++转换工具

```shell
# https://emscripten.org/docs/getting_started/downloads.html
git clone https://github.com/emscripten-core/emsdk.git
cd emsdk
# Fetch the latest version of the emsdk (not needed the first time you clone)
git pull

# Download and install the latest SDK tools.
./emsdk install latest
# Make the "latest" SDK "active" for the current user. (writes .emscripten file)
./emsdk activate latest
# Activate PATH and other environment variables in the current terminal
source ./emsdk_env.sh
```

# 2.  测试

```shell
mkdir hello
cd hello
touch hello.c
```

```c++
#include <stdio.h>
int main(int argc, char ** argv) {
    printf("Hello, world!");
}
```

```shell
# 编译
emcc ./hello.c -s WASM=1 -s EXIT_RUNTIME=1 -o hello.html

# WASM=1 :表示生成wasm格式文件而不是asm格式文件，目前新版本默认就是wasm
# EXIT_RUNTIME=1:编译出的wasm默认情况下不会退出运行的，这是web情况下期待的方式，主程序main虽然运行结束了，但模块没有退出，静态变量可以保持在内存中，不释放。同时标准 I/O 缓冲区没有被flush，加此参数则能让模块结束，才能看到I/O输出，否则无法看到printf的输出
# o:输出文件格式
# O:是用来指定优化级别，优化级别有 -O0, -O1, -O2, -O3 -Os这五种级别。不指定是为 -O0, 即没有优化，开发时一般指定为 -O0 或 -O1， 这样编译速度快，调试方便。 正式发布时可以是 -O2 或 -O3，这时代码会优化，执行更快。-Os 不光是执行快，同时优化大小，可生成更小的执行文件。
# 执行后目录下会生成hello.html hello.js 和hello.wasm三个文件。
```

```shell
# 运行
emrun --no_browser --port 8080 .

```

