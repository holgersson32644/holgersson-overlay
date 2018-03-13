# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python2_7 python3_5 )

inherit distutils-r1

DESCRIPTION="The PiFace Digital input/output module"
HOMEPAGE="https://github.com/piface/pifacedigitalio"

if [[ ${PV} == "9999" ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/piface/pifacedigitalio.git"
else
	SRC_URI="https://github.com/piface/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~arm"
fi

LICENSE="GPL-3"
SLOT="0"
IUSE=""

DEPEND="dev-python/pifacecommon"
RDEPEND="${DEPEND}"
