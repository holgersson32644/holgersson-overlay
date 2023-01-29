# Copyright 2022-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="8"
EGO_PN="github.com/matrix-org/dendrite/"
inherit go-module
COMMIT_ID=""

DESCRIPTION="Matrix homeserver written in go"
HOMEPAGE="https://matrix.org https://github.com/matrix-org/dendrite"

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
# FIXME
LICENSE="Apache-2.0"
SLOT="0"
IUSE=""

DEPEND=""
RDEPEND="
	acct-user/dendrite
	acct-group/dendrite
"
BDEPEND=""

src_unpack() {
	go-module_src_unpack || die
}

src_compile() {
	local mygobuildargs=(
		-o bin/
		-trimpath
		-ldflags="-s -w"
		-mod mod
		-v -x
		-work
	)

	ego build "${mygobuildargs[@]}" "${S}/cmd/..."
}

src_test() {
	ego test -trimpath -v -x -work "${S}/cmd/..."
}

src_install() {
	# Install the binaries from bin and prefix everything with "dendrite".
	newbin bin/create-account dendrite-create-account
	dobin bin/dendrite-demo-pinecone
	dobin bin/dendrite-demo-yggdrasil
	dobin bin/dendrite-monolith-server
	dobin bin/dendrite-polylith-multi
	dobin bin/dendrite-upgrade-tests
	newbin bin/furl dendrite-furl
	newbin bin/generate-config dendrite-generate-config
	newbin bin/generate-keys dendrite-generate-keys
	newbin bin/resolve-state dendrite-resolve-state

	dodir "/etc/dendrite"
	insinto /etc/dendrite
	doins "${S}/dendrite-sample.monolith.yaml"
	doins "${S}/dendrite-sample.polylith.yaml"
	newinitd "${FILESDIR}"/dendrite.initd dendrite
	newconfd "${FILESDIR}"/dendrite.confd dendrite

	keepdir "/var/log/dendrite"
	fowners dendrite:dendrite "/var/log/dendrite"
}

pkg_postinst() {
	elog ""
	elog "Note that all binaries are prefixed with 'dendrite-'"
	elog "- even ones that have no prefix uptream."
}
