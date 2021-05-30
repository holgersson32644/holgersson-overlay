# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

inherit vim-plugin

COMMIT_ID="8041a909fc3f740e9d110dd2e95980ff4645785b"

DESCRIPTION="vim plugin:  Multiple cursors plugin for vim/neovim"
HOMEPAGE="https://github.com/mg979/vim-visual-multi"
LICENSE="MIT"
IUSE="test"
RESTRICT="!test? ( test )"

if [[ ${PV} == *9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/mg979/vim-visual-multi.git"
else
	if [[ ${PV} == *_p* ]]; then
		SRC_URI="https://github.com/mg979/vim-${PN}/archive/${COMMIT_ID}.tar.gz -> ${P}.tar.gz"
		S="${WORKDIR}/vim-${PN}-${COMMIT_ID}"
		KEYWORDS="~amd64 ~x86"
	else
		SRC_URI="https://github.com/tpope/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
		S="${WORKDIR}/vim-${P}"
		KEYWORDS="~amd64 ~x86"
	fi
fi

DOCS=( README.md )

pkg_postinst(){
	if [[ -z "${REPLACING_VERSIONS}" ]]; then
		# ^this is a new installation, so:
		elog ""
		elog "To start the visual-mode tutorial, run:"
		elog "vim -Nu /usr/share/vim/vimfiles/doc/vm-tutorial"
	fi
}
