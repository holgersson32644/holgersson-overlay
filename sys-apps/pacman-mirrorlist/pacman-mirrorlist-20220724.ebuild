# Copyright 2020-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="8"

COMMIT_ID="189fa8e7555cb0178be5b815ee7243026ad83dd9"

DESCRIPTION="Repository list for Archlinux's binary package manager"
HOMEPAGE="https://archlinux.org/mirrorlist/"
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
