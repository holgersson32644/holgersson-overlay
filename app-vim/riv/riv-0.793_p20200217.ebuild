# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

inherit vim-plugin

COMMIT_ID="d52844691ca2f139e4b634db65aa49c57a0fc2b3"

DESCRIPTION="vim plugin: Take Notes in rst"
HOMEPAGE="https://github.com/gu-fan/riv.vim"
LICENSE="MIT"
IUSE="test"
RESTRICT="!test? ( test )"

if [[ ${PV} == *9999 ]]
then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/gu-fan/riv.vim.git"
else
	SRC_URI="https://github.com/gu-fan/riv.vim/archive/${COMMIT_ID}.tar.gz -> ${P}.tar.gz"
	S="${WORKDIR}/riv.vim-${COMMIT_ID}"
	KEYWORDS="~amd64 ~x86"
fi

# FIXME/upstream: /usr/share/vim/vimfiles/after/syntax/python.vim file collision
DEPEND="!!app-vim/jedi"
