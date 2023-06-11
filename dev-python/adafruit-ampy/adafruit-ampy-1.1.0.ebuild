# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="8"

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..12} )
PYPI_NO_NORMALIZE=1
inherit distutils-r1 pypi

DESCRIPTION="Adafruit MicroPython tool"
HOMEPAGE="
	https://github.com/scientifichackers/ampy
	https://pypi.org/project/adafruit-ampy/
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"
#RESTRICT="!test? ( test )"
# following test do fail currently (2023-02-19)
# tests/test_files.py::TestFiles::test_get_with_data
# tests/test_files.py::TestFiles::test_run_with_output#
# tests/test_files.py::TestFiles::test_run_without_output

#RESTRICT="test"

RDEPEND="
	dev-python/click[${PYTHON_USEDEP}]
	dev-python/pyserial[${PYTHON_USEDEP}]
	dev-python/python-dotenv[${PYTHON_USEDEP}]
"

distutils_enable_tests pytest
