# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

inherit eutils cmake-utils

S="${WORKDIR}/SiriKali-${PV}"

DESCRIPTION="A Qt/C++ GUI front end to some encrypted filesystems and sshfs"
HOMEPAGE="https://github.com/mhogomchungu/sirikali"
SRC_URI="https://github.com/mhogomchungu/${PN}/releases/download/${PV}/${P}.tar.xz"

LICENSE="GPL-2+"
SLOT="0"
IUSE="gnome-keyring kwallet"

KEYWORDS="~amd64 ~x86"

RDEPEND="
	dev-qt/qtcore:5
	dev-qt/qtgui:5
	dev-qt/qtnetwork:5
	dev-qt/qtwidgets:5"

DEPEND="${RDEPEND}
	dev-libs/libgcrypt:0=
	dev-libs/libpwquality
	gnome-keyring? ( app-crypt/libsecret )
	virtual/pkgconfig"

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
	cmake-utils_src_configure
}

src_install() {
	cmake-utils_src_install
}
