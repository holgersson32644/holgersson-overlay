# Copyright 2020-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

PYTHON_COMPAT=( python3_{8..9} )
inherit python-r1 vim-plugin

COMMIT_ID="56a4b3621e2d4ce5f5f9f200b860cb9d681d8f8c"

DESCRIPTION="vim plugin: Turn vim into a python IDE"
HOMEPAGE="https://www.vim.org/scripts/script.php?script_id=3770 https://github.com/python-mode/python-mode"
LICENSE="LGPL-3"
IUSE="test"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"
RESTRICT="!test? ( test )"

if [[ ${PV} == *9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/${PN}/${PN}.git"
else
	if [[ ${PV} == *_p* ]]; then
		KEYWORDS="~amd64 ~x86"
		S="${WORKDIR}/${PN}-${COMMIT_ID}"
		SRC_URI="https://github.com/python-mode/${PN}/archive/${COMMIT_ID}.tar.gz -> ${P}.tar.gz"
	else
		KEYWORDS="~amd64 ~x86"
		SRC_URI="https://github.com/python-mode/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
	fi
fi

VIM_PLUGIN_HELPFILES="PythonModeCommands"
VIM_PLUGIN_HELPTEXT=""
VIM_PLUGIN_HELPURI="https://github.com/python-mode/python-mode"
VIM_PLUGIN_MESSAGES="filetype"

RDEPEND="
	${PYTHON_DEPS}
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
	|| (
		app-editors/vim[python,${PYTHON_USEDEP}]
		(
			app-editors/neovim
			dev-python/pynvim[${PYTHON_USEDEP}]
		)
	)
"

src_install() {
	rm -r tests || die
	vim-plugin_src_install
	insinto usr/share/${PN}
}
