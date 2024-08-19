# Copyright 2016-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="8"

PYTHON_COMPAT=( python3_{11..12} )

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

SLOT="0"
KEYWORDS="~amd64"
IUSE="+clipboard"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"
RESTRICT="test" # this packages has no tests

RDEPEND="
	${PYTHON_DEPS}
	dev-python/pyxdg[${PYTHON_USEDEP}]
	dev-python/pycurl[${PYTHON_USEDEP}]
	clipboard? (
			|| (
				x11-misc/xclip
				gui-apps/wl-clipboard
			)
		)
"
