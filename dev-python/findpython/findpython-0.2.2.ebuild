# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=pdm
PYTHON_COMPAT=( python3_{10..11} )
inherit distutils-r1

DESCRIPTION="Utility to find installed python versions"
HOMEPAGE="
	https://github.com/frostming/findpython
	https://pypi.org/project/findpython/
"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND=""
BDEPEND=""

distutils_enable_tests pytest