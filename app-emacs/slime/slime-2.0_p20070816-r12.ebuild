# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit versionator common-lisp-2 elisp

DESCRIPTION="SLIME, the Superior Lisp Interaction Mode (Extended)"
HOMEPAGE="http://common-lisp.net/project/slime/"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="GPL-2 xref.lisp"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE="doc"

DEPEND="doc? ( virtual/tetex sys-apps/texinfo )"

CLPACKAGE=swank
CLSYSTEMS=swank
components=$(get_version_components)
last_comp=${components##* p}
SWANK_VERSION=${last_comp:0:4}-${last_comp:4:2}-${last_comp:6:2}
SITEFILE=70${PN}-gentoo.el

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/set-swank-wire-protocol-version.patch
	sed -i "s:@SWANK-WIRE-PROTOCOL-VERSION@:${SWANK_VERSION}:" swank.lisp
	epatch "${FILESDIR}"/move-6000-lines-and-fix-slime-edit-definition.patch
}

src_compile() {
	elisp-comp *.el || die "Cannot compile core Elisp files"
	if use doc; then make -C doc slime.{ps,pdf,info} || die "Cannot build docs"; fi
}

src_install() {
	elisp-install ${PN} *.el{,c} ChangeLog "${FILESDIR}"/swank-loader.lisp || die "Cannot install SLIME core"
	elisp-site-file-install "${FILESDIR}/${SITEFILE}"
	cp "${FILESDIR}"/swank.asd "${S}"
	common-lisp-install *.{lisp,asd}
	common-lisp-symlink-asdf
	dosym "${SITELISP}"/${PN}/swank-version.el "${CLSOURCEROOT}"/swank

	# install docs
	dodoc README* ChangeLog HACKING NEWS PROBLEMS
	if use doc; then
		dodoc doc/slime.{ps,pdf}
		doinfo doc/slime.info
	fi
}