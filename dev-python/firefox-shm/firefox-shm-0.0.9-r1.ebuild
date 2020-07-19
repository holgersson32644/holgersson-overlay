# Copyright 2019-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{7,8,9} )
inherit distutils-r1 linux-info

DESCRIPTION="Use tmpfs on /dev/shm to store the firefox profile"
HOMEPAGE="https://bitbucket.org/igraltist/firefox-shm"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RESTRICT="test" # this packages has no tests, so don't waste computation time

DEPEND="net-misc/rsync"
RDEPEND="${DEPEND}"
BDEPEND=""

pkg_setup() {
	CONFIG_CHECK="~SHMEM"
}
