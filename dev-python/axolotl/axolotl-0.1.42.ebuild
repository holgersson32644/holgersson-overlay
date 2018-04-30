# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
PYTHON_COMPAT=( python{2_7,3_4,3_5,3_6} )

inherit distutils-r1

DESCRIPTION="Python port of libaxolotl"
HOMEPAGE="https://github.com/tgalal/python-axolotl"

if [[ "${PV}" == *9999 ]]
then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/tgalal/python-${PN}.git"
	KEYWORDS=""
else
	SRC_URI="https://github.com/tgalal/python-${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
	S="${WORKDIR}/python-${P}"
fi

LICENSE="GPL-3"
SLOT="0"
IUSE=""

RDEPEND="dev-libs/protobuf
	dev-python/cryptography[${PYTHON_USEDEP}]
	dev-python/axolotl-curve25519[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]"

DOCS=( README.md )
