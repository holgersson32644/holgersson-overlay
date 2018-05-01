# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

inherit toolchain-funcs

DESCRIPTION="C library for controlling (RaspberryPi) PiFace Digital"
HOMEPAGE="https://github.com/piface/libpifacedigital"

if [[ ${PV} == *9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/piface/libpifacedigital.git"
else
	SRC_URI="https://github.com/piface/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~arm"
fi

LICENSE="GPL-3"
SLOT="0"
IUSE=""

DEPEND="dev-libs/libmcp23s17"
RDEPEND="${DEPEND}"

PATCHES=( "${FILESDIR}"/${PN}-fix-build-system.patch )

src_prepare(){
	# Holy supercow, they managed to drop the trailing newline :-/
	echo >> ${S}/Makefile

	default
}

src_configure(){
	default

	tc-export CC
}

src_install() {
	dolib ${PN}.so
	doheader src/pifacedigital.h
	einstalldocs
}
