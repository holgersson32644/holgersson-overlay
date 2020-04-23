# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

DESCRIPTION="Open source software for numerical computation"
HOMEPAGE="https://scilab.org"
MY_PN="${PN/-bin/}"
SRC_URI="
	amd64? ( https://www.scilab.org/download/${PV}/${MY_PN}-${PV}.bin.linux-x86_64.tar.gz -> ${P}-amd64.tar.gz )
	x86? ( https://www.scilab.org/download/${PV}/${MY_PN}-${PV}.bin.linux-i686.tar.gz -> ${P}-x86.tar.gz )
"
# GPL-2 since 6.0.0 according to scilab.org, BCL for the thirdparty JAVA deps
# and the old BSD plus CeCILL-2.1 licensing from versions < 6.0.0 remain.
LICENSE="
	BSD
	|| (
		GPL-2
		CeCILL-2.1
	)
	BCL-for-JAVA-SE
"
RESTRICT="mirror strip test"
SLOT="0"

# Upstream provides precompiled binaries for both x86 arches, but the
# source code is also freely available, so for other arches source based
# packages might be of interest.
KEYWORDS="-* ~amd64 ~x86"
IUSE=""

DEPEND="!sci-mathematics/scilab"
RDEPEND="
	${DEPEND}
	sys-libs/ncurses-compat
"
BDEPEND=""

S="${WORKDIR}/${MY_PN}-${PV}"
DOCS=( ACKNOWLEDGEMENTS CHANGES.md README.md )

QA_PREBUILT="
	opt/${MY_PN}-${PV}/bin/*
	opt/${MY_PN}-${PV}/lib/*
	opt/${MY_PN}-${PV}/thirdparty/*
"

src_prepare() {
	# Adopt every entry to opt/
	sed -i "s#Exec=#Exec=/opt/${P}/bin/#" share/applications/*.desktop || die

	# Adopt the base dir of scilab.
	sed -i "s#SCIBINARYBASE=$(pwd)#SCIBINARYBASE=/opt/${P}/#" bin/scilab || die

	# Appdata should not be installed anymore according to a QA warning.
	rm -r share/appdata || die

	# Remove redundant information. Note that we explictly have our licenses
	# in a separate licensing file. In case this is against any licensing
	# condition please file a bug!
	rm share/scilab/{ACKNOWLEDGEMENTS,CHANGES.md,COPYING,README.md} || die
	rm COPYING || die

	default
}

src_install() {
	# Install the header files into /usr/include/scilab/.
	doheader -r include/scilab

	# Install the actual binaries into /opt/${P}/bin/.
	into /opt/${P}/
	dobin bin/*
	rm -r bin || die

	# Install the library files into opt/${P}/lib/{scilab,thirdparty}/.
	insinto /opt/${P}/lib/
	cd lib || die
	doins -r scilab
	doins -r thirdparty
	cd ../ || die
	rm -r lib || die

	# Install thirdparty java stuff into /opt/${P}/thirdparty/.
	insinto "/opt/${P}/"
	doins -r thirdparty
	rm -r thirdparty || die

	# Install the scilab dir into /opt/${P}, but the rest of the files into
	# /usr/ subdirectories for icons etc. Symlinks provide no real benefit here.
	insinto "/opt/${P}/share"
	doins -r share/scilab

	rm -r share/scilab || die

	insinto /usr/share
	doins -r share/*
	rm -r share || die
}
