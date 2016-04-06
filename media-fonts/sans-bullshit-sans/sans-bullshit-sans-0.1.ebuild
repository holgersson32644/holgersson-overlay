# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/ubuntu-font-family/ubuntu-font-family-0.80.ebuild,v 1.4 2013/01/21 20:03:56 steev Exp $

EAPI=6

inherit font

DESCRIPTION="A media-fonts/droid based font with buzzword censorship"
HOMEPAGE="http://sansbullshitsans.com"
SRC_URI="http://pixelambacht.nl/downloads/SansBullshitSans.ttf"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 arm ~arm64 ppc ppc64 x86"
IUSE=""

S="${WORKDIR}"

FONT_S="${S}"
FONT_SUFFIX="ttf"

src_unpack() {
	cp "${DISTDIR}/${A}" "${S}/${A//-${PV}}"
}
