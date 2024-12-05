# Copyright 2017-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="8"

inherit font

DESCRIPTION="A media-fonts/droid based font with buzzword censorship"
HOMEPAGE="https://www.sansbullshitsans.com/"
SRC_URI="https://pixelambacht.nl/downloads/SansBullshitSans.ttf -> ${P}.ttf"

S="${WORKDIR}"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~*"

FONT_S="${S}"
FONT_SUFFIX="ttf"

src_unpack() {
	cp "${DISTDIR}/${A}" "${S}/${A//-${PV}}"
}
