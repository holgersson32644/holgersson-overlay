# Copyright 2016-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="8"

PYTHON_COMPAT=( python3_{9..10} )

inherit distutils-r1

COMMIT_ID="8439fc1c5a88850213de04dc5f1a7d0bf06fab89"

DESCRIPTION="SoundFile is an audio library based on libsndfile, CFFI, and NumPy"
HOMEPAGE="https://github.com/bastibe/python-soundfile"

if [[ ${PV} == *9999 ]]; then
	EGIT_REPO_URI="https://github.com/bastibe/python-${PN}"
	inherit git-r3
else
	if [[ ${PV} == *_p* ]]; then
		SRC_URI="https://github.com/bastibe/python-${PN}/archive/${COMMIT_ID}.tar.gz -> ${P}.tar.gz"
		S="${WORKDIR}/python-${PN}-${COMMIT_ID}"
	else
		SRC_URI="https://github.com/bastibe/python-${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
	fi
fi
KEYWORDS="~amd64 ~x86"

LICENSE="PySoundFile-BSD-3"
SLOT="0"
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
