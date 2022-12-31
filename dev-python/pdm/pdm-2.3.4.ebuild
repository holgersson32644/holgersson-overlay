# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=pdm
PYTHON_COMPAT=( python3_{10..11} )
inherit distutils-r1

DESCRIPTION="Python package and dependcy manager supporting latest PEPs"
HOMEPAGE="
	https://pdm.fming.dev/latest/
	https://pypi.org/project/pdm/
"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND="
	dev-python/findpython[${PYTHON_USEDEP}]
	dev-python/unearth[${PYTHON_USEDEP}]
	dev-python/pyproject-hooks[${PYTHON_USEDEP}]
	dev-python/shellingham[${PYTHON_USEDEP}]
"
BDEPEND=""

distutils_enable_tests pytest
