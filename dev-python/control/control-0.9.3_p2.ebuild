# Copyright 2020-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="8"

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..11} )
inherit distutils-r1
# Hard-code the version for upstream's weird 0.9.3_post2 release.
MY_PV="0.9.3.post2"

DESCRIPTION="Python Control Systems Library"
HOMEPAGE="https://python-control.readthedocs.io/ https://pypi.org/project/control/"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${PN}-${MY_PV}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
# Tests need nose which is getting cleaned from main tree.
RESTRICT="test"
S="${WORKDIR}/${PN}-${MY_PV}"

BDEPEND="
	dev-python/matplotlib[${PYTHON_USEDEP}]
	dev-python/numpy[${PYTHON_USEDEP}]
	dev-python/scipy[${PYTHON_USEDEP}]
"
RDEPEND="${DEPEND}"
