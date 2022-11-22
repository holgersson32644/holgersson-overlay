# Copyright 2016-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="8"

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..11} )
inherit distutils-r1

COMMIT_ID=""

DESCRIPTION="SoundFile is an audio library based on libsndfile, CFFI, and NumPy"
HOMEPAGE="https://github.com/bastibe/python-soundfile"

if [[ ${PV} == *9999 ]]; then
	EGIT_REPO_URI="https://github.com/bastibe/python-${PN}"
	inherit git-r3
else
	if [[ (${PV} == *_p*) || (${PV} == *_beta*) ]]; then
		SRC_URI="https://github.com/bastibe/python-${PN}/archive/${COMMIT_ID}.tar.gz -> ${P}.tar.gz"
		S="${WORKDIR}/python-${PN}-${COMMIT_ID}"
	else
		SRC_URI="https://github.com/bastibe/python-${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
		S="${WORKDIR}/python-${P}"
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
"

distutils_enable_tests pytest
