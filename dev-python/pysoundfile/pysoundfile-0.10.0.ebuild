# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

PYTHON_COMPAT=( python2_7 python3_{3,4,5} pypy pypy3 )

inherit distutils-r1

MY_PN="SoundFile"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="PySoundFile is an audio library based on libsndfile, CFFI, and NumPy"
HOMEPAGE="https://github.com/bastibe/PySoundFile"
#SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz -> ${PN}.${PV}.tar.gz"
SRC_URI="https://github.com/bastibe/SoundFile/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="PySoundFile-BSD-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-python/cffi
	dev-python/numpy
	media-libs/libsndfile"

S="${WORKDIR}/${MY_P}"

python_test() {
	esetup.py test
}
