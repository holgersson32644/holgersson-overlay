# Copyright 2020-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=hatchling
PYTHON_COMPAT=( python3_13 )

inherit distutils-r1 pypi shell-completion

DESCRIPTION="Add an OCR text layer to scanned PDF files"
HOMEPAGE="https://github.com/ocrmypdf/OCRmyPDF"
# upstream's naming is conceivable, but still braindead.
SRC_URI="$(pypi_sdist_url "OCRmyPDF" "${PV}")"


LICENSE="CC-BY-SA-2.5 CC-BY-SA-4.0 MIT MPL-2.0 ZLIB"
SLOT="0"
KEYWORDS="~amd64"
IUSE="heif"

DEPEND="
	app-text/unpaper
	media-gfx/pngquant
	media-libs/jbig2enc
	heif? ( dev-python/pillow-heif[${PYTHON_USEDEP}] )
"
RDEPEND="
	${DEPEND}
	app-text/ghostscript-gpl
	app-text/pdfminer[${PYTHON_USEDEP}]
	app-text/tesseract[jpeg,tiff,png,webp]
	dev-python/deprecation[${PYTHON_USEDEP}]
	dev-python/packaging[${PYTHON_USEDEP}]
	dev-python/pikepdf[${PYTHON_USEDEP}]
	dev-python/pillow[jpeg2k,lcms,${PYTHON_USEDEP}]
	dev-python/pluggy[${PYTHON_USEDEP}]
	dev-python/rich[${PYTHON_USEDEP}]
	>=media-gfx/img2pdf-0.5[${PYTHON_USEDEP}]
"
BDEPEND="
	${DEPEND}
	dev-python/hatch-vcs[${PYTHON_USEDEP}]
	test? (
		app-text/tessdata_fast[l10n_de,l10n_en]
		dev-python/python-xmp-toolkit[${PYTHON_USEDEP}]
		dev-python/reportlab[${PYTHON_USEDEP}]
	)
"

EPYTEST_PLUGINS=( hypothesis )
EPYTEST_XDIST="yes"
EPYTEST_IGNORE=(
	# Tests shell completion for bash and fish,
	# if not run inside docker.
	tests/test_completion.py
)
EPYTEST_DESELECT=(
	# Fails if Tesseract was compiled with Clang
	tests/test_rotation.py::test_rotate_deskew_ocr_timeout

	# XFAIL reason should be a string, not a tuple
	tests/test_metadata.py::test_malformed_docinfo
)

distutils_enable_tests pytest

distutils_enable_sphinx docs dev-python/sphinx-issues dev-python/sphinx-rtd-theme

export SETUPTOOLS_SCM_PRETEND_VERSION=${PV}

python_test() {
	epytest -o addopts=
}

src_install() {
	distutils-r1_src_install

	newbashcomp misc/completion/ocrmypdf.bash ocrmypdf
	dofishcomp misc/completion/ocrmypdf.fish
}
