# Copyright 2021-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="8"

LUA_COMPAT=( lua5-{1..4} luajit )
PYTHON_COMPAT=( python3_10 )


DISTUTILS_USE_PEP517="no"
inherit lua-single distutils-r1 vim-plugin
COMMIT_ID="4999ac625ac1911fab192915ec2feb88fbc05b6b"

DESCRIPTION="neovim plugin: fast completion"
HOMEPAGE="https://github.com/ms-jpq/coq_nvim"

LICENSE="GPL-3"
KEYWORDS="~amd64"
IUSE="test"
REQUIRED_USE="${LUA_REQUIRED_USE}"

MY_PN="${PN/-/_}"

if [[ ${PV} == *9999 ]]
then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/ms-jpq/${MY_PN}.git"
else
	if [[ ${PV} == *_p* ]]; then
		SRC_URI="https://github.com/ms-jpq/${MY_PN}/archive/${COMMIT_ID}.tar.gz -> ${P}.tar.gz"
		S="${WORKDIR}/${MY_PN}-${COMMIT_ID}"
	else
		SRC_URI="https://github.com/ms-jpq/${MY_PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
	fi
fi

RDEPEND="
	app-editors/neovim
	dev-db/sqlite
	dev-python/pynvim[${PYTHON_USEDEP}]
	dev-python/pyyaml[${PYTHON_USEDEP}]
"

DOCS=(
	docs/CONF.md
	docs/CUSTOM_SOURCES.md
	docs/DISPLAY.md
	docs/FUZZY.md
	docs/KEYBIND.md
	docs/MISC.md
	docs/PERF.md
	docs/README.md
	docs/SNIPS.md
	docs/SOURCES.md
	docs/STATS.md
)

src_install(){
	# We need to get the major and minor version only.
	insinto /usr/share/lua/$(ver_cut 1-2 $(lua_get_version))
	doins -r lua/*
	rm -r lua || die

	vim-plugin_src_install
}
