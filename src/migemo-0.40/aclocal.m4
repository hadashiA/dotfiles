dnl aclocal.m4 generated automatically by aclocal 1.4-p5

dnl Copyright (C) 1994, 1995-8, 1999, 2001 Free Software Foundation, Inc.
dnl This file is free software; the Free Software Foundation
dnl gives unlimited permission to copy and/or distribute it,
dnl with or without modifications, as long as this notice is preserved.

dnl This program is distributed in the hope that it will be useful,
dnl but WITHOUT ANY WARRANTY, to the extent permitted by law; without
dnl even the implied warranty of MERCHANTABILITY or FITNESS FOR A
dnl PARTICULAR PURPOSE.

dnl Copyright (C) 1999 NISHIDA Keisuke <knishida@ring.aist.go.jp>
dnl
dnl This program is free software; you can redistribute it and/or modify
dnl it under the terms of the GNU General Public License as published by
dnl the Free Software Foundation; either version 2, or (at your option)
dnl any later version.
dnl
dnl This program is distributed in the hope that it will be useful,
dnl but WITHOUT ANY WARRANTY; without even the implied warranty of
dnl MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
dnl GNU General Public License for more details.
dnl
dnl You should have received a copy of the GNU General Public License
dnl along with this program; if not, write to the Free Software
dnl Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA
dnl 02111-1307, USA.

AC_DEFUN(AM_PATH_LISPDIR,
 [dnl #
  dnl # Check Emacs
  dnl #
  AC_ARG_WITH(emacs,
    [  --with-emacs=EMACS      compile with EMACS [EMACS=emacs, xemacs...]],
    [case "${withval}" in
       yes)	EMACS= ;;
       no)	AC_MSG_ERROR([emacs is not available]) ;;
       *)	EMACS=${withval} ;;
     esac], EMACS=)
  if test "x$EMACS" = "xt" -o "x$EMACS" = x; then
    AC_PATH_PROGS(EMACS, emacs xemacs mule, no)
    if test $EMACS = no; then
      AC_MSG_ERROR(you should install Emacs first)
    fi
  fi
  dnl # 
  dnl # Check Emacs directories
  dnl #
  AC_MSG_CHECKING([where emacs files are in])
  EMACS_BASENAME="`echo x$EMACS | sed -e 's/x//' -e 's/^.*\///'`"
  if test "x$emacsdir" = x; then
    if test "x$prefix" = "xNONE"; then
      prefix=$ac_default_prefix
    fi
    emacsdir="\$(datadir)/emacs"
    case "$EMACS_BASENAME" in
    emacs|emacs-*)
      if test -d $prefix/lib/emacs; then
	emacsdir="$prefix/lib/emacs"
      fi
      if test -d $prefix/share/emacs; then
	emacsdir="$prefix/share/emacs"
      fi
      ;;
    xemacs|xemacs-*)
      if test -d $prefix/lib/xemacs; then
	emacsdir="$prefix/lib/xemacs"
      fi
      if test -d $prefix/share/xemacs; then
	emacsdir="$prefix/share/xemacs"
      fi
      ;;
    mule|mule-*)
      if test -d $prefix/lib/emacs; then
	emacsdir="$prefix/lib/emacs"
      fi
      if test -d $prefix/share/emacs; then
	emacsdir="$prefix/share/emacs"
      fi
      if test -d $prefix/lib/mule; then
	emacsdir="$prefix/lib/mule"
      fi
      if test -d $prefix/share/mule; then
	emacsdir="$prefix/share/mule"
      fi
      ;;
    esac
  fi
  AC_MSG_RESULT($emacsdir)
  AC_SUBST(emacsdir)
  dnl # 
  dnl # Check Emacs site-lisp directories
  dnl #
  AC_ARG_WITH(lispdir,
    [  --with-lispdir=DIR      emacs lisp files go to DIR [guessed]],
    [case "${withval}" in
       yes)	lispdir= ;;
       no)	AC_MSG_ERROR(lispdir is not available) ;;
       *)	lispdir=${withval} ;;
     esac], lispdir=)
  AC_MSG_CHECKING([where .elc files should go])
  if test "x$lispdir" = x; then
    lispdir="$emacsdir/site-lisp"
    if test -d $emacsdir/lisp; then
      lispdir="$emacsdir/lisp"
    fi
    case "$EMACS_BASENAME" in
    xemacs|xemacs-*)
      lispdir="$lispdir/lookup"
      ;;
    esac
  fi
  AC_MSG_RESULT($lispdir)
  AC_SUBST(lispdir)])


