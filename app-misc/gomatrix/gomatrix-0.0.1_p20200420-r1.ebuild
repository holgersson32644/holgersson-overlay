# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="8"

inherit go-module

EGO_SUM=(
	"github.com/DATA-DOG/go-sqlmock v1.3.3/go.mod"
	"github.com/davecgh/go-spew v1.1.1"
	"github.com/davecgh/go-spew v1.1.1/go.mod"
	"github.com/gdamore/encoding v1.0.0"
	"github.com/gdamore/encoding v1.0.0/go.mod"
	"github.com/gdamore/tcell v1.3.0"
	"github.com/gdamore/tcell v1.3.0/go.mod"
	"github.com/jessevdk/go-flags v1.4.0"
	"github.com/jessevdk/go-flags v1.4.0/go.mod"
	"github.com/lucasb-eyer/go-colorful v1.0.2"
	"github.com/lucasb-eyer/go-colorful v1.0.2/go.mod"
	"github.com/mattn/go-runewidth v0.0.4"
	"github.com/mattn/go-runewidth v0.0.4/go.mod"
	"golang.org/x/sys v0.0.0-20190626150813-e07cf5db2756"
	"golang.org/x/sys v0.0.0-20190626150813-e07cf5db2756/go.mod"
	"golang.org/x/text v0.3.0"
	"golang.org/x/text v0.3.0/go.mod"
)
go-module_set_globals

DESCRIPTION="Connect to The Matrix and display it's data streams in your terminal"
HOMEPAGE="https://github.com/GeertJohan/gomatrix"

EGO_PN="github.com/GeertJohan/gomatrix"
COMMIT_ID="b3aff13d5fde12c75cdc506215b9db9f4c7ee7dc"

if [[ ${PV} == *_p* ]]; then
	SRC_URI="
		https://${EGO_PN}/archive/${COMMIT_ID}.tar.gz -> ${P}.tar.gz
		${EGO_SUM_SRC_URI}
	"
	S="${WORKDIR}/${PN}-${COMMIT_ID}"
else
	SRC_URI="
		https://${EGO_PN}/archive/v${PV}.tar.gz
		${EGO_SUM_SRC_URI}
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
