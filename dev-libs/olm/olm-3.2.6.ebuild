# Copyright 2020-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="8"

PYTHON_COMPAT=( python3_{9..10} )

inherit cmake distutils-r1

DESCRIPTION="Implementation of the olm and megolm cryptographic ratchets"
HOMEPAGE="https://gitlab.matrix.org/matrix-org/olm"
SRC_URI="https://gitlab.matrix.org/matrix-org/${PN}/-/archive/${PV}/${P}.tar.bz2"

LICENSE="Apache-2.0"
SLOT="0"
IUSE="python test"
KEYWORDS="~amd64"
RESTRICT="!test? ( test )"
DEPEND="python? ( dev-python/cffi[${PYTHON_USEDEP}] )"

DOCS=( README.md docs/{{,meg}olm,signing}.md )

src_prepare() {
	default

	cmake_src_prepare

	if use python; then
		pushd "${S}/python" > /dev/null || die
		distutils-r1_src_prepare
		popd > /dev/null || die
	fi
}

src_configure() {
	local -a mycmakeargs=(
		-DOLM_TESTS="$(usex test)"
	)
	cmake_src_configure

	if use python; then
		pushd python > /dev/null || die
		distutils-r1_src_configure
		popd > /dev/null || die
	fi
}

src_compile(){
	cmake_src_compile

	if use python; then
		pushd python > /dev/null || die
		distutils-r1_src_compile
		popd > /dev/null || die
	fi
}

src_install() {
	cmake_src_install

	if use python; then
		pushd python > /dev/null || die
		distutils-r1_src_install
		popd > /dev/null || die
	fi
}

src_test() {
	BUILD_DIR="${BUILD_DIR}/tests" cmake_src_test
}
