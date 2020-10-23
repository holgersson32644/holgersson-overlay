# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

COMMIT_ID="4da050236db53ef2652b41c81814574e095cecfa"

# python-ldap doesn't support 3.9 @ 2020-10-22
PYTHON_COMPAT=( python3_{7,8} )
inherit distutils-r1

DESCRIPTION="LDAP web UI written in python"
HOMEPAGE="https://pypi.org/project/ldapcherry https://github.com/kakwa/ldapcherry"

if [[ "${PV}" == *_p* ]]; then
	SRC_URI="https://github.com/kakwa/ldapcherry/archive/${COMMIT_ID}.tar.gz -> ${P}.tar.gz"
else
	SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"
fi

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
S="${WORKDIR}/${PN}-${COMMIT_ID}"

DEPEND=""
RDEPEND="
	${DEPEND}
	dev-python/cherrypy[${PYTHON_USEDEP}]
	dev-python/python-ldap[${PYTHON_USEDEP}]
	dev-python/pyyaml[${PYTHON_USEDEP}]
	dev-python/mako[${PYTHON_USEDEP}]
"
BDEPEND=""
