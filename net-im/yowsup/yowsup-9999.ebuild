# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
PYTHON_COMPAT=( python2_7 python3_{4,5,6} )
PYTHON_REQ_USE="readline"

inherit distutils-r1

DESCRIPTION="Python WhatsApp library and CLI client"
HOMEPAGE="https://github.com/tgalal/yowsup"

if [[ "${PV}" == *9999 ]]
then
		inherit git-r3
		EGIT_REPO_URI="https://github.com/tgalal/${PN}.git"
		KEYWORDS=""
else
		SRC_URI="https://github.com/tgalal/yowsup/archive/v${PV}.tar.gz -> ${P}.tar.gz"
		KEYWORDS="~amd64 ~x86"
fi

LICENSE="GPL-3"
SLOT="0"
IUSE=""

# we let depend axolotl on >=protobuf-3.1.0, so let's do
# the same here (latest stable at 2018-02-14).
RDEPEND=">=dev-python/axolotl-0.1.39[${PYTHON_USEDEP}]
	dev-python/python-dateutil[${PYTHON_USEDEP}]
	dev-python/pillow[${PYTHON_USEDEP}]
	dev-python/configargparse[${PYTHON_USEDEP}]
	>=dev-libs/protobuf-3.1.0
	dev-python/pycryptodome[${PYTHON_USEDEP}]
	dev-python/axolotl-curve25519[${PYTHON_USEDEP}]
	dev-python/six[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]"

DOCS=( README.md )
