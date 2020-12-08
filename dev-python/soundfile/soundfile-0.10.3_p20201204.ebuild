# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

# drop pypy{,3} as long as cffi has no support for it
PYTHON_COMPAT=( python3_{8..9} )

inherit distutils-r1

MY_PN="SoundFile"
MY_P="${MY_PN}-${PV}"

COMMIT_ID="744efb4b01abc72498a96b09115b42a4cabd85e4"

DESCRIPTION="SoundFile is an audio library based on libsndfile, CFFI, and NumPy"
HOMEPAGE="https://github.com/bastibe/SoundFile"

if [[ ${PV} == *9999 ]]; then
	EGIT_REPO_URI="https://github.com/bastibe/SoundFile"
	inherit git-r3
else
	if [[ ${PV} == *_p* ]]; then
		SRC_URI="https://github.com/bastibe/SoundFile/archive/${COMMIT_ID}.tar.gz -> ${P}.tar.gz"
		S="${WORKDIR}/python-soundfile-${COMMIT_ID}"
		KEYWORDS="~amd64 ~x86"
	else
		# Upstream messes around whith uploading files. Cool
		# SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz -> ${P}.tar.gz"
		SRC_URI="https://github.com/bastibe/SoundFile/archive/${PV}.tar.gz -> ${P}.tar.gz"
		KEYWORDS="~amd64 ~x86"
	fi
fi

LICENSE="PySoundFile-BSD-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"
# Some tests result in sandbox violations.
RESTRICT="test"

DEPEND="
	dev-python/cffi[${PYTHON_USEDEP}]
	dev-python/numpy[${PYTHON_USEDEP}]
	media-libs/libsndfile
	test? ( dev-python/pytest[${PYTHON_USEDEP}] )
"

python_test() {
	py.test -vv
}
