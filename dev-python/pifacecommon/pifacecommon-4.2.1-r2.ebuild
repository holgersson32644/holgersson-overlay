# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python2_7 python3_6 )

inherit distutils-r1

DESCRIPTION="Common functions for interacting with PiFace products"
HOMEPAGE="https://github.com/piface/pifacecommon"

if [[ ${PV} == *9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/piface/pifacecommon.git"
else
	SRC_URI="https://github.com/piface/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~arm"
fi

LICENSE="GPL-3"
SLOT="0"
IUSE=""

PATCHES=( "${FILESDIR}"/${PN}-4.2.1-fix_speed.patch )

DEPEND="dev-libs/libpifacedigital"
RDEPEND="${DEPEND}"
