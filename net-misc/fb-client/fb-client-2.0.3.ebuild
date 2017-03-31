# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python3_{4,5} )

inherit eutils

DESCRIPTION="Client for paste.xinu.at"
HOMEPAGE="https://paste.xinu.at"
SRC_URI="https://paste.xinu.at/data/client/fb-${PV}.tar.gz -> fb-client-${PVR}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="+clipboard"

RDEPEND="dev-python/pyxdg
		dev-python/pycurl
		clipboard? ( x11-misc/xclip )"

S="${WORKDIR}/fb-${PV}"
