# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

COMMIT_ID="1340eaed303c57e74bab8d6c390c9c294c59fa2f"

DESCRIPTION="Repository list for Archlinux's binary package manager"
HOMEPAGE="https://www.archlinux.org/mirrorlist/"
SRC_URI="https://raw.githubusercontent.com/archlinux/svntogit-packages/${COMMIT_ID}/trunk/mirrorlist -> ${P}"
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
