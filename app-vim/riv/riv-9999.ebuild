# Copyright 2018-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

inherit vim-plugin

COMMIT_ID="201ffc4e8dbfc3deeb26c6e278980f53d81d7f6a"

DESCRIPTION="vim plugin: Take Notes in rst"
HOMEPAGE="https://github.com/gu-fan/riv.vim"
LICENSE="MIT"
IUSE="test"
RESTRICT="!test? ( test )"

if [[ ${PV} == *9999 ]]
then
	inherit git-r3
#	EGIT_REPO_URI="https://git.holgersson.xyz/mirror/riv.vim"
	EGIT_REPO_URI="https://github.com/gu-fan/riv.vim.git"
else
	SRC_URI="https://github.com/gu-fan/riv.vim/archive/${COMMIT_ID}.tar.gz -> ${P}.tar.gz"
	S="${WORKDIR}/riv.vim-${COMMIT_ID}"
	KEYWORDS="~amd64 ~x86"
fi

# FIXME/upstream: /usr/share/vim/vimfiles/after/syntax/python.vim file collision
DEPEND="!!app-vim/jedi"
