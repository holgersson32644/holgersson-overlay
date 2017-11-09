# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

PYTHON_COMPAT=( python3_{4,5} )

inherit eutils

if [[ "${PV}" == "9999" ]]
then
	inherit https-r3
	EGIT_REPO_URI="https://git.server-speed.net/users/flo/fb"
else
	SRC_URI="https://paste.xinu.at/data/client/fb-${PV}.tar.gz -> fb-client-${PVR}.tar.gz"
	S="${WORKDIR}/fb-${PV}"
fi

DESCRIPTION="Client for paste.xinu.at"
HOMEPAGE="https://paste.xinu.at"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="+clipboard"

RDEPEND="
		dev-python/pyxdg
		dev-python/pycurl
		clipboard? ( x11-misc/xclip )
"
