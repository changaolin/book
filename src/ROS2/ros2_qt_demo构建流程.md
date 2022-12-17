# ros2_qt_demo

# 1. 生成qt5和ros2同名项目

```shell
# qtcreator 创建 名称为 ros2_qt_demo
# ros2 创建
mkdir ros2_ws
cd ros2_ws
mkdir src
ros2 pkg create --build-type ament_cmake ros2_qt_demo
mkdir ui # mainwindow.ui
mkdir resource # NULL
mkdir src  # main.cpp mainwindow.cpp
rm include/* # mainwindow.h
```

# 2. 合并CMakeList.txt

```cmake
cmake_minimum_required(VERSION 3.8)
project(ros2_qt_demo)

if(CMAKE_COMPILER_IS_GNUCXX OR CMAKE_CXX_COMPILER_ID MATCHES "Clang")
  add_compile_options(-Wall -Wextra -Wpedantic)
endif()
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# find dependencies
find_package(ament_cmake REQUIRED)
find_package(QT NAMES Qt6 Qt5 REQUIRED COMPONENTS Widgets)
find_package(Qt${QT_VERSION_MAJOR} REQUIRED COMPONENTS Widgets)

# uncomment the following section in order to fill in
# further dependencies manually.
# find_package(<dependency> REQUIRED)

file(GLOB PRO_SRC_DIR RELATIVE ${CMAKE_SOURCE_DIR} FOLLOW_SYMLINKS src/*.cpp)
file(GLOB PRO_INCLUDE_DIR RELATIVE ${CMAKE_SOURCE_DIR} FOLLOW_SYMLINKS include/*.h *.hpp)
file(GLOB PRO_UI_DIR RELATIVE ${CMAKE_SOURCE_DIR} FOLLOW_SYMLINKS ui/*.ui)
file(GLOB PRO_RES_DIR RELATIVE ${CMAKE_SOURCE_DIR} FOLLOW_SYMLINKS resource/*.qrc)
qt5_wrap_ui(QT_UI_HPP ${PRO_UI_DIR})
qt5_wrap_cpp(QT_MOC_HPP ${PRO_INCLUDE_DIR})
qt5_add_resources(QT_RES_HPP ${PRO_RES_DIR})
include_directories(
	include/
	${CMAKE_CURRENT_BINARY_DIR}
)
add_executable(${PROJECT_NAME}
            ${PRO_SRC_DIR}
            ${PRO_INCLUDE_DIR}
            ${PRO_UI_DIR}
            # ${PRO_RES_DIR}
            ${QT_UI_HPP}
            ${QT_MOC_HPP}
            ${QT_RES_HPP}
        )

target_link_libraries(${PROJECT_NAME} PRIVATE Qt${QT_VERSION_MAJOR}::Widgets)
install(TARGETS ${PROJECT_NAME} DESTINATION lib/${PROJECT_NAME})
 
if(BUILD_TESTING)
  find_package(ament_lint_auto REQUIRED)
  # the following line skips the linter which checks for copyrights
  # comment the line when a copyright and license is added to all source files
  set(ament_cmake_copyright_FOUND TRUE)
  # the following line skips cpplint (only works in a git repo)
  # comment the line when this package is in a git repo and when
  # a copyright and license is added to all source files
  set(ament_cmake_cpplint_FOUND TRUE)
  ament_lint_auto_find_test_dependencies()
endif()
if(QT_VERSION_MAJOR EQUAL 6)
    qt_finalize_executable(ros2_qt_demo)
endif()
ament_package()

```

# 3. qtcreator 使用

```shell
# 需要进入到qtcreator的安装目录 使用终端打开
# 原因是 需要加载ros2的环境 # ~/.bashrc里面的
```

# 4. coclon 使用

```shell
# 安装
sudo apt install python3-colcon-common-extensions
# ros2_ws 目录
coclon build
coclon run ros2_qt_demo ros2_qt_demo
# 也可以使用qtcreator打开,方法同3
```

