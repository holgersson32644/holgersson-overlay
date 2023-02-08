# Copyright 2022-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="8"

DISTUTILS_USE_PEP517=flit
PYTHON_COMPAT=( python3_{10..11} )
inherit distutils-r1

MY_PN="${PN/-/_}"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Wrappers to call pyproject.toml-based build backend hooks"
HOMEPAGE="
	https://github.com/pypa/pyproject-hooks
	https://pypi.org/project/pyproject_hooks/
"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${MY_P}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND=""
BDEPEND=""

distutils_enable_tests pytest
