# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
USE_RUBY="ruby33 ruby34"

RUBY_FAKEGEM_EXTRADOC="CHANGELOG.adoc README.adoc"
RUBY_FAKEGEM_EXTRAINSTALL="data"
RUBY_FAKEGEM_GEMSPEC="asciidoctor-pdf.gemspec"
RUBY_FAKEGEM_RECIPE_TEST="rspec3"

inherit ruby-fakegem

DESCRIPTION="A native PDF converter for AsciiDoc based on Asciidoctor and Prawn"
HOMEPAGE="https://github.com/asciidoctor/asciidoctor-pdf"
SRC_URI="https://github.com/asciidoctor/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

BDEPEND="test? ( app-text/poppler )"

ruby_add_rdepend "
	dev-ruby/asciidoctor
	dev-ruby/concurrent-ruby
	dev-ruby/matrix
	dev-ruby/prawn
	dev-ruby/prawn-icon
	dev-ruby/prawn-svg
	dev-ruby/prawn-table
	dev-ruby/prawn-templates
	dev-ruby/treetop
"
ruby_add_bdepend "test? (
	dev-ruby/chunky_png
	dev-ruby/coderay
	dev-ruby/pdf-inspector
)
"

all_ruby_prepare() {
	rm Gemfile || die

	sed -i -e "s:_relative ': './:" ${RUBY_FAKEGEM_GEMSPEC} || die
}

all_ruby_install() {
	all_fakegem_install
}

each_ruby_test() {
	RSPEC_VERSION=3 ruby-ng_rspec -t ~network -t ~visual spec
}
