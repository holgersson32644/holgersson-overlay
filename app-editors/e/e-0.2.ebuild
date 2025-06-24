# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="wrapper to handle $EDITOR file:lineno"
HOMEPAGE="https://github.com/kilobyte/e"
SRC_URI="https://github.com/kilobyte/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="dev-lang/perl:="
DOCS=(
	README.md
)

src_install() {
	doman "${PN}.1"
	dobin "${PN}"
	dodoc
}
