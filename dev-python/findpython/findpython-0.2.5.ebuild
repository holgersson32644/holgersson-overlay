# Copyright 2022-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="8"

DISTUTILS_USE_PEP517=pdm
PYTHON_COMPAT=( python3_{11..12} )
inherit distutils-r1 pypi

DESCRIPTION="Utility to find installed python versions"
HOMEPAGE="
	https://github.com/frostming/findpython
	https://pypi.org/project/findpython/
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND=""
BDEPEND=""

distutils_enable_tests pytest
