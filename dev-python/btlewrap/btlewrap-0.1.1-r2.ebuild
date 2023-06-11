# Copyright 2019-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="8"

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..12} )
inherit distutils-r1 pypi

DESCRIPTION="wrapper around different bluetooth low energy backends"
HOMEPAGE="https://github.com/ChristianKuehnel/btlewrap https://pypi.org/project/btlewrap/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
# Some(sic!) tests need nose which is getting cleaned from main tree.
RESTRICT="test"

DOCS="README.rst"

RDEPEND="
	dev-python/bluepy[${PYTHON_USEDEP}]
"
BDEPEND="
	dev-python/setuptools[${PYTHON_USEDEP}]
"

src_prepare() {
	sed -i "s/packages=find_packages()/packages=find_packages(exclude=['test','test.*'])/g" setup.py || die
	default
}

distutils_enable_tests pytest
