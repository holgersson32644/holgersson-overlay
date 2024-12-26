# Copyright 2019-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# Note: For distfiles verification see https://nuetzlich.net/gocryptfs/releases.

EAPI="8"

EGO_PN="github.com/rfjakob/${PN}"
inherit go-module

MY_PV="${PV/_/-}"

DESCRIPTION="Encrypted overlay filesystem written in Go"
HOMEPAGE="https://nuetzlich.net/gocryptfs/ https://github.com/rfjakob/gocryptfs/"

S="${WORKDIR}/${PN}_v${MY_PV}_src-deps"

if [[ "${PV}" = 9999* ]]; then
	EGIT_REPO_URI="https://${EGO_PN}"
	inherit git-r3
else
	SRC_URI="https://${EGO_PN}/releases/download/v${MY_PV}/${PN}_v${MY_PV}_src-deps.tar.gz -> ${P}.tar.gz"
fi

# in detail:
# BSD           vendor/golang.org/x/sys/LICENSE
# BSD           vendor/golang.org/x/crypto/LICENSE
# BSD           vendor/github.com/hanwen/go-fuse/v2/LICENSE
# Apache-2.0    vendor/github.com/jacobsa/crypto/LICENSE
# BSD-2         vendor/github.com/pkg/xattr/LICENSE
# MIT           vendor/github.com/rfjakob/eme/LICENSE
# MIT           vendor/github.com/sabhiram/go-gitignore/LICENSE
LICENSE="Apache-2.0 BSD BSD-2 MIT"

SLOT="0"
KEYWORDS="~amd64"
IUSE="debug +man pie +ssl"
# Some tests need an ext4, some need libsandbox.so preloaded.
RESTRICT="test"

BDEPEND="man? ( dev-go/go-md2man )"
RDEPEND="
	sys-fs/fuse
	ssl? ( dev-libs/openssl:0= )
"

# We omit debug symbols which looks like pre-stripping to portage.
QA_PRESTRIPPED="
	/usr/bin/gocryptfs-atomicrename
	/usr/bin/gocryptfs-findholes
	/usr/bin/gocryptfs-statfs
	/usr/bin/gocryptfs-xray
	/usr/bin/gocryptfs
"

src_compile() {
	export GOPATH="${G}"
	export CGO_CFLAGS="${CFLAGS}"
	export CGO_LDFLAGS="${LDFLAGS}"
	local myldflags=(
		"$(usex !debug '-s -w' '')"
		-X "main.GitVersion=v${PV}"
		-X "'main.GitVersionFuse=[vendored]'"
		-X "main.BuildDate=$(date -u '+%Y-%m-%d')"
	)
	local mygoargs=(
		-v -work -x
		"-buildmode=$(usex pie pie exe)"
		"-asmflags=all=-trimpath=${S}"
		"-gcflags=all=-trimpath=${S}"
		-ldflags "${myldflags[*]}"
		-tags "$(usex !ssl 'without_openssl' 'none')"
	)
	ego build "${mygoargs[@]}"

	# loop over all helper tools
	for dir in gocryptfs-xray contrib/statfs contrib/findholes contrib/atomicrename; do
		cd "${S}/${dir}" || die
		go build "${mygoargs[@]}" || die
	done
	cd "${S}"

	if use man; then
		go-md2man -in Documentation/MANPAGE.md -out gocryptfs.1 || die
		go-md2man -in Documentation/MANPAGE-STATFS.md -out gocryptfs-statfs.2 || die
		go-md2man -in Documentation/MANPAGE-XRAY.md -out gocryptfs-xray.1 || die
	fi
}

src_install() {
	dobin gocryptfs
	dobin gocryptfs-xray/gocryptfs-xray
	newbin contrib/statfs/statfs "${PN}-statfs"
	newbin contrib/findholes/findholes "${PN}-findholes"
	newbin contrib/atomicrename/atomicrename "${PN}-atomicrename"

	if use man; then
		doman gocryptfs.1
		doman gocryptfs-xray.1
		doman gocryptfs-statfs.2
	fi
}
