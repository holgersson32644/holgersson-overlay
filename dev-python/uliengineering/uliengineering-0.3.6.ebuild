# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{8..9} )
inherit distutils-r1

MY_PN="UliEngineering"

DESCRIPTION="Computational tools for electronics engineering"
HOMEPAGE="https://pypi.org/project/UliEngineering https://github.com/ulikoehler/UliEngineering"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_PN}-${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
S="${WORKDIR}/${MY_PN}-${PV}"

DEPEND="
	dev-python/numpy[${PYTHON_USEDEP}]
	dev-python/scipy[${PYTHON_USEDEP}]
	dev-python/toolz[${PYTHON_USEDEP}]
"
RDEPEND="${DEPEND}"
BDEPEND=""
