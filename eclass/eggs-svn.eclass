# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:
#
# Copyright 2008 Leonardo Valeri Manera <l.valerimanera@gmail.com>
#
# @ECLASS: eggs-svn.eclass
# @MAINTAINER:
# @BLURB: Eclass for Chicken-Scheme SVN Egg packages
# @DESCRIPTION:
#
# This eclass provides generalized functions to compile, test and
# install eggs, as well as setting a number of variables to default
# or autogenerated values.

inherit eggs subversion

SRC_URI=""
ESVN_REPO_URI="https://galinha.ucpel.tche.br/svn/chicken-eggs/release/3/${EGG_NAME}/trunk"
ESVN_OPTIONS="--non-interactive --username anonymous"

eggs-svn_src_unpack() {
	mkdir ${S}
	cd ${S}
	subversion_fetch || die
}

EXPORT_FUNCTIONS src_unpack
