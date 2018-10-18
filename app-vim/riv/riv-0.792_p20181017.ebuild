# Copyright 1999-2018 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit vim-plugin

DESCRIPTION="vim plugin: Take Notes in rst"
HOMEPAGE="https://github.com/gu-fan/riv.vim"

if [[ ${PV} == *9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/gu-fan/riv.vim.git"
else
	COMMIT_ID="09ae81f1fcf43d77a36705a7b9201f8cc1c85e23"
	SRC_URI="https://github.com/gu-fan/riv.vim/archive/${COMMIT_ID}.tar.gz -> ${P}.tar.gz"
	S="${WORKDIR}/riv.vim-${COMMIT_ID}"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="MIT"
