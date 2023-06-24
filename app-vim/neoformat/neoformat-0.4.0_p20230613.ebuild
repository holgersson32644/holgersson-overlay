# Copyright 2022-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="8"

inherit vim-plugin
COMMIT_ID="1412d2016a772aef6aea818c840eb7803ade0312"

DESCRIPTION="vim plugin: in-buffer formatter runner"
HOMEPAGE="https://github.com/sbdchd/neoformat"

if [[ ${PV} == *9999 ]]
then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/sbdchd/neoformat.git"
else
	if [[ ${PV} == *_p* ]]; then
		SRC_URI="https://github.com/sbdchd/${PN}/archive/${COMMIT_ID}.tar.gz -> ${P}.tar.gz"
		S="${WORKDIR}/${PN}-${COMMIT_ID}"
	else
		SRC_URI="https://github.com/sbdchd/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
	fi
fi

LICENSE="BSD-2"
IUSE="test"
RESTRICT="!test? ( test )"
KEYWORDS="~amd64 ~x86"

DOCS=( README.md )

src_compile() {
	# The Makefile runs only tests.
	:;
}
