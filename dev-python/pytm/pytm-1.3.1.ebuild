# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=poetry

PYTHON_COMPAT=( python3_13 )

inherit distutils-r1 pypi

DESCRIPTION="A pythonic framework for threat modeling"
HOMEPAGE="
	https://pypi.org/project/pytm/
	https://github.com/OWASP/pytm
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-python/pydal[${PYTHON_USEDEP}]
	dev-python/graphviz[${PYTHON_USEDEP}]
	media-gfx/plantuml
"
BDEPEND="
	test? (
		dev-python/black[${PYTHON_USEDEP}]
		dev-python/pdoc3[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest
