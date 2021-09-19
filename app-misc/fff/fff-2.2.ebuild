# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Fucking Fast File-Manager (written in bash)"
HOMEPAGE="https://github.com/dylanaraps/fff"
SRC_URI="https://github.com/dylanaraps/fff/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="
	app-shells/bash:0
	sys-apps/coreutils
	x11-misc/xdg-utils
	www-client/w3m[imlib]
	x11-misc/xdotool
	sys-apps/fbset
"
RDEPEND="${DEPEND}"
BDEPEND=""
