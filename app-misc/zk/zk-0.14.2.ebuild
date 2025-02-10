# Copyright 2024-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="8"
EGO_PN="github.com/zk-org/zk"
inherit go-module
COMMIT_ID="bf4800b52ceeab479a446dcb8b9ea63aad4dc36b"

DESCRIPTION="A plain text note-taking assistant"
HOMEPAGE="https://github.com/zk-org/zk"

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
# tar cf $P-deps.tar go-mod \
#       --mtime="1970-01-01" --sort=name --owner=portage --group=portage
# xz -k -9eT0 --memlimit-decompress=4096M $P-deps.tar
SRC_URI+=" https://files.holgersson.xyz/gentoo/distfiles/golang-pkg-deps/${P}-deps.tar.xz"

# As deps are linked into the resulting binary the licenses of all(sic!) deps
# must be listed here. Check licenses e.g. with dev-go/lichen:
# `lichen <path to binary> | cut -f2 -d: | cut -f1 -d'(' | sort -u`
LICENSE="
	Apache-2.0
	BSD
	BSD-2
	GPL-3
	MIT
	MPL-2.0
"
SLOT="0"
KEYWORDS="~amd64"

DOCS=(
	docs/automation.md
	docs/config-alias.md
	docs/config-extra.md
	docs/config-filter.md
	docs/config-group.md
	docs/config-lsp.md
	docs/config.md
	docs/config-notebook.md
	docs/config-note.md
	docs/daily-journal.md
	docs/editors-integration.md
	docs/external-call.md
	docs/external-processing.md
	docs/future-proof.md
	docs/getting-started.md
	docs/neuron.md
	docs/notebook-housekeeping.md
	docs/notebook.md
	docs/note-creation.md
	docs/note-filtering.md
	docs/note-format.md
	docs/note-frontmatter.md
	docs/note-id.md
	docs/style.md
	docs/tags.md
	docs/template-creation.md
	docs/template-format.md
	docs/template.md
	docs/tool-editor.md
	docs/tool-fzf.md
	docs/tool-pager.md
	docs/tool-shell.md
)

src_compile() {
	export CGO_ENABLE=1

	# Flags -w, -s: Omit debugging information to reduce binary size,
	# see https://golang.org/cmd/link/.
	local mygobuildargs=(
		-buildmode=pie
		-mod readonly
		-modcacherw
		-ldflags="-X ${EGO_PN}/config.GitCommit=${GIT_COMMIT} -s -w"
		-v -work -x
		-tags "fts5"
	)

	ego build  "${mygobuildargs[@]}" .
}

src_install() {
	dobin "${PN}"
	einstalldocs
}

src_test() {
	ego test -v -race -tags "fts5" ./...
}
