# Copyright 2022-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="8"

DISTUTILS_USE_PEP517=pdm
PYTHON_COMPAT=( python3_{10..11} )
inherit distutils-r1

DESCRIPTION="Python package and dependcy manager supporting latest PEPs"
HOMEPAGE="
	https://pdm.fming.dev/latest/
	https://github.com/pdm-project/pdm
	https://pypi.org/project/pdm/
"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND="
	dev-python/blinker[${PYTHON_USEDEP}]
	dev-python/cachecontrol[${PYTHON_USEDEP}]
	dev-python/certifi[${PYTHON_USEDEP}]
	dev-python/findpython[${PYTHON_USEDEP}]
	dev-python/installer[${PYTHON_USEDEP}]
	dev-python/packaging[${PYTHON_USEDEP}]
	dev-python/pyproject-hooks[${PYTHON_USEDEP}]
	dev-python/python-dotenv[${PYTHON_USEDEP}]
	dev-python/requests-toolbelt[${PYTHON_USEDEP}]
	dev-python/resolvelib[${PYTHON_USEDEP}]
	dev-python/rich[${PYTHON_USEDEP}]
	dev-python/shellingham[${PYTHON_USEDEP}]
	dev-python/tomlkit[${PYTHON_USEDEP}]
	dev-python/tomli[${PYTHON_USEDEP}]
	dev-python/typing-extensions[${PYTHON_USEDEP}]
	dev-python/unearth[${PYTHON_USEDEP}]
	dev-python/virtualenv[${PYTHON_USEDEP}]
"
BDEPEND=""

distutils_enable_tests pytest
