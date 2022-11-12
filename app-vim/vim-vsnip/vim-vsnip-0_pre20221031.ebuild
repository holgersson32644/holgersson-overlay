# Copyright 2021-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="8"

LUA_COMPAT=( lua5-{1..4} luajit )

inherit lua-single vim-plugin
COMMIT_ID="ceeee48145d27f0b3986ab6f75f52a2449974603"

DESCRIPTION="Snippet plugin with support for LSP/VSCode snippet format"
HOMEPAGE="https://github.com/hrsh7th/vim-vsnip"
LICENSE="MIT"

KEYWORDS="~amd64"
IUSE="test"

REQUIRED_USE="${LUA_REQUIRED_USE}"
RESTRICT="test" # needs unpacked packages

if [[ ${PV} == *9999 ]]
then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/hrsh7th/${PN}.git"
else
	if [[ ${PV} == *_p* ]]; then
		SRC_URI="https://github.com/hrsh7th/${PN}/archive/${COMMIT_ID}.tar.gz -> ${P}.tar.gz"
		S="${WORKDIR}/${PN}-${COMMIT_ID}"
	else
		SRC_URI="https://github.com/hrsh7th/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
	fi
fi

RDEPEND="
	app-editors/neovim
	app-vim/vim-vsnip
	app-vim/nvim-lspconfig
"
DOCS=( README.md )

src_compile(){
	# Don't do anything. The Makefile runs only some linter for testing.
	echo
}
