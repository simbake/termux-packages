TERMUX_PKG_HOMEPAGE=https://github.com/ptitSeb/box64
TERMUX_PKG_DESCRIPTION="A dynamic translator for running x86_64 Linux programs on ARM64 devices"
TERMUX_PKG_LICENSE="MIT"
TERMUX_PKG_MAINTAINER="Test"
TERMUX_PKG_VERSION=0.3.2
TERMUX_PKG_SRCURL=git+https://github.com/ptitSeb/box64
TERMUX_PKG_GIT_BRANCH="main"
#TERMUX_PKG_SHA256="8658b2c3840ae830ebb2b2673047d30a748139ec3afe178ca74a71adeddba63e"
TERMUX_PKG_DEPENDS="libandroid-sysv-semaphore, libandroid-spawn, libandroid-spawn-static, libandroid-glob, clang, libandroid-posix-semaphore"
TERMUX_PKG_EXTRA_CONFIGURE_ARGS=" -D TERMUX=1 -DCMAKE_C_COMPILER=clang -D CMAKE_BUILD_TYPE=RelWithDebInfo"
