# Copyright 2016-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="8"

PYTHON_COMPAT=( python3_{8..9} )

inherit python-r1

DESCRIPTION="Client for paste.xinu.at"
HOMEPAGE="https://paste.xinu.at https://git.server-speed.net/users/flo/fb/"
LICENSE="GPL-3"

if [[ "${PV}" == *9999 ]]
then
	inherit git-r3
	EGIT_REPO_URI="https://git.server-speed.net/users/flo/fb"
else
	SRC_URI="https://paste.xinu.at/data/client/fb-${PV}.tar.gz -> fb-client-${PVR}.tar.gz"
	S="${WORKDIR}/fb-${PV}"
fi

#KEYWORDS="~amd64 ~x86"
SLOT="0"
IUSE="+clipboard"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"
RESTRICT="test" # this packages has no tests

RDEPEND="
	${PYTHON_DEPS}
	dev-python/pyxdg[${PYTHON_USEDEP}]
	dev-python/pycurl[${PYTHON_USEDEP}]
	clipboard? ( x11-misc/xclip )
"
