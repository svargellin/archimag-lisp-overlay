# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $
#
# This eclass contains various utilities used in the Gentoo Lisp overlay
#
# Public functions:
#
# glo_usev flagname [<if_yes> [<if_no>]]
#   If $(use FLAGNAME) return true, echo IF_YES to standard output,
#   otherwise echo IF_NO. IF_YES defaults to FLAGNAME if not specified
#

glo_usev() {
	if [[ $# < 1 || $# > 3 ]]; then
		echo "Usage: ${0} flag [if_yes [if_no]]"
		die "${0}: wrong number of arguments: $#"
	fi
	local if_yes="${2:-${1}}" if_no="${3}"
	if useq ${1} ; then
		printf "%s" "${if_yes}"
		return 0
	else
		printf "%s" "${if_no}"
		return 1
	fi
}