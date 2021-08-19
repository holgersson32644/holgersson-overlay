# Copyright 2020-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake linux-info

MY_PV="${PV/_rc/-RC}"
COMMIT_ID="5c4df362ec8c9116d8c1518785f603138aea61ae"

DESCRIPTION="ncurses interface for QEMU"
HOMEPAGE="https://github.com/nemuTUI/nemu"

if [[ ${PV} == *9999 ]]; then
	EGIT_REPO_URI="https://github.com/nemuTUI/${PN}.git"
	inherit git-r3
else
	if [[ ${PV} == *_p* ]]; then
		SRC_URI="https://github.com/nemuTUI/${PN}/archive/${COMMIT_ID}.tar.gz -> ${P}.tar.gz"
		S="${WORKDIR}/${PN}-${COMMIT_ID}"
	else
		SRC_URI="https://github.com/nemuTUI/${PN}/archive/v${MY_PV}.tar.gz -> ${P}.tar.gz"
		S="${WORKDIR}/$PN-${MY_PV}/"
	fi
fi
KEYWORDS="~amd64 ~x86"

LICENSE="BSD-2"
SLOT="0"
IUSE="dbus network-map +ovf +savevm spice +vnc-client"

RDEPEND="
	app-emulation/qemu[vnc,virtfs,spice?]
	dev-db/sqlite:3=
	>=sys-libs/ncurses-6.2_p20210619:0=
	virtual/libusb:1
	virtual/libudev:=
	dbus? ( sys-apps/dbus )
	network-map? ( media-gfx/graphviz[svg] )
	ovf? (
		dev-libs/libxml2:2
		app-arch/libarchive
	)
	spice? ( app-emulation/virt-viewer )
	vnc-client? ( net-misc/tigervnc )
"
DEPEND="${RDEPEND}"
BDEPEND="sys-devel/gettext"

pkg_pretend() {
	if use kernel_linux; then
		if ! linux_config_exists; then
			eerror "Unable to check your kernel"
		else
			CONFIG_CHECK="~VETH ~MACVTAP"
			ERROR_VETH="You will need the Virtual ethernet pair device driver compiled"
			ERROR_VETH+=" into your kernel or loaded as a module to use the"
			ERROR_VETH+=" local network settings feature."
			ERROR_MACVTAP="You will also need support for MAC-VLAN based tap driver."
			check_extra_config
		fi
	fi
}

src_configure() {
	# -DNM_USE_UTF: Enable unicode unconditionally. We already
	#                depended on ncurses[unicode].
	# -DNM_WITH_QEMU: Do not embbed qemu.
	local mycmakeargs=(
		-DNM_SAVEVM_SNAPSHOTS=$(usex savevm)
		-DNM_USE_UTF=on
		-DNM_WITH_DBUS=$(usex dbus)
		-DNM_WITH_NETWORK_MAP=$(usex network-map)
		-DNM_WITH_OVF_SUPPORT=$(usex ovf)
		-DNM_WITH_QEMU=off
		-DNM_WITH_SPICE=$(usex spice)
		-DNM_WITH_VNC_CLIENT=$(usex vnc-client)
	)
	cmake_src_configure
}

pkg_postinst() {
	elog "For non-root usage execute script:"
	elog "/usr/share/nemu/scripts/setup_nemu_nonroot.sh linux <username>"
	elog "and add udev rule:"
	elog "cp /usr/share/nemu/scripts/42-net-macvtap-perm.rules /etc/udev/rules.d"
	elog "Afterwards reboot or reload udev with"
	elog "udevadm control --reload-rules && udevadm trigger"
}
