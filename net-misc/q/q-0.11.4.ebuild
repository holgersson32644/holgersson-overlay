# Copyright 2022-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="8"
EGO_PN="github.com/natesales/q"
COMMIT_ID="83c169f40f0895ae4b5b210f20b0a46fda2e0d9d"

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
# 1) Create a tar archive optimized to reproduced by other users or devs.
# 2) Compress the archive using XZ limiting decompression memory for
#    pretty constraint systems.
# Use something like:
# tar cf $P-deps.tar go-mod \
#       --mtime="1970-01-01" --sort=name --owner=portage --group=portage
# xz -k -9eT0 --memlimit-decompress=256M $P-deps.tar
SRC_URI+=" https://files.holgersson.xyz/gentoo/distfiles/golang-pkg-deps/${P}-deps.tar.xz"

MY_PN="q-dns"
KEYWORDS="~amd64"
LICENSE="AGPL-3 Apache-2.0 BSD BSD-2 GPL-3 MIT"

SLOT="0"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""

src_compile() {
	export CGO_ENABLED=0

	# Flags -w, -s: Omit debugging information to reduce binary size,
	# see https://golang.org/cmd/link/.
	local mygobuildargs=(
		-ldflags="-X ${EGO_PN}/config.GitCommit=${COMMIT_ID} -s -w"
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
