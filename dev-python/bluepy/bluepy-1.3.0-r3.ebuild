# Copyright 2019-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="8"

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..13} )
inherit distutils-r1 pypi

DESCRIPTION="Python module for interfacing with BLE devices through Bluez"
HOMEPAGE="https://github.com/IanHarvey/bluepy https://pypi.org/project/bluepy/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
# Some(sic!) tests need nose which is getting cleaned from main tree.
RESTRICT="test"

BDEPEND="
	dev-python/setuptools[${PYTHON_USEDEP}]
"

distutils_enable_tests pytest
