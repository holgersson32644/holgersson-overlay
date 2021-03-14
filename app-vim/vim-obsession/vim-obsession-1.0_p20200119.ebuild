# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

inherit vim-plugin

COMMIT_ID="96a3f837c112cb64e0a9857b69f6d6a71041155e"

DESCRIPTION="vim plugin: mksession automation tool"
HOMEPAGE="https://www.vim.org/scripts/script.php?script_id=4472 https://github.com/tpope/vim-obsession"
LICENSE="vim"
IUSE="test"
RESTRICT="!test? ( test )"

if [[ ${PV} == *9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/tpope/vim-obsession.git"
else
	if [[ ${PV} == *_p* ]]; then
		SRC_URI="https://github.com/tpope/vim-obsession/archive/${COMMIT_ID}.tar.gz -> ${P}.tar.gz"
		S="${WORKDIR}/vim-obsession-${COMMIT_ID}"
		KEYWORDS="~amd64 ~x86"
	else
		SRC_URI="https://github.com/tpope/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
		KEYWORDS="~amd64 ~x86"
	fi
fi

DOCS=(
	README.markdown
	CONTRIBUTING.markdown
)
