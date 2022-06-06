# Copyright 2021-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="8"

inherit vim-plugin

DESCRIPTION="vim plugin: Asynchronous completion framework for neovim/vim8 "
HOMEPAGE="https://github.com/Shougo/deoplete.nvim"
SRC_URI="https://github.com/Shougo/deoplete.nvim/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/deoplete.nvim-${PV}"

LICENSE="MIT"
KEYWORDS="~amd64"

RDEPEND="dev-python/pynvim"

IUSE="test"
restrict="!test? (test)"

src_prepare(){
	if ! use test; then
		rm -r test || die
	fi

	default
}

src_compile(){
	# ...just WTF...
	:
}
