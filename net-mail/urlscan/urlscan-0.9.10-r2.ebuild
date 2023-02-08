# Copyright 2020-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="8"

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..11} )
inherit distutils-r1

DESCRIPTION="Mutt and terminal url selector (similar to urlview)"
HOMEPAGE="https://github.com/firecat53/urlscan"
SRC_URI="https://github.com/firecat53/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-python/urwid[${PYTHON_USEDEP}]"
RDEPEND="${DEPEND}"
BDEPEND=""

DOCS=( README.md )
PATCHES=( "${FILESDIR}/${PN}-0.9.7-respect-paths.patch" )
