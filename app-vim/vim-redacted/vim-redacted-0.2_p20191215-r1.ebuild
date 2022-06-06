# Copyright 2021-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="8"

inherit vim-plugin

COMMIT_ID="784aaab9d3ff20846eba6202086d5297efda004f"

DESCRIPTION="vim plugin: Redact text"
HOMEPAGE="https://github.com/dbmrq/vim-redacted"
LICENSE="vim"
IUSE="test"
RESTRICT="!test? ( test )"

if [[ ${PV} == *9999 ]]
then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/dbmrq/vim-redacted.git"
else
	SRC_URI="https://github.com/dbmrq/${PN}/archive/${COMMIT_ID}.tar.gz -> ${P}.tar.gz"
	S="${WORKDIR}/${PN}-${COMMIT_ID}"
	KEYWORDS="~amd64 ~x86"
fi
