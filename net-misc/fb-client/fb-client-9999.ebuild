# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils git-2

DESCRIPTION="Client for paste.xinu.at"
HOMEPAGE="https://paste.xinu.at"
EGIT_REPO_URI="git://git.server-speed.net/users/flo/fb"

LICENSE="GPL-3"
SLOT="0"

src_unpack() {
	git-2_src_unpack
}

src_compile() {
	emake
}
