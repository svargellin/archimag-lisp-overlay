# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit common-lisp-2 elisp

DESCRIPTION="SLIME, the Superior Lisp Interaction Mode (Extended)"
HOMEPAGE="http://common-lisp.net/project/${PN}/"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="GPL-2 xref.lisp"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE="doc"

DEPEND="doc? ( virtual/latex-base )"

CLPACKAGE=swank
CLSYSTEMS=swank
SITEFILE=70${PN}-gentoo.el

src_unpack() {
	unpack ${A}
	cd "${S}"

	SWANK_VERSION=$(head -n 1 ChangeLog | awk '{print $1}')
	sed "s:(defvar \*swank-wire-protocol-version\* nil:(defvar \*swank-wire-protocol-version\* \"${SWANK_VERSION}\":" -i swank.lisp

	epatch "${FILESDIR}"/move-6000-lines-and-fix-slime-edit-definition.patch
}

src_compile() {
	elisp-comp *.el || die "Cannot compile core Elisp files"
	emake -j1 -C doc ${PN}.info || die "Cannot build info docs"
	if use doc; then emake -j1 -C doc ${PN}.{ps,pdf} || die "Cannot build docs"; fi
}

src_install() {
	elisp-install ${PN} *.el{,c} ChangeLog "${FILESDIR}"/swank-loader.lisp || die "Cannot install SLIME core"
	elisp-site-file-install "${FILESDIR}/${SITEFILE}"
	cp "${FILESDIR}"/swank.asd "${S}"
	# remove upstream swank-loader, since it will be unused
	rm "${S}"/swank-loader.lisp
	common-lisp-install *.{lisp,asd}
	common-lisp-symlink-asdf
	dosym "${SITELISP}"/${PN}/swank-version.el "${CLSOURCEROOT}"/swank

	# install docs
	dodoc README* ChangeLog HACKING NEWS PROBLEMS
	doinfo doc/${PN}.info
	use doc && dodoc doc/${PN}.{ps,pdf}
}
