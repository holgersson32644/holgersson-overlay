# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit meson bash-completion-r1 flag-o-matic gnome2-utils linux-info optfeature systemd toolchain-funcs udev multilib-minimal

# When COMMIT is defined, this ebuild turns from a release into a snapshot ebuild:
COMMIT="d21d0d89a55af491bfc7b9f3a142554a4d7ec8be"
# When COMMIT is defined, this enables a work-around for missing .tarball-version file:
_SNAPSHOT_FIX_GITVERSION=1

DESCRIPTION="A networked sound server with an advanced plugin system"
HOMEPAGE="https://www.freedesktop.org/wiki/Software/PulseAudio/"
if [[ ${PV} = 9999 ]]; then
	inherit git-r3
	EGIT_BRANCH="master"
	EGIT_REPO_URI="https://gitlab.freedesktop.org/${PN}/${PN}"
else
	if [[ -n ${COMMIT} ]]; then
		SRC_URI="https://gitlab.freedesktop.org/${PN}/${PN}/-/archive/${COMMIT}/${PN}-${COMMIT}.tar.gz -> ${P}.tar.gz"
		S="${WORKDIR}"/${PN}-${COMMIT}
	else
		SRC_URI="https://freedesktop.org/software/${PN}/releases/${P}.tar.xz"
	fi
	KEYWORDS="~alpha ~amd64 ~arm ~arm64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~amd64-linux ~x86-linux"
fi
# libpulse-simple and libpulse link to libpulse-core; this is daemon's
# library and can link to gdbm and other GPL-only libraries. In this
# cases, we have a fully GPL-2 package. Leaving the rest of the
# GPL-forcing USE flags for those who use them.
LICENSE="!gdbm? ( LGPL-2.1 ) gdbm? ( GPL-2 )"

SLOT="0"

# +alsa-plugin as discussed in bug #519530
# TODO: Deal with bluez5-gstreamer
# WARNING: for oss and tcpd support, a snapshot is needed (or wait for 15.0 to come out)
# NOTE: Add tdb IUSE?
# TODO: Find out why webrtc-aec is always enabled - there's already the always available speexdsp-aec
# NOTE: The current ebuild sets +X almost certainly just for the pulseaudio.desktop file
IUSE="+alsa +alsa-plugin +asyncns bluetooth dbus +daemon doc equalizer +gdbm gstreamer gnome +glib
gtk ipv6 jack lirc native-headset ofono-headset +orc oss selinux sox ssl systemd system-wide tcpd
test +udev +webrtc-aec +X zeroconf"

RESTRICT="!test? ( test )"

# See "*** BLUEZ support not found (requires D-Bus)" in configure.ac
# Basically all IUSE are either ${MULTILIB_USEDEP} for client libs or they belong under !daemon ()
# We duplicate alsa-plugin, {native,ofono}-headset under daemon to let users deal with them at once
REQUIRED_USE="
	alsa-plugin? ( alsa )
	bluetooth? ( dbus )
	!daemon? (
		!alsa
		!alsa-plugin
		!bluetooth
		!equalizer
		!gdbm
		!gtk
		!jack
		!lirc
		!native-headset
		!ofono-headset
		!orc
		!sox
		!ssl
		!system-wide
		!udev
		!webrtc-aec
		!zeroconf
	)
	equalizer? ( dbus )
	native-headset? ( bluetooth )
	ofono-headset? ( bluetooth )
	udev? ( || ( alsa oss ) )
	zeroconf? ( dbus )
"

