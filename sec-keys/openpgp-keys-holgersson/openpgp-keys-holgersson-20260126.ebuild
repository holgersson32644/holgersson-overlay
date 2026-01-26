# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="8"

SEC_KEYS_VALIDPGPKEYS=(
	8AD960BBA57AF79788CCFEC03CAA2CA514E4EE5E:holgersson:manual
)

inherit sec-keys

DESCRIPTION="OpenPGP key(s) used by Nils Freydank (holgersson) in holgersson-overlay"
HOMEPAGE="
	https://git.holgersson.xyz/gentoo-related/holgersson-overlay
	https://keyoxide.org/aspe:keyoxide.org:75MRSRVGUYEFOSNHFIXQJWPVXE
"

SRC_URI="
	https://git.holgersson.xyz/nfr.gpg -> ${PN}-manual-${PV}.asc
"

SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~arm64 ~hppa ~loong ~m68k ~mips ~ppc ~ppc64 ~riscv ~s390 ~sparc ~x86"
