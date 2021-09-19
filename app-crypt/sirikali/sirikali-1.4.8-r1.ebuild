# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="8"

inherit cmake

S="${WORKDIR}/SiriKali-${PV}"

DESCRIPTION="A Qt/C++ GUI front end to some encrypted filesystems and sshfs"
HOMEPAGE="https://github.com/mhogomchungu/sirikali"
SRC_URI="https://github.com/mhogomchungu/${PN}/releases/download/${PV}/${P}.tar.xz"

LICENSE="GPL-2+"
SLOT="0"
IUSE="gnome-keyring kwallet test"
RESTRICT="!test? ( test )"
KEYWORDS="~amd64 ~x86"

DEPEND="
	dev-libs/libgcrypt:0=
	dev-libs/libpwquality
	dev-qt/qtcore:5
	dev-qt/qtdbus:5
	dev-qt/qtgui:5
	dev-qt/qtnetwork:5
	dev-qt/qtwidgets:5
	gnome-keyring? ( app-crypt/libsecret )
	virtual/pkgconfig
"

src_configure() {
	local MY_S_FLAG=false
	use kwallet && MY_S_FLAG=true
	use gnome-keyring && MY_S_FLAG=true
	local mycmakeargs=(
		-DCMAKE_INSTALL_PREFIX=/usr
		-DCMAKE_BUILD_TYPE=RELEASE
		-DNOSECRETSUPPORT=${MY_S_FLAG}
		-DNOKDESUPPORT=true
	)
	cmake_src_configure
}
