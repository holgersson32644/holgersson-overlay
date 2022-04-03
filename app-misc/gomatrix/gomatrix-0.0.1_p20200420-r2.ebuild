# Copyright 2021-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="8"

inherit go-module

DESCRIPTION="Connect to The Matrix and display it's data streams in your terminal"
HOMEPAGE="https://github.com/GeertJohan/gomatrix"

EGO_PN="github.com/GeertJohan/gomatrix"
COMMIT_ID="b3aff13d5fde12c75cdc506215b9db9f4c7ee7dc"

if [[ ${PV} == *_p* ]]; then
	SRC_URI="
		https://${EGO_PN}/archive/${COMMIT_ID}.tar.gz -> ${P}.tar.gz
		https://files.holgersson.xyz/gentoo/distfiles/${P}-r2-deps.tar.xz
	"
	S="${WORKDIR}/${PN}-${COMMIT_ID}"
else
	SRC_URI="
		https://${EGO_PN}/archive/v${PV}.tar.gz
		https://files.holgersson.xyz/gentoo/distfiles/${P}-r2-deps.tar.xz
	"
fi

KEYWORDS="~amd64"
LICENSE="0BSD Apache-2.0 BSD BSD-2 MIT"
# in detail:
# github.com/GeertJohan/gomatrix:     BSD-2
# github.com/DATA-DOG/go-sqlmock:     BSD
# github.com/davecgh/go-spew:         0BSD
# github.com/gdamore/encoding:        Apache-2.0
# github.com/gdamore/tcell:           Apache-2.0
# github.com/jessevdk/go-flags:       BSD
# github.com/lucasb-eyer/go-colorful: MIT
# github.com/mattn/go-runewidth:      MIT
# golang.org/x/sys:                   BSD
# golang.org/x/text:                  BSD

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
	dobin ${PN}
}
