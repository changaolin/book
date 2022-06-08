# CMAKE 模板

## [CMake+Pkg](https://cmake.org/cmake/help/v3.19/module/FindPkgConfig.html?highlight=pkg#command:pkg_check_modules)

- `<XXX>_FOUND`

  set to 1 if module(s) exist

- `<XXX>_LIBRARIES`

  only the libraries (without the ‘-l’)

- `<XXX>_LINK_LIBRARIES`

  the libraries and their absolute paths

- `<XXX>_LIBRARY_DIRS`

  the paths of the libraries (without the ‘-L’)

- `<XXX>_LDFLAGS`

  all required linker flags

- `<XXX>_LDFLAGS_OTHER`

  all other linker flags

- `<XXX>_INCLUDE_DIRS`

  the ‘-I’ preprocessor flags (without the ‘-I’)

- `<XXX>_CFLAGS`

  all required cflags

- `<XXX>_CFLAGS_OTHER`

  the other compiler flags

```cmake
cmake_minimum_required(VERSION 3.19)
project(player)

set(CMAKE_CXX_STANDARD 11)
list(APPEND SOURCE
	src/main.c)
set(ENV{PKG_CONFIG_PATH} 
	/usr/local/sdl2/lib/pkgconfig:/usr/local/ffmpeg/lib/pkgconfig
)
find_package(PkgConfig)
pkg_check_modules(FFMPEG REQUIRED IMPORTED_TARGET libavcodec libavformat libavutil)
pkg_check_modules(SDL2 REQUIRED IMPORTED_TARGET sdl2)
add_executable(${PROJECT_NAME} ${SOURCE})
target_link_libraries(${PROJECT_NAME} PRIVATE
	PkgConfig::FFMPEG
	PkgConfig::SDL2
	)
```

```cmake
cmake_minimum_required(VERSION 3.19)
project(player)

set(CMAKE_CXX_STANDARD 11)
list(APPEND SOURCE
	src/main.c)
set(ENV{PKG_CONFIG_PATH} 
	/usr/local/sdl2/lib/pkgconfig:/usr/local/ffmpeg/lib/pkgconfig
)
find_package(PkgConfig)
pkg_check_modules(FFMPEG REQUIRED IMPORTED_TARGET libavcodec libavformat libavutil)
pkg_check_modules(SDL2 REQUIRED IMPORTED_TARGET sdl2)
add_executable(player ${SOURCE})
include_directories(
	${FFMPEG_INCLUDE_DIRS}
	${SDL2_INCLUDE_DIRS}
	)
target_link_libraries(player PRIVATE
	${FFMPEG_LDFLAGS}
	${SDL2_LDFLAGS}
	)
```

