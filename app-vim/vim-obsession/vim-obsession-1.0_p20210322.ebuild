# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

inherit vim-plugin

COMMIT_ID="82c9ac5e130c92a46e043dd9cd9e5b48d15e286d"

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
	else
		SRC_URI="https://github.com/tpope/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	fi
fi
KEYWORDS="~amd64 ~x86"

DOCS=(
	README.markdown
	CONTRIBUTING.markdown
)