# libpcre needed in some cases, bug #472228 # TODO: Read it
RDEPEND="
	|| (
		elibc_glibc? ( virtual/libc )
		elibc_uclibc? ( virtual/libc )
		dev-libs/libpcre
	)
	>=media-libs/libsndfile-1.0.20[${MULTILIB_USEDEP}]
	X? (
		>=x11-libs/libxcb-1.6[${MULTILIB_USEDEP}]
		daemon? (
			>=x11-libs/libX11-1.4.0
			x11-libs/libSM
			x11-libs/libICE
			>=x11-libs/libXtst-1.0.99.2
		)
	)
	>=sys-libs/libcap-2.22-r2
	alsa? ( >=media-libs/alsa-lib-1.0.19 )
	glib? ( >=dev-libs/glib-2.26.0:2[${MULTILIB_USEDEP}] )
	zeroconf? ( >=net-dns/avahi-0.6.12[dbus] )
	jack? ( virtual/jack )
	tcpd? ( sys-apps/tcp-wrappers[${MULTILIB_USEDEP}] )
	lirc? ( app-misc/lirc )
	dbus? ( >=sys-apps/dbus-1.0.0[${MULTILIB_USEDEP}] )
	gtk? ( x11-libs/gtk+:3 )
	bluetooth? (
		>=net-wireless/bluez-5
		media-libs/sbc
	)
	asyncns? ( net-libs/libasyncns[${MULTILIB_USEDEP}] )
	udev? ( >=virtual/udev-143[hwdb(+)] )
	equalizer? (
		sci-libs/fftw:3.0
	)
	ofono-headset? ( >=net-misc/ofono-1.13 )
	orc? ( >=dev-lang/orc-0.4.15 )
	sox? ( >=media-libs/soxr-0.1.1 )
	ssl? ( dev-libs/openssl:0= )
	media-libs/speexdsp[${MULTILIB_USEDEP}]
	gdbm? ( sys-libs/gdbm:= )
	webrtc-aec? ( >=media-libs/webrtc-audio-processing-0.2 )
	systemd? ( sys-apps/systemd:0=[${MULTILIB_USEDEP}] )
	!systemd? ( sys-auth/elogind )
	daemon? ( dev-libs/libltdl:0[${MULTILIB_USEDEP}] )
	selinux? ( sec-policy/selinux-pulseaudio )
	gstreamer? (
		media-libs/gst-plugins-base
		media-libs/gstreamer
	)
" # libltdl is a valid RDEPEND, libltdl.so is used for native abi in pulsecore and daemon

DEPEND="${RDEPEND}
	X? ( x11-base/xorg-proto )
	dev-libs/libatomic_ops
	dev-libs/libltdl:0[${MULTILIB_USEDEP}]
"
# This is a PDEPEND to avoid a circular dep
# TODO: Verify that alsa-plugins actually needs matching ${MULTILIB_USEDEP}
PDEPEND="
	alsa? ( alsa-plugin? ( >=media-plugins/alsa-plugins-1.0.27-r1[pulseaudio,${MULTILIB_USEDEP}] ) )
"

# alsa-utils dep is for the alsasound init.d script (see bug 155707); TODO: read it
# NOTE: if (e)logind is now mandatory, then the act-group/audio is needed only with system-wide
RDEPEND="${RDEPEND}
	system-wide? (
		alsa? ( media-sound/alsa-utils )
		acct-user/pulse
		acct-group/pulse-access
	)
	acct-group/audio
"

BDEPEND="
	app-doc/doxygen
	orc? ( >=dev-lang/orc-0.4.15 )
	system-wide? ( dev-util/unifdef )
	test? ( >=dev-libs/check-0.9.10 )
	sys-devel/gettext
	sys-devel/m4
	virtual/pkgconfig
"

# BUG: work-around for a weird bug
#DOCS=( NEWS README ) # todo is useless to install

#PATCHES=()

pkg_pretend() {
	CONFIG_CHECK="~HIGH_RES_TIMERS"
	WARNING_HIGH_RES_TIMERS="CONFIG_HIGH_RES_TIMERS:\tis not set (required for enabling timer-based scheduling in pulseaudio)\n"
	check_extra_config

	if linux_config_exists; then
		local snd_hda_prealloc_size=$(linux_chkconfig_string SND_HDA_PREALLOC_SIZE)
		if [[ -n "${snd_hda_prealloc_size}" ]] && [[ "${snd_hda_prealloc_size}" -lt 2048 ]]; then
			ewarn "A pre-allocated buffer-size of 2048 (kB) or higher is recommended for the"
			ewarn "HD-audio driver when using timer-based scheduling!"
			ewarn "CONFIG_SND_HDA_PREALLOC_SIZE=${snd_hda_prealloc_size}"
		fi
	fi
}

