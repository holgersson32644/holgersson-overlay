# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="8"

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..13} )
inherit distutils-r1 pypi

DESCRIPTION="Python wrapper for SLICOT, used by dev-python/control"
HOMEPAGE="
	https://github.com/python-control/Slycot
	https://pypi.org/project/slycot/
"

LICENSE="
	BSD
	GPL-2
"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"
RESTRICT="!test? ( test )"

DEPEND="
	dev-python/numpy[${PYTHON_USEDEP}]
	dev-python/scikit-build[${PYTHON_USEDEP}]
	virtual/blas
	virtual/lapack
"
BDEPEND="
	${DEPEND}
	dev-python/scipy[fortran,${PYTHON_USEDEP}]
"

RDEPEND="${DEPEND}"
