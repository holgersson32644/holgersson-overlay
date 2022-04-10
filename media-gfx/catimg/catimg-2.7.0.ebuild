# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="Terminal image renderer, C/binary version"
HOMEPAGE="https://github.com/posva/catimg"
SRC_URI="https://github.com/posva/catimg/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
