# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_6 )
inherit distutils-r1 linux-info

DESCRIPTION="Use tmpfs on /dev/shm to store firefox profile"
HOMEPAGE="https://bitbucket.org/igraltist/firefox-shm"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="net-misc/rsync"
RDEPEND="${DEPEND}"
BDEPEND=""

pkg_setup() {
	CONFIG_CHECK="~SHMEM"
}
