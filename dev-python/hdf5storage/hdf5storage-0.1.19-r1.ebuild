# Copyright 2020-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="8"

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..12} )
inherit distutils-r1 pypi

DESCRIPTION="Python library for using HDF5 formatted files, incl. MAT files"
HOMEPAGE="
	https://github.com/frejanordsiek/hdf5storage
	https://pythonhosted.org/hdf5storage/
	https://pypi.org/project/hdf5storage/
"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="doc"
# Tests need nose which is getting cleaned from main tree.
RESTRICT="test"

DEPEND=""
RDEPEND="
	${DEPEND}
	dev-python/h5py[${PYTHON_USEDEP}]
	dev-python/numpy[${PYTHON_USEDEP}]
"
BDEPEND="
	app-arch/unzip
	doc? ( dev-python/sphinx[${PYTHON_USEDEP}] )
"
