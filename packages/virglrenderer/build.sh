TERMUX_PKG_HOMEPAGE=https://virgil3d.github.io/
TERMUX_PKG_DESCRIPTION="A virtual 3D GPU for use inside qemu virtual machines"
TERMUX_PKG_LICENSE="MIT"
TERMUX_PKG_MAINTAINER="@termux"
TERMUX_PKG_VERSION="1.1.0"
TERMUX_PKG_REVISION=1
TERMUX_PKG_SRCURL=https://github.com/TrippleXC/VenusPatches/releases/download/Release/virglrenderer.tar.gz
TERMUX_PKG_SHA256=27c49d6c090de3f08fec081de38727d1713a4981d4a2812b2b3e170b36da2cf0
TERMUX_PKG_AUTO_UPDATE=true
TERMUX_PKG_DEPENDS="libandroid-shmem, libxshmfence, vulkan-loader, vulkan-headers, libdrm, libepoxy, libglvnd, libx11, mesa"
TERMUX_PKG_BUILD_DEPENDS="xorgproto"
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="-Dplatforms=egl,glx -Dvenus=true"

termux_step_pre_configure() {
	# error: using an array subscript expression within 'offsetof' is a Clang extension [-Werror,-Wgnu-offsetof-extensions]
	# list_for_each_entry_safe(struct vrend_linked_shader_program, ent, &shader->programs, sl[shader->sel->type])
	CPPFLAGS+=" -Wno-error=gnu-offsetof-extensions"
}
termux_step_pre_configure() {
termux_setup_cmake

CPPFLAGS+=" -D__USE_GNU"
LDFLAGS+=" -landroid-shmem"
 }
