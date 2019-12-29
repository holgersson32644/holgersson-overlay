# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

PYTHON_COMPAT=( python3_{6,7} )

inherit autotools bash-completion-r1 gnome2-utils linux-info python-single-r1 systemd xdg-utils

DESCRIPTION="A firewall daemon with D-BUS interface providing a dynamic firewall"
HOMEPAGE="https://www.firewalld.org/"
SRC_URI="https://github.com/${PN}/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="~amd64 ~arm64 ~ppc64 ~x86"
IUSE="iptables gui systemd +nftables"
REQUIRED_USE="
	|| ( iptables nftables )
	${PYTHON_REQUIRED_USE}
"

RDEPEND="${PYTHON_DEPS}
	dev-python/dbus-python[${PYTHON_USEDEP}]
	dev-python/decorator[${PYTHON_USEDEP}]
	dev-python/python-slip[dbus,${PYTHON_USEDEP}]
	dev-python/pygobject:3[${PYTHON_USEDEP}]
	nftables? ( net-firewall/nftables[python,${PYTHON_USEDEP}] )
	iptables? (
			net-firewall/ipset
			net-firewall/iptables[ipv6]
			|| (
				net-firewall/iptables[nftables]
				net-firewall/ebtables
			)
	)
	systemd? ( sys-apps/systemd )
	!systemd? ( sys-apps/openrc )
	gui? (
		x11-libs/gtk+:3
		dev-python/PyQt5[gui,widgets,${PYTHON_USEDEP}]
	)"
DEPEND="${RDEPEND}
	dev-libs/glib:2
	>=dev-util/intltool-0.35
	sys-devel/gettext"

# See bug 650760.
# And it got even worse with $PV == 0.8.0:
# Out of 149 tests 1 passed, 147 failed unexpectedly and 1 was skipped.
RESTRICT="test"

pkg_setup() {
	get_version

	local CONFIG_CHECK="~NF_CONNTRACK "
	# The seperate conntrack modules were merged into one with linux-4.19,
	# so let's check against our current version.
	if [[ ${KV_MAJOR} < 4 && ${KV_MINOR} < 19 ]]
		then CONFIG_CHECK+="~NF_CONNTRACK_IPV4 ~NF_CONNTRACK_IPV6 "
	fi
	use iptables && CONFIG_CHECK+="~NETFILTER_XT_MATCH_CONNTRACK"

	linux-info_pkg_setup
}

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	python_setup

	local myeconfargs=(
		--with-bashcompletiondir="$(get_bashcompdir)"
	)

	if systemd
		then myeconfargs+=(
			--enable-systemd
			--with-systemd-unitdir="$(systemd_get_systemunitdir)"
		)
		else myeconfargs+=( --disable-systemd )
	fi

	if use iptables
		then myeconfargs+=(
			--with-iptables="${EPREFIX}/sbin/iptables"
			--with-ip6tables="${EPREFIX}/sbin/ip6tables"
			--with-iptables_restore="${EPREFIX}/sbin/iptables-restore"
			--with-ip6tables_restore="${EPREFIX}/sbin/ip6tables-restore"
			--with-ebtables="${EPREFIX}/sbin/ebtables"
			--with-ebtables-restore="${EPREFIX}/sbin/ebtables-restore"
			--with-ipset="${EPREFIX}/usr/sbin/ipset"
		)
	fi
	if use nftables
		then myeconfargs+=(
			--without-iptables
			--without-ip6tables
			--without-iptables-restore
			--without-ip6tables-restore
			--without-ebtables
			--without-ebtables-restore
			--without-ipset
			)
	fi

	econf "${myeconfargs[@]}"
}

src_install() {
	default
	python_optimize

	# Get rid of junk
	rm -rf "${D}/etc/rc.d/" || die
	rm -rf "${D}/etc/sysconfig/" || die

	# For non-gui installs we need to remove GUI bits
	if ! use gui; then
		rm -rf "${D}/etc/xdg/autostart" || die
		rm -f "${D}/usr/bin/firewall-applet" || die
		rm -f "${D}/usr/bin/firewall-config" || die
		rm -rf "${D}/usr/share/applications" || die
		rm -rf "${D}/usr/share/icons" || die
	fi

	newinitd "${FILESDIR}"/firewalld.init firewalld
}

pkg_preinst() {
	gnome2_schemas_savelist
}

pkg_postinst() {
	xdg_icon_cache_update
	gnome2_schemas_update
}

pkg_postrm() {
	xdg_icon_cache_update
	gnome2_schemas_update
}
