# Copyright 2020-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="8"

DESCRIPTION="GnuPG keyring of Archlinux developer keys"
HOMEPAGE="https://gitlab.archlinux.org/archlinux/archlinux-keyring"
SRC_URI="https://gitlab.archlinux.org/archlinux/archlinux-keyring/-/archive/${PV}/archlinux-keyring-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

BDEPEND="app-crypt/sequoia-sq"

src_prepare() {
	default

	# On non-systemd installations the service files are thrown
	# directly into /. Hard-code the path as a quick and dirty solution.
	# If it breaks for someone else, please complain, too and I'll revert it.
	sed -i "s#\$\(shell pkgconf --variable systemd_system_unit_dir systemd\)#/usr/lib/systemd/system#" Makefile || die
}

src_install() {
	emake DESTDIR="${D}" PREFIX="${EPREFIX}/usr" install
}

pkg_postinst() {
	einfo ""
	einfo "This package only installs the keyring files while sys-apps/pacman"
	einfo "initializes these keyrings to actually use it. This is a different"
	einfo "behaviour from Archlinux, but is necessary to avoid circular deps."
	einfo ""
}
