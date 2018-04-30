# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
PYTHON_COMPAT=( python2_7 python3_{4,5,6} )

inherit distutils-r1

DESCRIPTION="Python wrapper for the curve25519 library"
HOMEPAGE="https://github.com/gsahbi/python-axolotl-curve25519"

if [[ "${PV}" == *9999 ]]
then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/gsahbi/${PN}.git"
	KEYWORDS=""
else
	SRC_URI="https://github.com/tgalal/python-${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
	S="${WORKDIR}"/python-${P}
fi

LICENSE="GPL-3"
SLOT="0"
IUSE=""

RDEPEND=""
DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]"

DOCS=( README.md )
