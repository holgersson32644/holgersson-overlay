# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

# drop pypy{,3} as long as cffi has no support for it
PYTHON_COMPAT=( python3_{5,6,7} )

inherit distutils-r1

MY_PN="SoundFile"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="SoundFile is an audio library based on libsndfile, CFFI, and NumPy"
HOMEPAGE="https://github.com/bastibe/SoundFile"
# Upstream messes around whith uploading files. Cool.
# SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz -> ${P}.tar.gz"
SRC_URI="https://github.com/bastibe/SoundFile/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="PySoundFile-BSD-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

DEPEND="dev-python/cffi[${PYTHON_USEDEP}]
	dev-python/numpy[${PYTHON_USEDEP}]
	media-libs/libsndfile
	test? ( dev-python/pytest[${PYTHON_USEDEP}] )"

S="${WORKDIR}/${MY_P}"

python_test() {
	py.test -vv
}
