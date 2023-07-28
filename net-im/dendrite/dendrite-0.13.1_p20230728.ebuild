# Copyright 2022-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="8"
EGO_PN="github.com/matrix-org/dendrite"
inherit go-module systemd
COMMIT_ID="3f727485d6e21a603e4df1cb31c3795cc1023caa"

DESCRIPTION="Matrix homeserver written in go"
HOMEPAGE="https://matrix.org https://github.com/matrix-org/dendrite"

if [[ ${PV} == *_p* ]]; then
	SRC_URI="https://${EGO_PN}/archive/${COMMIT_ID}.tar.gz -> ${P}.tar.gz"
	S="${WORKDIR}/${PN}-${COMMIT_ID}"
else
	SRC_URI="https://${EGO_PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
fi
# Add the manually vendored tarball.
# Build tar archive with these flags for reproducabilty:
# --mtime="1970-01-01" --sort=name --owner=portage --group=portage"
# Compress the tarball with: xz -9eT0k --memlimit-decompress=256M
SRC_URI+=" https://files.holgersson.xyz/gentoo/distfiles/holgersson-overlay/${P}-deps.tar.xz"

KEYWORDS="~amd64"
# There are some third-party licenses for test suites
# like non-commercial clauses inside for ccgo / CompCert.
# Restrict test execution until that stuff is sorted out.
RESTRICT="test"

LICENSE="
	Apache-2.0
	BSD
	BSD-2
	CC0-1.0
	ISC
	LGPL-3
	MIT
	MPL-2.0
	Unlicense
	ZLIB
"
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
	# Install files from bin, prefix with 'dendrite' if necessary.
	newbin bin/create-account dendrite-create-account

	dobin bin/dendrite-demo-pinecone
	dobin bin/dendrite-demo-yggdrasil
	dobin bin/dendrite
	dobin bin/dendrite-upgrade-tests

	# prefix
	newbin bin/furl dendrite-furl
	newbin bin/generate-config dendrite-generate-config
	newbin bin/generate-keys dendrite-generate-keys
	newbin bin/resolve-state dendrite-resolve-state

	# Provide a sample configuration.
	dodir "/etc/dendrite"
	insinto /etc/dendrite
	doins "${S}/dendrite-sample.yaml"

	# Install init scripts for OpenRC
	newinitd "${FILESDIR}"/dendrite.initd dendrite
	newconfd "${FILESDIR}"/dendrite.confd dendrite

	# Install a systemd unit.
	systemd_newunit "${FILESDIR}"/dendrite.service dendrite.service

	keepdir "/var/log/dendrite"
	fowners dendrite:dendrite "/var/log/dendrite"
}

pkg_postinst() {
	elog ""
	elog "Note that all binaries are prefixed with 'dendrite-'"
	elog "- even ones that have no prefix uptream."
}
