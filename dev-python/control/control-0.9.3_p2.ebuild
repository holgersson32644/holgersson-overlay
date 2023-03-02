# Copyright 2020-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="8"

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..11} )
inherit distutils-r1 pypi

# Hard-code the version for upstream's weird 0.9.3_post2 release.
MY_PV="0.9.3.post2"

DESCRIPTION="Python Control Systems Library"
HOMEPAGE="
	https://python-control.readthedocs.io/
	https://github.com/python-control/python-control
	https://pypi.org/project/control/
"

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
