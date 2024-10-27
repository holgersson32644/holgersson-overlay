# Copyright 2022-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
EGO_PN="github.com/joanfont/headscale"
COMMIT_ID="10a72e8d542af68c0c280f2a6ccc84849719b24c"

inherit go-module systemd

DESCRIPTION="An open source, self-hosted implementation of the Tailscale control server"
HOMEPAGE="https://github.com/juanfont/headscale"
SRC_URI="https://github.com/juanfont/headscale/archive/v${PV}.tar.gz -> ${P}.tar.gz"
# Add the manually vendored tarball.
# 1) Create a tar archive optimized to reproduced by other users or devs.
# 2) Compress the archive using XZ limiting decompression memory for
#    pretty constraint systems.
# Use something like:
# GOMODCACHE="${PWD}"/go-mod go mod download -modcacherw
# tar cf $P-deps.tar go-mod \
#       --mtime="1970-01-01" --sort=name --owner=portage --group=portage
# xz -k -9eT0 --memlimit-decompress=4096M $P-deps.tar
SRC_URI+=" https://files.holgersson.xyz/gentoo/distfiles/golang-pkg-deps/${P}-deps.tar.xz"

LICENSE="BSD Apache-2.0 MIT"
SLOT="0"
KEYWORDS="~amd64 ~riscv"

DEPEND="
	acct-group/headscale
	acct-user/headscale
"
RDEPEND="
	${DEPEND}
	net-firewall/iptables
"

src_compile() {
	export -n GOCACHE XDG_CACHE_HOME
	export CGO_ENABLED=0

	# Flags -w, -s: Omit debugging information to reduce binary size,
	# see https://golang.org/cmd/link/.
	local mygobuildargs=(
		-ldflags="-X ${EGO_PN}/config.GitCommit=${COMMIT_ID} -s -w"
		-trimpath
		-v -work -x
	)

	ego build "${mygobuildargs[@]}" -o "./bin/${PN}" "./cmd/${PN}"
}

src_install() {
	dobin bin/headscale
	dodoc -r config-example.yaml derp-example.yaml
	keepdir /etc/headscale /var/lib/headscale
	systemd_dounit "${FILESDIR}"/headscale.service
	newconfd "${FILESDIR}"/headscale.confd headscale
	newinitd "${FILESDIR}"/headscale.initd headscale
	fowners -R "${PN}":"${PN}" /etc/headscale /var/lib/headscale
}

pkg_postinst() {
	if [[ ! -f "${EROOT}"/etc/headscale/config.yaml ]]; then
		elog "Please create ${EROOT}/etc/headscale/config.yaml before starting the service"
		elog "An example is in ${EROOT}/usr/share/doc/${P}/config-example.yaml"
		ewarn ">=headscale-0.19.0 has a DB structs breaking, please BACKUP your database before upgrading!"
		ewarn "see also: https://github.com/juanfont/headscale/pull/1171 and https://github.com/juanfont/headscale/pull/1144"
	fi
}
