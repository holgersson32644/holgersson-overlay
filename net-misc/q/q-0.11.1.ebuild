# Copyright 2022-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="8"
EGO_PN="github.com/natesales/q"
COMMIT_ID=""

inherit go-module

HOMEPAGE="https://github.com/natesales/q"
DESCRIPTION="DNS client with support for UDP, TCP, DoT, DoH, DoQ and ODoH"

if [[ ${PV} == *_p* ]]; then
	SRC_URI="https://${EGO_PN}/archive/${COMMIT_ID}.tar.gz -> ${P}.tar.gz"
	S="${WORKDIR}/${PN}-${COMMIT_ID}"
else
	SRC_URI="https://${EGO_PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
fi

# Add the manually vendored tarball.
# Compress the tarball with: xz -9kT0 --memlimit-decompress=256M
SRC_URI+=" https://files.holgersson.xyz/gentoo/distfiles/holgersson-overlay/holgersson-overlay/${P}-deps.tar.xz"

MY_PN="q-dns"
KEYWORDS="~amd64"
LICENSE="AGPL-3 Apache-2.0 BSD BSD-2 GPL-3 MIT"

SLOT="0"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""

src_compile() {
	# Flags -w, -s: Omit debugging information to reduce binary size,
	# see https://golang.org/cmd/link/.
	local mygobuildargs=(
		-ldflags="-X ${EGO_PN}/config.GitCommit=${GIT_COMMIT} -s -w"
		-mod mod -v -work -x
	)

	go build  "${mygobuildargs[@]}" . || die "go build failed"
}

src_install() {
	newbin "${PN}" "${MY_PN}"
}

pkg_postinst() {
	if [[ -z "${REPLACING_VERSION}" ]]; then
		elog ""
		elog "Please note that the binary is renamed to"
		elog "\"${MY_PN}\" as app-portage/portage-utils"
		elog "already installs the \"q\" binary."
		elog "For details see the upstream discussion:"
		elog "https://github.com/natesales/q/issues/28"
	fi
}
