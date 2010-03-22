# $kNotwork: Makefile,v 1.5 2002/02/09 16:24:46 gotoken Exp $

WORKDIR= ./work
CVSROOT= /home/chaos/gotoken/ncvs
PACKAGE= which
DOCDIR= doc
PROJECT= devel/which

TOPDIR= ${WORKDIR}/devel
BASENAME= ${PACKAGE}${SUFFIX}

all: install

install:
	@echo "To install: "
	@echo "  ruby install.rb"
	@echo "or"
	@echo "  ruby install.rb -d <installdir>"

tarball: document
	mv ${TOPDIR}/${PACKAGE} ${TOPDIR}/${BASENAME}
	tar zcvf ${BASENAME}.tar.gz -C ${TOPDIR} ${BASENAME}

export:
	rm -fr ${WORKDIR}
	mkdir ${WORKDIR}
	(cd ${WORKDIR} && cvs -d ${CVSROOT} export -r ${TAG} ${PROJECT})

document: export
	(cd ${TOPDIR}/${PACKAGE}/${DOCDIR} && ${MAKE})
