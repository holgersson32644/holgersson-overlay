.. Title: Readme for holgersson-overlay
.. Author: Nils Freydank <holgersson [ascii-symbol-64] posteo [ascii-symbol-46] de>

Main
====

This is my private and unofficial overlay_ for Gentoo/Linux.
There will be different ebuilds from different sources, hopefully only temporary
before submitting to the `main Gentoo bugtracker`_ resp. to the `main portage tree`_.

Setup & synchronisation
=======================
Just run layman from `app-portage/layman` with needed privileges, e.g. root:

.. sh
   $ layman -a holgersson-overlay

and optional for global updates:

.. sh
   $ layman -S
   $ emerge --sync

You might set `USE="sync-plugin-portage"` for layman, too.

Maintainer
==========

If you encounter bugs, please send a mail to
**holgersson [ascii-symbol-64] posteo [ascii-symbol-46] de**
or open a bug report on the `main Gentoo bugtracker`_
(please remember to Cc me there). Bug descriptions, suggestions, patches,
critics and chorus of praise are all welcome!

GPG key ID: **0x00EF D31F 1B60 D5DB ADB8 31C1 C0EC E696 0E54 475B**

License
=======

- The contents of this document are licensed under the `CC-BY-SA-3.0 license`. The ebuilds are licensed under the `GNU General Public License v2` for compability with the main Gentoo/portage tree.
- Source files might have different licenses; these should be outlined in the ebuilds themselves.
- The licenses are choosen to fit into the main gentoo licenses pool; if you suggest other licenses, or think I’m mistaken in the licenses I indicate anywhere please contact the maintainer (see the resp. section above)!

.. _overlay: https://git.holgersson.xyz/holgersson-overlay
.. _`main Gentoo bugtracker`: https://bugs.gentoo.org
.. _`main portage tree`: https://packages.gentoo.org/

.. vim:fileencoding=utf-8:ts=4:syntax=rst:colorcolumn=81
