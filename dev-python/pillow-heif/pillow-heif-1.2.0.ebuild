# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{13..14} )

inherit distutils-r1 pypi

DESCRIPTION="Binding for libheif, standalone or as pillow plugin"
HOMEPAGE="
	https://pypi.org/project/pillow-heif/
	https://github.com/bigcat88/pillow_heif
"

# The code of this package itself is licensed as BSD.
# GPL and LGPL versions are used for binary wheels bundling libheif.
# See https://github.com/bigcat88/pillow_heif/issues/302.
LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="!test? ( test )"

DEPEND="
	dev-python/pillow[jpeg2k,lcms,${PYTHON_USEDEP}]
"
RDEPEND="
	${DEPEND}
	media-libs/libheif
"
BDEPEND="
	${DEPEND}
"

EPYTEST_PLUGINS=()
distutils_enable_tests pytest
