# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python3_{4,5} )

inherit eutils git-r3

DESCRIPTION="Client for paste.xinu.at"
HOMEPAGE="https://paste.xinu.at"
EGIT_REPO_URI="git://git.server-speed.net/users/flo/fb"

LICENSE="GPL-3"
SLOT="0"

IUSE="+clipboard"

RDEPEND="dev-python/pyxdg
	dev-python/pycurl
	clipboard? ( x11-misc/xclip )"

src_unpack() {
	git-r3_src_unpack
}

src_compile() {
	emake
}
