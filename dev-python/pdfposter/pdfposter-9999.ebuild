# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python2_7 python3_5 )
inherit distutils-r1

DESCRIPTION="PDF scaling and tiling tool"
HOMEPAGE="https://gitlab.com/pdftools/pdfposter"

if [[ ${PV} == *9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://gitlab.com/pdftools/pdfposter.git"
	EGIT_BRANCH="develop"
else
	SRC_URI="https://gitlab.com/pdftools/${PN}/repository/v${PV}/archive.tar.gz -> ${P}.tar.gz"
	COMMIT_ID="7999866cb542073f5787c9c35624b8ecd19c35ec"
	KEYWORDS="~amd64 ~x86"
	S="${WORKDIR}/${PN}-v${PV}-${COMMIT_ID}"
fi

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="
	dev-python/PyPDF2[${PYTHON_USEDEP}]
	dev-python/setuptools[${PYTHON_USEDEP}]
"
RDEPEND="${DEPEND}"

python_install_all() {
	distutils-r1_python_install_all
	find "${ED}" -name '*.pth' -delete || die
}
