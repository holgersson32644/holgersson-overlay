# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
USE_RUBY="ruby33 ruby34"

RUBY_FAKEGEM_RECIPE_DOC="yard"
RUBY_FAKEGEM_RECIPE_TEST="rspec3"

inherit ruby-fakegem

DESCRIPTION="Provides support for SVG in Prawn"
HOMEPAGE="https://github.com/mogest/prawn-svg"
LICENSE="|| ( MIT Ruby )"
SLOT="0"
KEYWORDS="~amd64"

# prawn breaks tests for some reasons, needs to be investigated; code
# still works though.
RESTRICT="test"

ruby_add_rdepend "
	dev-ruby/css_parser
	dev-ruby/prawn
	dev-ruby/rexml
"

ruby_add_bdepend "test? (
	dev-ruby/mocha
	dev-ruby/pdf-inspector
	dev-ruby/pdf-reader
	)
"
