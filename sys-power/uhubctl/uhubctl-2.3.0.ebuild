# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="USB hub per-port power control"
HOMEPAGE="https://github.com/mvp/uhubctl"

if [[ ${PV} == *9999 ]]; then
	inherit git-r3
	EIGT_REPO_URI="${HOMEPAGE}"
else
	SRC_URI="${HOMEPAGE}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~arm ~x86"
fi

LICENSE="GPL-2"
SLOT="0"
IUSE=""

DEPEND="virtual/libusb:1"
RDEPEND="${DEPEND}"

src_prepare() {
	sed -i "s#\$(shell git describe --abbrev=4 --dirty --always --tags)#${PV}#" Makefile || die

	default
}