#
# by Satoru Takabayashi <satoru@namazu.org>
#
AC_DEFUN(AM_PATH_RUBYDIR,
 [dnl # 
  dnl # Check Ruby directory
  dnl #
  AC_MSG_CHECKING([where emacs files are in])
  AC_MSG_RESULT($rubydir)
  AC_SUBST(rubydir)
  AC_ARG_WITH(rubydir,
    [  --with-rubydir=DIR      Ruby library files go to DIR [guessed]],
    [case "${withval}" in
       yes)	rubydir= ;;
       no)	AC_MSG_ERROR(rubydir is not available) ;;
       *)	rubydir=${withval} ;;
     esac], rubydir=)
  AC_MSG_CHECKING([where .rb files should go])
  if test "x$rubydir" = x; then
    changequote(<<, >>)
    rubydir=`ruby -rrbconfig -e 'puts Config::CONFIG["sitedir"]'`
    changequote([, ])
  fi
  AC_MSG_RESULT($rubydir)
  AC_SUBST(rubydir)])



# Do all the work for Automake.  This macro actually does too much --
# some checks are only needed if your package does certain things.
# But this isn't really a big deal.

# serial 1

dnl Usage:
dnl AM_INIT_AUTOMAKE(package,version, [no-define])

AC_DEFUN([AM_INIT_AUTOMAKE],
[AC_REQUIRE([AC_PROG_INSTALL])
PACKAGE=[$1]
AC_SUBST(PACKAGE)
VERSION=[$2]
AC_SUBST(VERSION)
dnl test to see if srcdir already configured
if test "`cd $srcdir && pwd`" != "`pwd`" && test -f $srcdir/config.status; then
  AC_MSG_ERROR([source directory already configured; run "make distclean" there first])
fi
ifelse([$3],,
AC_DEFINE_UNQUOTED(PACKAGE, "$PACKAGE", [Name of package])
AC_DEFINE_UNQUOTED(VERSION, "$VERSION", [Version number of package]))
AC_REQUIRE([AM_SANITY_CHECK])
AC_REQUIRE([AC_ARG_PROGRAM])
dnl FIXME This is truly gross.
missing_dir=`cd $ac_aux_dir && pwd`
AM_MISSING_PROG(ACLOCAL, aclocal, $missing_dir)
AM_MISSING_PROG(AUTOCONF, autoconf, $missing_dir)
AM_MISSING_PROG(AUTOMAKE, automake, $missing_dir)
AM_MISSING_PROG(AUTOHEADER, autoheader, $missing_dir)
AM_MISSING_PROG(MAKEINFO, makeinfo, $missing_dir)
AC_REQUIRE([AC_PROG_MAKE_SET])])

#
# Check to make sure that the build environment is sane.
#

AC_DEFUN([AM_SANITY_CHECK],
[AC_MSG_CHECKING([whether build environment is sane])
# Just in case
sleep 1
echo timestamp > conftestfile
# Do `set' in a subshell so we don't clobber the current shell's
# arguments.  Must try -L first in case configure is actually a
# symlink; some systems play weird games with the mod time of symlinks
# (eg FreeBSD returns the mod time of the symlink's containing
# directory).
if (
   set X `ls -Lt $srcdir/configure conftestfile 2> /dev/null`
   if test "[$]*" = "X"; then
      # -L didn't work.
      set X `ls -t $srcdir/configure conftestfile`
   fi
   if test "[$]*" != "X $srcdir/configure conftestfile" \
      && test "[$]*" != "X conftestfile $srcdir/configure"; then

      # If neither matched, then we have a broken ls.  This can happen
      # if, for instance, CONFIG_SHELL is bash and it inherits a
      # broken ls alias from the environment.  This has actually
      # happened.  Such a system could not be considered "sane".
      AC_MSG_ERROR([ls -t appears to fail.  Make sure there is not a broken
alias in your environment])
   fi

   test "[$]2" = conftestfile
   )
then
   # Ok.
   :
else
   AC_MSG_ERROR([newly created file is older than distributed files!
Check your system clock])
fi
rm -f conftest*
AC_MSG_RESULT(yes)])

dnl AM_MISSING_PROG(NAME, PROGRAM, DIRECTORY)
dnl The program must properly implement --version.
AC_DEFUN([AM_MISSING_PROG],
[AC_MSG_CHECKING(for working $2)
# Run test in a subshell; some versions of sh will print an error if
# an executable is not found, even if stderr is redirected.
# Redirect stdin to placate older versions of autoconf.  Sigh.
if ($2 --version) < /dev/null > /dev/null 2>&1; then
   $1=$2
   AC_MSG_RESULT(found)
else
   $1="$3/missing $2"
   AC_MSG_RESULT(missing)
fi
AC_SUBST($1)])

