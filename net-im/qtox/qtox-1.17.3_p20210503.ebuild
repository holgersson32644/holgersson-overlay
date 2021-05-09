# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

inherit cmake gnome2-utils xdg-utils

COMMIT_ID="8c34fa8f7d34e6555533f392925164b47da12d8c"

DESCRIPTION="Most feature-rich GUI for net-libs/tox using Qt5"
HOMEPAGE="https://github.com/qTox/qTox"

if [[ ${PV} == *9999 ]]; then
	EGIT_REPO_URI="https://github.com/qTox/qTox.git"
	inherit git-r3
else
	if [[ ${PV} == *_p* ]]; then
		#KEYWORDS="~amd64 ~x86"
		SRC_URI="https://github.com/qTox/qTox/archive/${COMMIT_ID}.tar.gz -> ${P}.tar.gz"
		S="${WORKDIR}/qTox-${COMMIT_ID}"
	else
		KEYWORDS="~amd64 ~x86"
		SRC_URI="https://github.com/qTox/qTox/archive/v${PV}.tar.gz -> ${P}.tar.gz"
		S="${WORKDIR}/qTox-${PV}"
	fi
fi

LICENSE="GPL-3+"
SLOT="0"
IUSE="+auto-away +notification spell test"
RESTRICT="!test? ( test )"

BDEPEND="
	dev-qt/linguist-tools:5
	virtual/pkgconfig
"
RDEPEND="
	dev-db/sqlcipher
	dev-libs/libsodium:=
	dev-qt/qtconcurrent:5
	dev-qt/qtcore:5
	dev-qt/qtgui:5[gif,jpeg,png,X(-)]
	dev-qt/qtnetwork:5
	dev-qt/qtopengl:5
	dev-qt/qtsql:5
	dev-qt/qtsvg:5
	dev-qt/qtwidgets:5
	dev-qt/qtxml:5
	media-gfx/qrencode:=
	media-libs/libexif:=
	media-libs/openal
	media-video/ffmpeg:=[webp,v4l]
	net-libs/tox:0/0.2[av]
	notification? (	x11-libs/snorenotify )
	auto-away? (
		x11-libs/libX11
		x11-libs/libXScrnSaver
	)
	spell? ( kde-frameworks/sonnet )
"
DEPEND="${RDEPEND}
	dev-qt/linguist-tools:5
	virtual/pkgconfig
	test? ( dev-qt/qttest:5 )
"

src_prepare() {
	cmake_src_prepare

	# bug 628574
	if ! use test; then
		sed -i CMakeLists.txt -e "/include(Testing)/d" || die
		sed -i cmake/Dependencies.cmake -e "/find_package(Qt5Test/d" || die
	fi
}

src_configure() {
	local mycmakeargs=(
		-DENABLE_STATUSNOTIFIER=$(usex notification)
		-DDESKTOP_NOTIFICATIONS=$(usex notification)
		-DSPELL_CHECK=$(usex spell)
		-DUSE_FILTERAUDIO=OFF
		-DGIT_DESCRIBE="${PV}"
		-DPLATFORM_EXTENSIONS=$(usex auto-away)
		-DUPDATE_CHECK=OFF
	)

	cmake_src_configure
}

pkg_postinst() {
	gnome2_icon_cache_update
	xdg_desktop_database_update
}

pkg_postrm() {
	gnome2_icon_cache_update
	xdg_desktop_database_update
}