pkg_setup() {
	linux-info_pkg_setup
	gnome2_environment_reset # bug 543364
}

src_prepare() {
	default

	if [[ -n ${COMMIT} ]]; then
		# This file really should be upstream's responsibility but what can you do other than hack
		# together a work-around for an upstream's tarball generator, lacking required integration?
		if [[ -n ${_SNAPSHOT_FIX_GITVERSION} ]] && [[ ${_SNAPSHOT_FIX_GITVERSION} -ge 1 ]]; then
			echo ${PV%_*}-${COMMIT:0:8} > .tarball-version
		fi
	fi

	# Skip test that cannot work with sandbox, bug 501846
	# Hopefully gone for good but kept for now as a reference in the off chance they do pop back up
	#sed -i -e '/lock-autospawn-test /d' src/Makefile.am || die
	#sed -i -e 's/lock-autospawn-test$(EXEEXT) //' src/Makefile.in || die
}

pa_meson_multilib_native_use_enable() {
	echo "-D${2:-${1}}=$(multilib_native_usex ${1} true false)"
}

pa_meson_multilib_native_use_feature() {
	echo "-D${2:-${1}}=$(multilib_native_usex ${1} enabled disabled)"
}

multilib_src_configure() {
	local emesonargs=(
		-Dadrian-aec=false # Not packaged?
		--localstatedir="${EPREFIX}"/var
		-Dmodlibexecdir="${EPREFIX}"/usr/"$(get_libdir)/${P}"
#		-Dsystemduserunitdir=$(systemd_get_userunitdir)
		-Dudevrulesdir="$(get_udevdir)"/rules.d
		-Dbashcompletiondir="$(get_bashcompdir)"
		$(pa_meson_multilib_native_use_feature alsa)
		$(pa_meson_multilib_native_use_enable bluetooth bluez5)
		$(pa_meson_multilib_native_use_enable daemon)
		$(pa_meson_multilib_native_use_enable native-headset bluez5-native-headset)
		$(pa_meson_multilib_native_use_enable ofono-headset bluez5-ofono-headset)
		$(pa_meson_multilib_native_use_feature glib gsettings) # Supposedly correct?
		$(pa_meson_multilib_native_use_feature gstreamer)
		$(pa_meson_multilib_native_use_feature gtk)
		$(pa_meson_multilib_native_use_feature jack)
		-Dsamplerate=disabled # Matches upstream
		$(pa_meson_multilib_native_use_feature lirc)
		$(pa_meson_multilib_native_use_feature orc)
		$(pa_meson_multilib_native_use_feature oss oss-output)
		$(pa_meson_multilib_native_use_feature ssl openssl)
		# tests involve random modules, so just do them for the native # TODO: tests should run always
		$(pa_meson_multilib_native_use_enable test tests)
		$(pa_meson_multilib_native_use_feature udev)
		$(pa_meson_multilib_native_use_feature webrtc-aec)
		$(pa_meson_multilib_native_use_feature zeroconf avahi)
		$(pa_meson_multilib_native_use_feature equalizer fftw)
		$(pa_meson_multilib_native_use_feature sox soxr)
		-Ddatabase=$(multilib_native_usex gdbm gdbm simple) # TODO: tdb is also an option
		$(meson_use gnome stream-restore-clear-old-devices) # TODO: Get ACK'ed on this
		$(meson_feature glib)
		$(meson_feature asyncns)
		#$(meson_use cpu_flags_arm_neon neon-opt)
		$(meson_feature tcpd tcpwrap) # TODO: system-wide specific?
		$(meson_feature dbus)
		$(meson_feature X x11)
		$(meson_feature systemd)
		$(meson_use ipv6)
	)

	if multilib_is_native_abi; then
		# Make padsp work for non-native ABI, supposedly only possible with glibc; this is used by /usr/bin/padsp that comes from native build, thus we need this argument for native build
		if use elibc_glibc; then
			emesonargs+=( -Dpulsedsp-location="${EPREFIX}"'/usr/\\$$LIB/pulseaudio' )
		fi
	else
		if ! use elibc_glibc; then
			# Non-glibc multilib is probably non-existent but just in case:
			ewarn "padsp wrapper for OSS emulation will only work with native ABI applications!"
		fi
	fi

	meson_src_configure
}

