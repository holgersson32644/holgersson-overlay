# Copyright 2020-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="8"

COMMIT_ID=""

DISTUTILS_USE_PEP517=setuptools
PYPI_NO_NORMALIZE=1
PYTHON_COMPAT=( python3_{10..11} )
inherit distutils-r1 pypi

DESCRIPTION="Run docker-compose files without root with podman"
HOMEPAGE="
	https://github.com/containers/podman-compose
	https://pypi.org/project/podman-compose/
"
if [[ ${PV} == *9999 ]]; then
	EGIT_REPO_URI="https://github.com/containers/podman-compose.git"
	inherit git-r3
else
	if [[ ${PV} == *_p* ]]; then
		SRC_URI="https://github.com/containers/podman-compose/archive/${COMMIT_ID}.tar.gz -> ${P}.tar.gz"
		S="${WORKDIR}/podman-compose-${COMMIT_ID}"
	fi
fi
KEYWORDS="~amd64"

LICENSE="GPL-2"
SLOT="0"
IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND="
	app-containers/podman
	dev-python/python-dotenv[${PYTHON_USEDEP}]
	dev-python/pyyaml[${PYTHON_USEDEP}]
"
