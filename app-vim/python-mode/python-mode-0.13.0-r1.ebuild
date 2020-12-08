# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

PYTHON_COMPAT=( python3_8 )
inherit python-r1 vim-plugin

COMMIT_ID="295e84d9dd7f4887f8a5635e9dfe88dfeabaf00c"

DESCRIPTION="vim plugin: Turn vim into a python IDE"
HOMEPAGE="http://www.vim.org/scripts/script.php?script_id=3770 https://github.com/klen/python-mode"
LICENSE="LGPL-3"
IUSE="test"
RESTRICT="!test? ( test )"

if [[ ${PV} == *9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/${PN}/${PN}.git"
else
	if [[ ${PV} == *_p* ]]; then
		KEYWORDS="~amd64 ~x86"
		S="${WORKDIR}/${PN}-${COMMIT_ID}"
		SRC_URI="https://github.com/klen/${PN}/archive/${COMMIT_ID}.tar.gz -> ${P}.tar.gz"
	else
		KEYWORDS="~amd64 ~x86"
		SRC_URI="https://github.com/klen/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
	fi
fi

VIM_PLUGIN_HELPFILES="PythonModeCommands"
VIM_PLUGIN_HELPTEXT=""
VIM_PLUGIN_HELPURI="https://github.com/klen/python-mode"
VIM_PLUGIN_MESSAGES="filetype"

RDEPEND="
	dev-python/astroid[${PYTHON_USEDEP}]
	dev-python/autopep8[${PYTHON_USEDEP}]
	dev-python/mccabe[${PYTHON_USEDEP}]
	dev-python/pycodestyle[${PYTHON_USEDEP}]
	dev-python/pydocstyle[${PYTHON_USEDEP}]
	dev-python/pyflakes[${PYTHON_USEDEP}]
	dev-python/pylama[${PYTHON_USEDEP}]
	>=dev-python/pylint-2.2.2[${PYTHON_USEDEP}]
	dev-python/rope[${PYTHON_USEDEP}]
	dev-python/ropemode[${PYTHON_USEDEP}]
	dev-python/six[${PYTHON_USEDEP}]
	dev-python/snowballstemmer[${PYTHON_USEDEP}]
"

src_install() {
	vim-plugin_src_install
	insinto usr/share/${PN}
}
