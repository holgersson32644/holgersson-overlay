# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="8"
EGO_PN="github.com/direnv/direnv"
COMMIT_ID="7590ee2442104060bb11eedebd7bd6daf3d88fcd"

inherit go-module

DESCRIPTION="Environment variable manager for shell"

HOMEPAGE="
	https://github.com/direnv/direnv
	https://direnv.net
"

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

LICENSE="BSD MIT"
SLOT="0"
KEYWORDS="~amd64"

DOCS=(
	CHANGELOG.md
	CNAME
	CONTRIBUTING.md
	README.md
)

src_compile() {
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
	einstalldocs

	dobin "${PN}"
}
