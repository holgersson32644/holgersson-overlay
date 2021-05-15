# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

inherit font

DESCRIPTION="A media-fonts/droid based font with buzzword censorship"
HOMEPAGE="https://www.sansbullshitsans.com/"
SRC_URI="https://pixelambacht.nl/downloads/SansBullshitSans.ttf"

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
