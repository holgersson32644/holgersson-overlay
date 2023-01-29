# Copyright 2020-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="8"

inherit acct-user

DESCRIPTION="User for matrix homerserver dendrite"
ACCT_USER_ID=-1
ACCT_USER_GROUPS=( dendrite )
ACCT_USER_HOME=/var/lib/dendrite
ACCT_USER_HOME_PERMS=0700
ACCT_USER_SHELL=/sbin/nologin
acct-user_add_deps
SLOT="0"
