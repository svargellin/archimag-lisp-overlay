# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit common-lisp

DESCRIPTION='CL-FAD is a thin portability layer atop the Common Lisp standard pathname functions.'
HOMEPAGE="http://weitz.de/cl-fad/"
SRC_URI="http://common-lisp.net/~sionescu/ediware/${PN}_${PV}.orig.tar.gz"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""
DEPEND="dev-lisp/common-lisp-controller
	virtual/commonlisp"

CLPACKAGE=cl-fad

src_install() {
	common-lisp-install *.{asd,lisp}
	common-lisp-system-symlink
	dodoc CHANGELOG README
	dohtml doc/index.html
}
