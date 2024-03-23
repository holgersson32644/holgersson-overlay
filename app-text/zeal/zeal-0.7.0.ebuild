# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake xdg-utils

MY_PV="${PV/_rc/-RC}"
COMMIT_ID="90ad776e83f182221cafd329f2e58cf0621ea3f1"

DESCRIPTION="Offline documentation browser inspired by Dash"
HOMEPAGE="
	https://zealdocs.org
	https://github.com/zealdocs/zeal
"
LICENSE="GPL-3"

if [[ ${PV} == *9999 ]]; then
	EGIT_REPO_URI="https://github.com/zealdocs/${PN}.git"
	inherit git-r3
else
	if [[ ${PV} == *_p* ]]; then
		SRC_URI="https://github.com/zealdocs/${PN}/archive/${COMMIT_ID}.tar.gz -> ${P}.tar.gz"
		S="${WORKDIR}/${PN}-${COMMIT_ID}"
	else
		SRC_URI="https://github.com/zealdocs/${PN}/archive/v${MY_PV}.tar.gz -> ${P}.tar.gz"
		S="${WORKDIR}/$PN-${MY_PV}/"
	fi
fi
KEYWORDS="~amd64 ~x86"

SLOT="0"
IUSE=""

DEPEND="
	app-arch/libarchive:=
	dev-db/sqlite:3
	dev-qt/qtbase:6[concurrent,gui,network,sqlite,widgets]
	dev-qt/qtwebengine:6[widgets]
	dev-qt/qtwebchannel:6
	x11-libs/libX11
	x11-libs/libxcb:=
	x11-libs/xcb-util-keysyms
"
RDEPEND="${DEPEND}
	x11-themes/hicolor-icon-theme
"
BDEPEND="kde-frameworks/extra-cmake-modules:0"

PATCHES=(
	"${FILESDIR}/${PN}-0.7.0-settings-disable-checking-for-updates-by-default.patch"
	"${FILESDIR}/${PN}-0.7.0-CMakeLists-Disable-Werror.patch"
)

src_configure() {
	local mycmakeargs=(
		-D QT_DIR=/usr/$(get_libdir)/cmake/Qt6
		-D CMAKE_BUILD_TYPE=Release
		# Default string is ${PV}-dev when self-compiled, even from releases.
		-D ZEAL_VERSION=${PV}-gentoo
	)
	cmake_src_configure
}

pkg_postinst() {
	xdg_icon_cache_update
	xdg_desktop_database_update

	if [[ -z "${REPLACING_VERSIONS}" ]]; then
		elog ""
		elog "If you are interested in dash cheat sheets, you will need to add the XML links"
		elog "manually from https://zealusercontributions.vercel.app/cheatsheets."
		elog "For details see the upstream issue:"
		elog "https://github.com/zealdocs/zeal/issues/498#issuecomment-1848423041"
	fi
}

pkg_postrm() {
	xdg_icon_cache_update
	xdg_desktop_database_update
}
