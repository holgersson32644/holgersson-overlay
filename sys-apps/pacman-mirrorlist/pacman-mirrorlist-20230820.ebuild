# Copyright 2020-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="8"
COMMIT_ID="6e4f5b21223bd655f539d8256deed86d425d383f"

DESCRIPTION="Repository list for Archlinux's binary package manager"
HOMEPAGE="https://archlinux.org/mirrorlist/ https://archlinux.org/packages/core/any/pacman-mirrorlist/"
SRC_URI="https://gitlab.archlinux.org/archlinux/packaging/packages/pacman-mirrorlist/-/raw/${COMMIT_ID}/mirrorlist -> ${P}"

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
