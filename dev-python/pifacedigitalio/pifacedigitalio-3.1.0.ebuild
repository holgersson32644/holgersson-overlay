# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python2_7 python3_5 )

inherit distutils-r1

DESCRIPTION="The PiFace Digital input/output module"
HOMEPAGE="https://github.com/piface/pifacedigitalio"

if [[ ${PV} == *9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/piface/pifacedigitalio.git"
else
	SRC_URI="https://github.com/piface/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~arm"
fi

LICENSE="GPL-3"
SLOT="0"
IUSE=""

DEPEND="dev-python/pifacecommon"
RDEPEND="${DEPEND}"

pkg_postinst(){
	elog "To use the PiFace you need SPI support enabled at boot time."
	elog "This can be achived by putting the following lines to /boot/config.txt:"
	elog "dtparam=spi=on"
	elog "dtoverlay=spi1-1cs # or chose another <nr>-cs from 1 to 3"
	elog "For more details, take a look at"
	elog "https://elinux.org/RPi_SPI#SPI1_.28available_only_on_40-pins_P1_header.29"
	ewarn "Have fun!"
}
