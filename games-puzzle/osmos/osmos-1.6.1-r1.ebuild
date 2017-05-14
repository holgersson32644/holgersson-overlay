# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

inherit eutils

MY_PN="Osmos"
MY_P="${MY_PN}_${PV}"

DESCRIPTION="Play as a single-celled organism absorbing others"
HOMEPAGE="http://www.hemispheregames.com/osmos/"
SRC_URI="${MY_P}.tar.gz"

LICENSE="Hemisphere_Games-EULA"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
RESTRICT="fetch strip"
PROPERTIES="interactive"

RDEPEND="media-libs/freetype:2
	media-libs/openal
	media-libs/libvorbis
	virtual/opengl
	virtual/glu
	x11-libs/libX11"

DEPEND="${RDEPEND}"

S="${WORKDIR}/${MY_PN}"

pkg_nofetch() {
	einfo "Please download ${MY_P}.tar.gz and place it into ${DISTDIR}."
}

src_install() {
	# install a wrapper file
	exeinto "/usr/bin/"
	newexe "${FILESDIR}"/osmos-wrapper.sh ${PN}

	# install all files to /opt/osmos, including the actual binary
	exeinto "/opt/${PN}"
	if use amd64
		then newexe ${MY_PN}.bin64 ${PN}
	fi
	if use x86
		then newexe ${MY_PN}.bin32 ${PN}
	fi
	insinto "/opt/${PN}"
	doins -r Fonts/ Sounds/ Textures/ Osmos-* *.cfg

	newicon "Icons/256x256.png" "${PN}.png"
	dodoc readme.html

	make_desktop_entry "${PN}" "Osmos"
}
