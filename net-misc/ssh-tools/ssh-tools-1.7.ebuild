# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="8"

PYTHON_COMPAT=( python3_10 )

DESCRIPTION="Library to read data from Mi Flora sensor"
HOMEPAGE="https://github.com/vaporup/ssh-tools"
SRC_URI="https://github.com/vaporup/ssh-tools/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
# Don't run tests as they check the scripts against
# a single hard-coded SSH server.
RESTRICT="test"

DOCS=( "CHANGELOG.md" )

RDEPEND="net-misc/openssh"

src_install(){
	default

	dobin ssh-*
}
