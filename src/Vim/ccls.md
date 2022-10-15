# CCLS

# 1. 依赖

- vim8+ ｜ [neovim](https://github.com/neovim/neovim/wiki/Installing-Neovim#install-from-download)
- [clang+llvm](https://github.com/llvm/llvm-project/releases)
- [ccls](https://github.com/MaskRay/ccls)
- [nvm](https://github.com/nvm-sh/nvm)
- Node
- [vim-plug](https://github.com/junegunn/vim-plug)
- [coc.nvim](https://github.com/neoclide/coc.nvim)

# 2. neovim(可选)

# 3. [clang+llvm](https://github.com/llvm/llvm-project/releases)

```shell
wget https://github.com/llvm/llvm-project/releases/download/llvmorg-13.0.0/clang+llvm-13.0.0-x86_64-linux-gnu-ubuntu-20.04.tar.xz

tar -xvf *.tar.zx
cd clang+llvm-13.0.0-x86_64-linux-gnu-ubuntu-20.04
# > bashrc
############clang+llvm
export LLVM_HOME=***/clang+llvm-13.0.0-x86_64-linux-gnu-ubuntu-20.04
export PATH=$LLVM_HOME/bin:$PATH
export C_IONCLUDE_PATH=$LLVM_HOME/include:$C_INCLUDE_PATH
export LD_LIBRARY_PATH=$LLVM_HOME/lib:$LD_LIBRARY_PATH

```

# 4. [ccls](https://github.com/MaskRay/ccls)

```shell
git clone --depth=1 --recursive https://github.com/MaskRay/ccls
cd ccls
# sudo apt install zlib1g zlib1g-dev
cmake -H. -BRelease -DCMAKE_BUILD_TYPE=Release
cmake --build Release
```

# 5. [nvm](https://github.com/nvm-sh/nvm#troubleshooting-on-linux)

```bash
export NVM_DIR="$HOME/.nvm" && (
  git clone https://github.com/nvm-sh/nvm.git "$NVM_DIR"
  cd "$NVM_DIR"
  git checkout `git describe --abbrev=0 --tags --match "v[0-9]*" $(git rev-list --tags --max-count=1)`
) && \. "$NVM_DIR/nvm.sh"

# >> ~/.bashrc
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

```

# 6. node

```shell
nvm ls-remote
nvm install * 
nvm use *
```

# 7. [coc.nvm](https://github.com/neoclide/coc.nvim)

```
Plug 'neoclide/coc.nvim', {'branch': 'master', 'do': 'yarn install --frozen-lockfile'}
```

# 8. CMake 生成 compile_commands.json

```cmake
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)
# -DCMAKE_EXPORT_COMPILE_COMMANDS=ON 
cmake -H. -Bbuild -DCMAKE_BUILD_TYPE=Release -DCMAKE_EXPORT_COMPILE_COMMANDS=ON && ln build/compile_commands.json ./
```

