# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="8"
EGO_PN="github.com/containers/dnsname"
inherit go-module
COMMIT_ID="6685f68dbc13a95b73b9394b304927c6f518021c"

DESCRIPTION="Name resolution for contaienrs"
HOMEPAGE="https://github.com/containers/dnsname"

if [[ ${PV} == *_p* ]]; then
	SRC_URI="https://${EGO_PN}/archive/${COMMIT_ID}.tar.gz -> ${P}.gh.tar.gz"
	S="${WORKDIR}/${PN}-${COMMIT_ID}"
else
	SRC_URI="https://${EGO_PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
fi
# Add the manually vendored tarball.
# Compress the tarball with: xz -9kT0 --memlimit-decompress=256M
SRC_URI+=" https://files.holgersson.xyz/gentoo/distfiles/holgersson-overlay/${P}-deps.tar.xz"

KEYWORDS="~amd64"
LICENSE="Apache-2.0"
SLOT="0"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""
DOCS=(
	README.md
	README_PODMAN.md
	RELEASE_NOTES.md
	SECURITY.md
	CODE-OF-CONDUCT.md
	OWNERS
)

src_compile() {
	# Flags -w, -s: Omit debugging information to reduce binary size,
	# see https://golang.org/cmd/link/.
	local mygobuildargs=(
		-ldflags="-X ${EGO_PN}/config.GitCommit=${GIT_COMMIT} -w -s"
		-mod=vendor -v -work -x
	)

	go build  "${mygobuildargs[@]}" "${EGO_PN}/plugins/meta/dnsname" \
		|| die "go build failed"
}

src_install() {
	dobin "${PN}"

	dodoc "${DOCS[@]}"
}
