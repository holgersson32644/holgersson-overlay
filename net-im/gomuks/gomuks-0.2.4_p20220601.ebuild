# Copyright 2020-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="8"
EGO_PN="github.com/tulir/gomuks"
inherit go-module
COMMIT_ID="6479ff2e348326ee93763258a8ec34d95129c94c"

DESCRIPTION="A terminal based Matrix client written in Go"
HOMEPAGE="https://github.com/tulir/gomuks"

if [[ ${PV} == *_p* ]]; then
	SRC_URI="
		https://${EGO_PN}/archive/${COMMIT_ID}.tar.gz -> ${P}.tar.gz
		https://files.holgersson.xyz/gentoo/distfiles/${P}-deps.tar.xz
	"
	S="${WORKDIR}/${PN}-${COMMIT_ID}"
else
	SRC_URI="
		https://${EGO_PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz
		https://files.holgersson.xyz/gentoo/distfiles/${P}-deps.tar.xz
	"
fi

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
