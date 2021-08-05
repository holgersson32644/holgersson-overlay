# Copyright 2020-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{8..10} )
DISTUTILS_USE_SETUPTOOLS=rdepend
inherit distutils-r1

COMMIT_ID="ff5b9f16632dcab4be6d0f666263f58ad668c105"

DESCRIPTION="Run docker-compose files without root with podman"
HOMEPAGE="https://pypi.org/project/podman-compose/ https://github.com/containers/podman-compose"

if [[ ${PV} == *9999 ]]; then
	EGIT_REPO_URI="https://github.com/containers/podman-compose.git"
	inherit git-r3
else
	if [[ ${PV} == *_p* ]]; then
		SRC_URI="https://github.com/containers/podman-compose/archive/${COMMIT_ID}.tar.gz -> ${P}.tar.gz"
		S="${WORKDIR}/podman-compose-${COMMIT_ID}"
		KEYWORDS="~amd64 ~x86"
	else
		SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"
		KEYWORDS="~amd64 ~x86"
		S="${WORKDIR}/qTox-${PV}"
	fi
fi

LICENSE="GPL-2"
SLOT="0"
IUSE="test"
RESTRICT="!test? ( test )"

DEPEND=""
RDEPEND="
	${DEPEND}
	dev-python/pyyaml[${PYTHON_USEDEP}]
"
BDEPEND=""
