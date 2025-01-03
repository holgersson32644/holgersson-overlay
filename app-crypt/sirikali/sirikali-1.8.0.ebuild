# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="8"

inherit cmake

DESCRIPTION="A Qt/C++ GUI front end to some encrypted filesystems and sshfs"
HOMEPAGE="
	https://mhogomchungu.github.io/sirikali/
	https://github.com/mhogomchungu/sirikali
"
SRC_URI="https://github.com/mhogomchungu/${PN}/releases/download/${PV}/${P}.tar.xz"
S="${WORKDIR}/SiriKali-${PV}"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="~amd64"
IUSE="gnome-keyring kwallet +pwquality test"
RESTRICT="!test? ( test )"

DEPEND="
	dev-qt/qtbase:6[dbus,gui,network,widgets]
	dev-libs/libgcrypt:0=
	gnome-keyring? ( app-crypt/libsecret )
	kwallet? ( kde-frameworks/kwallet )
	pwquality? ( dev-libs/libpwquality )
"

src_configure() {
	local MY_ENABLE_SECRETS=false
	use kwallet && MY_ENABLE_SECRETS=true
	use gnome-keyring && MY_ENABLE_SECRETS=true
	local mycmakeargs=(
		-DNOSECRETSUPPORT=${MY_ENABLE_SECRETS}
		-DBUILD_WITH_QT6=true
	)
	cmake_src_configure
}
