# Copyright 2020-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="8"

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..11} )
inherit distutils-r1

DESCRIPTION="Python library for using HDF5 formatted files, incl. MAT files"
HOMEPAGE="
	https://github.com/frejanordsiek/hdf5storage
	https://pythonhosted.org/hdf5storage/
	https://pypi.org/project/hdf5storage/
"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
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
