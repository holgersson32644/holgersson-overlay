# Copyright 2020-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="8"

DISTUTILS_USE_PEP517=hatchling
PYTHON_COMPAT=( python3_11 )
inherit distutils-r1 pypi

DESCRIPTION="Mutt and terminal url selector (similar to urlview)"
HOMEPAGE="
	https://github.com/firecat53/urlscan
	https://pypi.org/project/urlscan/
"

SRC_URI+=" https://raw.githubusercontent.com/firecat53/urlscan/1.0.0/urlscan.1 -> ${P}-manpage"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-python/urwid[${PYTHON_USEDEP}]"
RDEPEND="${DEPEND}"
BDEPEND=""

DOCS=( README.md )
PATCHES=( "${FILESDIR}/${PN}-1.0.0-respect-paths.patch" )

src_install() {
	default
	distutils-r1_src_install

	newman "${DISTDIR}/${P}-manpage" "${PN}.1"
}
