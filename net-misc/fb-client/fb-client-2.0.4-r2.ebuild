# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

PYTHON_COMPAT=( python3_{6,7,8} )

inherit eutils python-r1

DESCRIPTION="Client for paste.xinu.at"
HOMEPAGE="https://paste.xinu.at"
LICENSE="GPL-3"

if [[ "${PV}" == *9999 ]]
then
	inherit git-r3
	EGIT_REPO_URI="https://git.server-speed.net/users/flo/fb"
	KEYWORDS=""
else
	SRC_URI="https://paste.xinu.at/data/client/fb-${PV}.tar.gz -> fb-client-${PVR}.tar.gz"
	S="${WORKDIR}/fb-${PV}"
	KEYWORDS="~amd64 ~x86"
fi

SLOT="0"
IUSE="+clipboard"
RESTRICT="test" # this packages has no tests

RDEPEND="
	dev-python/pyxdg[${PYTHON_USEDEP}]
	dev-python/pycurl[${PYTHON_USEDEP}]
	clipboard? ( x11-misc/xclip )
"
