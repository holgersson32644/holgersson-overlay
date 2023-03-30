# Copyright 2022-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="8"

LUA_COMPAT=( lua5-{1..4} luajit )

inherit lua-single vim-plugin
COMMIT_ID="09275650b8ae262ac173398976093b60e36e01e8"

DESCRIPTION="neovim plugin: tree sitter support for syntax highlighting"
HOMEPAGE="https://github.com/nvim-treesitter/nvim-treesitter"
LICENSE="Apache-2.0"
MY_PN="nvim-treesitter"

if [[ ${PV} == *9999 ]]
then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/nvim-treesitter/nvim-treesitter.git"
else
	if [[ ${PV} == *_p* ]]; then
		SRC_URI="https://github.com/nvim-treesitter/${MY_PN}/archive/${COMMIT_ID}.tar.gz -> ${P}.gh.tar.gz"
		S="${WORKDIR}/${MY_PN}-${COMMIT_ID}"
	else
		SRC_URI="https://github.com/nvim-treesitter/${MY_PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.gh.tar.gz"
		S="${WORKDIR}/${MY_PN}-${PV}"
	fi
fi

IUSE="test"
REQUIRED_USE="${LUA_REQUIRED_USE}"
RESTRICT="!test? ( test )"
KEYWORDS="~amd64"
RDEPEND="
	app-editors/neovim
	dev-libs/tree-sitter-meta
"

DOCS=(
	CONTRIBUTING.md
	README.md
)

src_compile() {
	# The Makefile runs only tests.
	:;
}

src_install() {
	# We need to get the major and minor version only.
	insinto /usr/share/lua/$(ver_cut 1-2 $(lua_get_version))
	doins -r lua/*
	rm -r lua || die
	vim-plugin_src_install
}
