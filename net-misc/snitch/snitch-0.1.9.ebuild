# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
EGO_PN="github.com/karol-broda/snitch"
COMMIT_ID="6d6d057675ba67627826b2383221e00a3fe742fe"

inherit go-module

DESCRIPTION="A prettier way to inspect network connections"
HOMEPAGE="https://github.com/karol-broda/snitch"

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
# GOMODCACHE="${PWD}"/go-mod go mod download -modcacherw
# tar cf "${P}-deps.tar" go-mod \
#       --mtime="1970-01-01" --sort=name --owner=portage --group=portage
# xz -k -9eT0 --memlimit-decompress=256M "${P}-deps.tar"
SRC_URI+=" https://files.holgersson.xyz/gentoo/distfiles/golang-pkg-deps/${P}-deps.tar.xz"

LICENSE="Apache-2.0 BSD MIT MPL-2.0"
SLOT="0"
KEYWORDS="~amd64"

src_compile() {
	# Upstream actually links against libresolv
	# and some other parts of libc (glic?).
	# Let's build statically here until I run into issues.
	export CGO_ENABLED=0
	# Flags -w, -s: Omit debugging information to reduce binary size,
	# see https://golang.org/cmd/link/.
	local mygobuildargs=(
		-ldflags="-X ${EGO_PN}/config.GitCommit=${COMMIT_ID} -w -s"
		-mod mod -v -work -x
	)
	ego build  "${mygobuildargs[@]}" .
}

src_install() {
	dobin "${PN}"
}
