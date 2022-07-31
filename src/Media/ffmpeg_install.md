# FFMPEG 安装 MACOS
```shell
./configure --prefix=/usr/local/ffmpeg --enable-gpl --enable-nonfree --enable-libfdk-aac --enable-libx264 --enable-libx265 --enable-filter=delogo --enable-debug --disable-optimizations --enable-libspeex --enable-videotoolbox --enable-shared --enable-pthreads --enable-version3 --enable-hardcoded-tables --cc=clang --host-cflags= --host-ldflags= --disable-x86asm

brew install fdk-aac&&brew install x264&&brew install x265&&brew install speex&&brew install pkg-config&&brew  install sdl2



export PATH=$PATH:/usr/local/ffmpeg/bin
export PKG_CONFIG_PATH=$PKG_CONFIG_PATH:/usr/local/lib/pkgconfig:/usr/lib/pkgconfig:/usr/local/Cellar/sdl2/2.0.8/lib/pkgconfig:/usr/local/ffmpeg/lib/pkgconfig

codesign --remove-signature /path/to/*.dylib
codesign -s "Apple Development: Your Name (10-char-ID)"  /path/to/*.dylib
```
