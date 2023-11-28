# Copyright 2016-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="8"

inherit go-module systemd tmpfiles

MY_PV="${PV/_rc/-rc}"
DESCRIPTION="A painless self-hosted Git service"
HOMEPAGE="
	https://gitea.io
	https://github.com/go-gitea/gitea
"

if [[ ${MY_PV} == *9999 ]]
then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/go-gitea/gitea.git"
else
	SRC_URI="https://github.com/go-gitea/gitea/releases/download/v${MY_PV}/gitea-src-${MY_PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~arm ~arm64 ~riscv ~x86"
fi

LICENSE="Apache-2.0 BSD BSD-2 ISC MIT MPL-2.0"
SLOT="0"
IUSE="+acct pam +pie sqlite"
RESTRICT="test"

DEPEND="
	acct? (
		acct-group/git
		acct-user/git[gitea]
	)
	pam? ( sys-libs/pam )
"
RDEPEND="
	${DEPEND}
	dev-vcs/git
"

DOCS=(
	custom/conf/app.example.ini
	CONTRIBUTING.md
	README.md
)

S="${WORKDIR}/${PN}-src-${MY_PV}"

src_compile() {
	local gitea_tags=(
		bindata
		$(usev pam)
		$(usex sqlite 'sqlite sqlite_unlock_notify' '')
	)
	local gitea_settings=(
		"-X code.gitea.io/gitea/modules/setting.CustomConf=${EPREFIX}/etc/gitea/app.ini"
		"-X code.gitea.io/gitea/modules/setting.CustomPath=${EPREFIX}/var/lib/gitea/custom"
		"-X code.gitea.io/gitea/modules/setting.AppWorkPath=${EPREFIX}/var/lib/gitea"
	)
	local makeenv=(
		DRONE_TAG="${PV}"
		LDFLAGS="-extldflags \"${LDFLAGS}\" ${gitea_settings[*]} -s -w"
		TAGS="${gitea_tags[*]}"
	)

	GOFLAGS=""
	if use pie ; then
		GOFLAGS+="-buildmode=pie"
	fi

	env "${makeenv[@]}" emake EXTRA_GOFLAGS="${GOFLAGS}" backend
}

src_install() {
	dobin gitea

	einstalldocs

	newconfd "${FILESDIR}/gitea.confd-r1" gitea
	newinitd "${FILESDIR}/gitea.initd-r3" gitea
	newtmpfiles - gitea.conf <<-EOF
		d /run/gitea 0755 git git
	EOF
	systemd_newunit "${FILESDIR}"/gitea.service-r3 gitea.service

	insinto /etc/gitea
	newins custom/conf/app.example.ini app.ini
	if use acct; then
		fowners root:git /etc/gitea/{,app.ini}
		fperms g+w,o-rwx /etc/gitea/{,app.ini}

		diropts -m0750 -o git -g git
		keepdir /var/lib/gitea /var/lib/gitea/custom /var/lib/gitea/data
		keepdir /var/log/gitea
	fi
}

pkg_postinst() {
	tmpfiles_process gitea.conf
}
