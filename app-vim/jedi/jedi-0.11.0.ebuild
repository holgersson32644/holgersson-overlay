# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{9..10} )

inherit vim-plugin python-single-r1

DESCRIPTION="vim plugin: binding to the autocompletion library jedi"
HOMEPAGE="https://github.com/davidhalter/jedi-vim"
SRC_URI="https://github.com/davidhalter/jedi-vim/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
KEYWORDS="~amd64 ~arm64 ~x86"
IUSE="test"

REQUIRED_USE="${PYTHON_REQUIRED_USE}"

RDEPEND="
	${PYTHON_DEPS}
	$(python_gen_cond_dep 'dev-python/jedi[${PYTHON_USEDEP}]')
	app-editors/vim[python]"
BDEPEND="${PYTHON_DEPS}
	test? ( dev-python/pytest )"

S="${WORKDIR}/jedi-vim-${PV}"

# Tests are broken.
RESTRICT="test"

src_prepare(){
	if ! use test; then
		rm -r test || die
	fi

	default
}

# Makefile tries hard to call tests so let's silence this phase.
src_compile() { :; }

src_test() {
	epytest
}