multilib_src_compile() {
	meson_src_compile

	if multilib_is_native_abi; then
		use doc && meson_src_compile doxygen
	fi
}

multilib_src_test() {
	# For on-native ABIs we build only the client libraries, which means that upstream disables
	# almost all tests. On the upside the few remaining ones should work, so we can at least noew
	# run the src_test phase for non-native ABIs, too.
	#if multilib_is_native_abi; then
	meson_src_test
	#fi
}

multilib_src_install() {
	meson_src_install

	if multilib_is_native_abi; then
		if use doc; then
			# TODO: check it's installing into the right place
			docinto html
			dodoc -r doxygen/html/
		fi
	else
		# remove foreign abi modules
		rm -rf "${ED}"/usr/$(get_libdir)/pulse-*/ || die
	fi
}

multilib_src_install_all() {
	if use system-wide; then
		newconfd "${FILESDIR}"/pulseaudio.conf.d pulseaudio

		use_define() {
			local define=${2:-$(echo $1 | tr '[:lower:]' '[:upper:]')}

			use "$1" && echo "-D$define" || echo "-U$define"
		}

		unifdef $(use_define zeroconf AVAHI) \
			$(use_define alsa) \
			$(use_define bluetooth) \
			$(use_define udev) \
			"${FILESDIR}"/pulseaudio.init.d-5 \
			> "${T}"/pulseaudio || die

		doinitd "${T}"/pulseaudio

		systemd_dounit "${FILESDIR}"/${PN}.service

		# We need /var/run/pulse, bug 442852
		systemd_newtmpfilesd "${FILESDIR}"/${PN}.tmpfiles ${PN}.conf
	else
		# Prevent warnings when system-wide is not used, bug 447694
		if use dbus && use daemon; then
			rm "${ED}"/etc/dbus-1/system.d/pulseaudio-system.conf || die
		fi
	fi

	if use zeroconf; then
		sed -e '/module-zeroconf-publish/s:^#::' \
			-i "${ED}/etc/pulse/default.pa" || die
	fi

	find "${ED}" \( -name '*.a' -o -name '*.la' \) -delete || die
}

pkg_postinst() {
	gnome2_schemas_update
	if use system-wide; then
		elog "You have enabled the 'system-wide' USE flag for pulseaudio."
		elog "This mode should only be used on headless servers, embedded systems,"
		elog "or thin clients. It will usually require manual configuration, and is"
		elog "incompatible with many expected pulseaudio features."
		elog "On normal desktop systems, system-wide mode is STRONGLY DISCOURAGED."
		elog "For more information, see"
		elog "    https://www.freedesktop.org/wiki/Software/PulseAudio/Documentation/User/WhatIsWrongWithSystemWide/"
		elog "    https://www.freedesktop.org/wiki/Software/PulseAudio/Documentation/User/SystemWide/"
		elog "    https://wiki.gentoo.org/wiki/PulseAudio#Headless_server"
	fi

	if use equalizer; then
		elog "You will need to load some extra modules to make qpaeq work."
		elog "You can do that by adding the following two lines in"
		elog "/etc/pulse/default.pa and restarting pulseaudio:"
		elog "load-module module-equalizer-sink"
		elog "load-module module-dbus-protocol"
	fi

	if use native-headset && use ofono-headset; then
		elog "You have enabled both native and ofono headset profiles. The runtime decision"
		elog "which to use is done via the 'headset' argument of module-bluetooth-discover."
	fi

	if use systemd && use daemon; then
		elog "It's recommended to start pulseaudio via its systemd user units:"
		elog "systemctl --user enable pulseaudio.service pulseaudio.socket"
		elog "The change from autospawn to user units will take effect after restarting."
	fi

	optfeature_header "PulseAudio can be enhanced by installing the following:"
	use equalizer && optfeature "using the qpaeq script" dev-python/PyQt5[dbus,widgets]
	use dbus && optfeature "restricted realtime capabilities vai D-Bus" sys-auth/rtkit
}

pkg_postrm() {
	gnome2_schemas_update
}
