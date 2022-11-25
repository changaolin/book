```shell
sudo apt-get install -y git autoconf automake autotools-dev curl python3 libmpc-dev libmpfr-dev libgmp-dev 
```



```shell
sudo apt-get install -y gawk build-essential bison flex texinfo gperf patchutils bc libexpat1-dev libglib2.0-dev ninja-build zlib1g-dev pkg-config libboost-all-dev libtool libssl-dev libpixman-1-dev
```



```shell
sudo apt-get install -y  libpython3-dev virtualenv libmount-dev libsdl2-dev
```



```shell
git clone https://gitee.com/mirrors/riscv-gnu-toolchain
cd riscv-gnu-toolchain


mkdir build  #建立build目录
#配置操作，终端一定要切换到build目录下再执行如下指令
cd build
../configure --prefix=/home/cal/tools/riscv --enable-multilib --target=riscv64-multlib-elf
```

```shell

sudo mkdir -p /var/cache/swap/
sudo dd if=/dev/zero of=/var/cache/swap/swap0 bs=64M count=64
sudo chmod 0600 /var/cache/swap/swap0
sudo mkswap /var/cache/swap/swap0
sudo swapon /var/cache/swap/swap0
sudo swapon -s
```

```shell

wget https://download.qemu.org/qemu-6.2.0.tar.xz #下载源码包
tar xvJf qemu-6.2.0.tar.xz #解压源码包

mkdir build #建立build目录
cd build #切换到build目录下
../configure --prefix=/home/cal/tools/qemu --enable-sdl --enable-tools --enable-debug --target-list=riscv32-softmmu,riscv64-softmmu,riscv32-linux-user,riscv64-linux-user #配置QEMU
make -j3
make install
```

