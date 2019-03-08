# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit vim-plugin

DESCRIPTION="vim plugin: Take Notes in rst"
HOMEPAGE="https://github.com/gu-fan/riv.vim"

if [[ ${PV} == *9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/gu-fan/riv.vim.git"
else
	COMMIT_ID="ac64a8c8daaa862b83d27432fe87c79ad2a0c845"
	SRC_URI="https://github.com/gu-fan/riv.vim/archive/${COMMIT_ID}.tar.gz -> ${P}.tar.gz"
	S="${WORKDIR}/riv.vim-${COMMIT_ID}"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="MIT"
# FIXME: /usr/share/vim/vimfiles/after/syntax/python.vim file collision
DEPEND="!!app-vim/jedi"
