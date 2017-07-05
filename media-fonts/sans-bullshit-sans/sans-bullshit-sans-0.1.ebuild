# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

inherit font

DESCRIPTION="A media-fonts/droid based font with buzzword censorship"
HOMEPAGE="http://sansbullshitsans.com"
SRC_URI="http://pixelambacht.nl/downloads/SansBullshitSans.ttf"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~*"
IUSE=""

S="${WORKDIR}"

FONT_S="${S}"
FONT_SUFFIX="ttf"

src_unpack() {
	cp "${DISTDIR}/${A}" "${S}/${A//-${PV}}"
}
