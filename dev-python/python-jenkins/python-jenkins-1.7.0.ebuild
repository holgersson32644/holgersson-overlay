# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{7,8,9} )
inherit distutils-r1

DESCRIPTION="Python bindings for the remote Jenkins API"
HOMEPAGE="https://pypi.org/project/python-jenkins https://python-jenkins.readthedocs.io"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
RESTRICT=test # tbd. - 14 deps, only partly packaged yet

DEPEND="
	dev-python/multi_key_dict[${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]
	dev-python/six[${PYTHON_USEDEP}]
"
RDEPEND="${DEPEND}"
BDEPEND="
	${DEPEND}
	dev-python/pbr[${PYTHON_USEDEP}]
"
