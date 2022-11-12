# Copyright 2020-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="8"
EGO_PN="github.com/tulir/gomuks"
inherit go-module
COMMIT_ID="26b3c5105360fc8ab1aba12b68d0f538a09523af"

DESCRIPTION="A terminal based Matrix client written in Go"
HOMEPAGE="https://github.com/tulir/gomuks"

if [[ ${PV} == *_p* ]]; then
	SRC_URI="https://${EGO_PN}/archive/${COMMIT_ID}.tar.gz -> ${P}.tar.gz"
	S="${WORKDIR}/${PN}-${COMMIT_ID}"
else
	SRC_URI="https://${EGO_PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
fi
# Add the manually vendored tarball.
# Compress the tarball with: xz -9kT0 --memlimit-decompress=256M
SRC_URI+=" https://files.holgersson.xyz/gentoo/distfiles/${P}-deps.tar.xz"

KEYWORDS="~amd64"
LICENSE="AGPL-3"
SLOT="0"
IUSE="+encryption"

DEPEND="encryption? ( dev-libs/olm )"
RDEPEND="${DEPEND}"
BDEPEND=""

src_compile() {
	# Flags -w, -s: Omit debugging information to reduce binary size,
	# see https://golang.org/cmd/link/.
	local mygobuildargs=(
		-ldflags="-X ${EGO_PN}/config.GitCommit=${GIT_COMMIT} -s -w"
		-mod mod -v -work -x
	)

	use encryption || export CGO_ENABLED=0
	go build  "${mygobuildargs[@]}" . || die "go build failed"
}

src_install() {
	dobin ${PN}
}
