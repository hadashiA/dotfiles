# $kNotwork: Makefile,v 1.6 2002/02/09 16:38:48 gotoken Exp $

BASENAME= which
TARGET += ${BASENAME}.html
TARGET += ${BASENAME}.txt
TARGET += ../README

RD2= rd2
HTML2TXT= lynx -dump -nolist

all: $(TARGET)

clean:
	rm -f $(TARGET) *~

../README: $(BASENAME).txt
	rm -f ../README
	cd ..; ln -s doc/which.txt README

.SUFFIXES: .rd .html .txt

.rd.html:
	${RD2} $< > $@ || (rm -f $@ ; exit 1)
.html.txt:
	${HTML2TXT} $< > $@ || (rm -f $@ ; exit 1)
