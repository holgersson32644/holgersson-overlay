# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3_{8,9} )

inherit distutils-r1

DESCRIPTION="Utility for batch-normalizing audio using ffmpeg"
HOMEPAGE="https://github.com/slhck/ffmpeg-normalize"

if [[ ${PV} == *9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="${HOMEPAGE}"
else
	#SRC_URI="${HOMEPAGE}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	SRC_URI="mirror://pypi/${P:0:1}/${PN}/${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="MIT"
SLOT="0"
IUSE=""

DEPEND=""
RDEPEND="
	${DEPEND}
	media-video/ffmpeg
"
