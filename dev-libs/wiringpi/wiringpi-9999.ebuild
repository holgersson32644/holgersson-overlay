# Copyright 2015-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit eutils toolchain-funcs git-r3

DESCRIPTION="A 'wiring' like library for the Raspberry Pi (inkluding GPIO tool)"
HOMEPAGE="http://wiringpi.com/"
EGIT_REPO_URI="git://git.drogon.net/wiringPi"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS=""
IUSE="examples-src +gpio"

src_compile() {
	emake -C wiringPi
	emake -C devLib INCLUDE="-I../wiringPi"
	pushd wiringPi
	ln -s libwiringPi* libwiringPi.so
	popd
	pushd devLib
	ln -s libwiringPiDev* libwiringPiDev.so
	popd
	use gpio &&	emake -C gpio LDFLAGS="-L../wiringPi -L../devLib ${LDFLAGS}" INCLUDE="-I../wiringPi -I../devLib"
}

src_install() {
	doheader wiringPi/*.h devLib/*.h
	dolib wiringPi/libwiringPi.so.2.32
	dolib devLib/libwiringPiDev.so.2.32
	dosym libwiringPi.so.2.32 /usr/$(get_libdir)/libwiringPi.so
	dosym libwiringPiDev.so.2.32 /usr/$(get_libdir)/libwiringPiDev.so
	use gpio && dobin gpio/gpio

	dodoc README.TXT
	use examples-src && dodoc examples/*.c
}
