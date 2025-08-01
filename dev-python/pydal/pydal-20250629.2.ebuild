# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

#DISTUTILS_USE_PEP517=hatchling
DISTUTILS_USE_PEP517=setuptools

PYTHON_COMPAT=( python3_{13..14} )

inherit distutils-r1 pypi

DESCRIPTION="pyDAL is a pure Python Database Abstraction Layer"
HOMEPAGE="
	https://pypi.org/project/pydal/
	https://github.com/web2py/pydal
"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"

distutils_enable_tests pytest
