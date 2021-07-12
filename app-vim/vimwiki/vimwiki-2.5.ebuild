# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

inherit vim-plugin

DESCRIPTION="vim plugin: Personal Wiki"
HOMEPAGE="https://github.com/vimwiki/vimwiki"
LICENSE="MIT"
IUSE="test"
RESTRICT="!test? ( test )"

if [[ ${PV} == *9999 ]]
then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/vimwiki/vimwiki.git"
else
	SRC_URI="https://github.com/${PN}/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

DOCS=(
	CONTRIBUTING.md
	DesignNotes.md
	README.md
	README-cn.md
)

src_prepare() {
	default

	if ! use test; then
		rm -r test Dockerfile || die
	fi
	# We store the appropriate license information inside the portage tree.
	rm -r LICENSE.md || die
}

pkg_postinst() {
	if [[ -z "${REPLACING_VERSIONS}" ]]; then
		# ^this is a new installation, so:
		elog ""
		elog "Please ensure that you have set the following in your vimrc:"
		elog "set nocompatible"
		elog "set filetype plugin on"
		elog "syntax on"
		elog "For details see https://github.com/vimwiki/vimwiki#prerequisites"
	fi
}
