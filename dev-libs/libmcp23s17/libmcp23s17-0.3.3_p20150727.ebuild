# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

inherit toolchain-funcs

DESCRIPTION="C library for accessing a MCP23S17 port expander"
HOMEPAGE="https://github.com/piface/libmcp23s17/"

if [[ ${PV} == "9999" ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/piface/libmcp23s17.git"
else
	COMMIT_ID="f65a5e2fb2f705eb0a108e1f888da7dea3638c4b"
	SRC_URI="https://github.com/piface/libmcp23s17/archive/${COMMIT_ID}.tar.gz -> ${P}.tar.gz"
	S="${WORKDIR}/libmcp23s17-${COMMIT_ID}"
	KEYWORDS="~arm"
fi

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~arm"
IUSE=""

PATCHES=( "${FILESDIR}"/${PN}-fix-build-system.patch )

DEPEND=""
RDEPEND="${DEPEND}"

src_configure(){
	default

	tc-export CC
}

src_install(){
	dolib ${PN}.so
	doheader src/mcp23s17.h
	einstalldocs
}
