# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

DESCRIPTION="Repository list for Archlinux's binary package manager"
HOMEPAGE="https://www.archlinux.org/mirrorlist/"
SRC_URI="https://git.archlinux.org/svntogit/packages.git/plain/trunk/mirrorlist?h=packages/pacman-mirrorlist -> ${P}"
KEYWORDS="~amd64"
LICENSE="GPL-2"
SLOT=0
S="${WORKDIR}"

src_unpack() {
	cp "${DISTDIR}/${P}" mirrorlist
}

src_install() {
	insinto etc/pacman.d
	doins mirrorlist
}

pkg_postinst() {
	einfo
	einfo "This packages installs only a plain list of mirrors for sys-apps/pacman."
	einfo
}
