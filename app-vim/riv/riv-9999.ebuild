# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

inherit vim-plugin

COMMIT_ID="87a1f2c1e487ee0021855fd0c65c3f3244f4fc61"

DESCRIPTION="vim plugin: Take Notes in rst"
HOMEPAGE="https://github.com/gu-fan/riv.vim"

if [[ ${PV} == *9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/gu-fan/riv.vim.git"
else
	SRC_URI="https://github.com/gu-fan/riv.vim/archive/${COMMIT_ID}.tar.gz -> ${P}.tar.gz"
	S="${WORKDIR}/riv.vim-${COMMIT_ID}"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="MIT"
# FIXME/upstream: /usr/share/vim/vimfiles/after/syntax/python.vim file collision
DEPEND="!!app-vim/jedi"
