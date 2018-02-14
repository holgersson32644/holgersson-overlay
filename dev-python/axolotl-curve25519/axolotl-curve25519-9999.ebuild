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
		COMMIT_ID="2080fe76fa163ce76408bb8a95e17ac1cd5c3f7c"
		SRC_URI="https://github.com/gsahbi/python-${PN}/archive/${COMMIT_ID}.tar.gz -> ${P}.tar.gz"
		S="${WORKDIR}/python-${PN}-${COMMIT_ID}"
		KEYWORDS="~x86 ~amd64"
fi

LICENSE="GPL-3"
SLOT="0"
IUSE=""

RDEPEND=""
DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]"

DOCS=( README.md )
