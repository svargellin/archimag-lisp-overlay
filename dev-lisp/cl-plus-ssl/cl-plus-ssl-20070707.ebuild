# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit common-lisp-2 eutils multilib

MY_PV="${PV:0:4}-${PV:4:2}-${PV:6:2}"
DESCRIPTION="A simple Common Lisp interface to OpenSSL."
HOMEPAGE="http://sourceforge.net/projects/${PN}/"
SRC_URI="http://common-lisp.net/project/${PN}/download/cl+ssl-${MY_PV}.tar.gz"
LICENSE="MIT"
SLOT="0"
KEYWORDS="~x86 ~sparc ~amd64 ~ppc"
IUSE=""
DEPEND=">=dev-lisp/cffi-0.9.1
		dev-lisp/trivial-gray-streams
		dev-lisp/flexi-streams"

CLPACKAGE=cl+ssl
CLSYSTEMS=cl+ssl

S="${WORKDIR}/cl+ssl-${MY_PV}"

src_unpack() {
	unpack ${A}
	rm "${S}"/Makefile
	sed -i "s,/usr/lib,/usr/$(get_libdir),g" "${S}"/cl+ssl.asd
}

src_install() {
	common-lisp-install *.{lisp,asd}
	common-lisp-symlink-asdf
	dohtml index.{css,html}
}
