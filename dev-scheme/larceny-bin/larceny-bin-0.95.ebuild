# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="Larceny is a Scheme Interpreter and a Scheme to IA32 and C Compiler"
SRC_URI="http://www.ccs.neu.edu/home/will/Larceny/LarcenyReleases/larceny-${PV}-bin-native-ia32-linux86.tar.gz"

HOMEPAGE="http://www.ccs.neu.edu/home/will/Larceny/"

LICENSE="Larceny"
SLOT="0"
KEYWORDS="~x86 ~amd64"

S="${WORKDIR}/larceny-${PV}-bin-native-ia32-linux86"

src_install() {
	dodoc COPYRIGHT README-FIRST.txt doc/HOWTO-* || die "installing docs"
	mkdir -p ${D}/opt/larceny
	mv -f larceny*\
		lib\
		startup.sch\
		*.heap\
		twobit\
		scheme-script\
		 "${D}/opt/larceny"
}
