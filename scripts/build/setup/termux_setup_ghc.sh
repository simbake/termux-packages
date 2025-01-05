# shellcheck shell=bash
# Utility function to setup a GHC toolchain.
termux_setup_ghc() {
	if [ "$TERMUX_ON_DEVICE_BUILD" = "false" ]; then
		local TERMUX_GHC_VERSION=9.12.1
		local TERMUX_GHC_TEMP_FOLDER="${TERMUX_COMMON_CACHEDIR}/ghc-${TERMUX_GHC_VERSION}"
		local TERMUX_GHC_TAR="${TERMUX_GHC_TEMP_FOLDER}.tar.xz"
		local TERMUX_GHC_RUNTIME_FOLDER

		if [ "${TERMUX_PACKAGES_OFFLINE-false}" = "true" ]; then
			TERMUX_GHC_RUNTIME_FOLDER="${TERMUX_SCRIPTDIR}/build-tools/ghc-${TERMUX_GHC_VERSION}-runtime"
		else
			TERMUX_GHC_RUNTIME_FOLDER="${TERMUX_COMMON_CACHEDIR}/ghc-${TERMUX_GHC_VERSION}-runtime"
		fi

		export PATH="$TERMUX_GHC_RUNTIME_FOLDER/bin:$PATH"

		[ -d "$TERMUX_GHC_RUNTIME_FOLDER" ] && return

		termux_download "https://downloads.haskell.org/~ghc/${TERMUX_GHC_VERSION}/ghc-${TERMUX_GHC_VERSION}-x86_64-ubuntu20_04-linux.tar.xz" \
			"$TERMUX_GHC_TAR" \
			d88379492ce2a5c14c0db1f2d7fc980b40cb44e4b7026e347b72efe2224600ec

		mkdir -p "$TERMUX_GHC_TEMP_FOLDER"
		tar xf "$TERMUX_GHC_TAR" --strip-components=1 -C "$TERMUX_GHC_TEMP_FOLDER"

		(
			set -e
			unset CC CXX CFLAGS CXXFLAGS CPPFLAGS LDFLAGS AR AS CPP LD RANLIB READELF STRIP
			cd "$TERMUX_GHC_TEMP_FOLDER"
			./configure --prefix="$TERMUX_GHC_RUNTIME_FOLDER"
			make install
		)

		rm -Rf "$TERMUX_GHC_TEMP_FOLDER" "$TERMUX_GHC_TAR"
	else
		if [[ "$TERMUX_APP_PACKAGE_MANAGER" = "apt" && "$(dpkg-query -W -f '${db:Status-Status}\n' ghc 2>/dev/null)" != "installed" ]] ||
			[[ "$TERMUX_APP_PACKAGE_MANAGER" = "pacman" && ! "$(pacman -Q ghc 2>/dev/null)" ]]; then
			echo "Package 'ghc' is not installed."
			exit 1
		fi
	fi
}
