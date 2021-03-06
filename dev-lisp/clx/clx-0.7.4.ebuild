# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2
inherit common-lisp-2 eutils

DESCRIPTION="CLX is the Common Lisp interface to the X11 protocol primarily for SBCL."
HOMEPAGE="http://www.cliki.net/CLX"
SRC_URI="http://common-lisp.net/~abridgewater/dist/${PN}/${P}.tgz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE="doc"

DEPEND="sys-apps/texinfo
		doc? ( virtual/texi2dvi )"
RDEPEND="!dev-lisp/cl-${PN}"

src_unpack() {
	unpack ${A}
	cd "${S}"
	rm {exclcmac,sockcl,defsystem,provide,cmudep}.lisp
}

src_prepare() {
	epatch "${FILESDIR}"/gentoo-fix-asd.patch
	epatch "${FILESDIR}"/gentoo-fix-dep-openmcl.patch
	epatch "${FILESDIR}"/gentoo-fix-unused-vars.patch
	epatch "${FILESDIR}"/gentoo-fix-obsolete-eval-when.patch
}

src_compile() {
	cd manual
	makeinfo ${PN}.texinfo -o ${PN}.info || die "Cannot compile info docs"
	if use doc ; then
		VARTEXFONTS="${T}"/fonts \
			texi2pdf ${PN}.texinfo -o ${PN}.pdf || die "Cannot build PDF docs"
	fi
}

src_install() {
	common-lisp-install *.{lisp,asd} {debug,demo,test}/*.lisp
	common-lisp-symlink-asdf
	dodoc NEWS CHANGES README*
	doinfo manual/${PN}.info
	use doc && dodoc manual/${PN}.pdf
}
