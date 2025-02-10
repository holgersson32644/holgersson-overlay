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
	docs/tips/style.md
	docs/tips/notebook-housekeeping.md
	docs/tips/neuron.md
	docs/tips/getting-started.md
	docs/tips/future-proof.md
	docs/tips/external-processing.md
	docs/tips/external-call.md
	docs/tips/editors-integration.md
	docs/tips/daily-journal.md
	docs/tips/automation.md
	docs/notes/template.md
	docs/notes/template-format.md
	docs/notes/template-creation.md
	docs/notes/tags.md
	docs/notes/notebook.md
	docs/notes/note-id.md
	docs/notes/note-frontmatter.md
	docs/notes/note-format.md
	docs/notes/note-filtering.md
	docs/notes/note-creation.md
	docs/config/tool-shell.md
	docs/config/tool-pager.md
	docs/config/tool-fzf.md
	docs/config/tool-editor.md
	docs/config/config.md
	docs/config/config-notebook.md
	docs/config/config-note.md
	docs/config/config-lsp.md
	docs/config/config-group.md
	docs/config/config-filter.md
	docs/config/config-extra.md
	docs/config/config-alias.md
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
