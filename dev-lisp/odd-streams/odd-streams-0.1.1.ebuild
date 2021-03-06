# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit common-lisp-2

DESCRIPTION='ODD-STREAMS is a library which implements binary streams with "odd" byte sizes.'
HOMEPAGE="http://weitz.de/odd-streams/
		http://www.cliki.net/odd-streams"
SRC_URI="http://common-lisp.net/~sionescu/files/${P}.tar.bz2"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""

RDEPEND=">=dev-lisp/trivial-gray-streams-20060925"

src_install() {
	common-lisp-install *.{lisp,asd} test/
	common-lisp-symlink-asdf
	dodoc CHANGELOG.txt
	dohtml doc/index.html
}
