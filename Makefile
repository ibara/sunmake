# SunPro Make
# Will work on OpenBSD. Other systems maybe.
# You need the gettext package installed first.

CXX =	c++
CXXFLAGS = -O2 -pipe
CXXFLAGS += -Iinclude -I/usr/local/include
CXXFLAGS += -Wno-deprecated-register -Wno-parentheses -Wno-switch

LDFLAGS += -L/usr/local/lib
LIBS = -lintl

PROG =	sunmake

OBJS =	bin/ar.o bin/depvar.o bin/doname.o bin/dosys.o \
	bin/files.o bin/globals.o bin/implicit.o \
	bin/macro.o bin/main.o bin/misc.o \
	bin/nse_printdep.o bin/parallel.o bin/pmake.o \
	bin/read.o bin/read2.o bin/rep.o bin/state.o

BSDOBJS =	lib/bsd/bsd.o

MKSHOBJS =	lib/mksh/dosys.o lib/mksh/globals.o \
		lib/mksh/i18n.o lib/mksh/macro.o \
		lib/mksh/misc.o lib/mksh/mksh.o \
		lib/mksh/read.o

VROOTOBJS =	lib/vroot/access.o lib/vroot/args.o \
		lib/vroot/chdir.o lib/vroot/chmod.o \
		lib/vroot/chown.o lib/vroot/chroot.o \
		lib/vroot/creat.o lib/vroot/execve.o \
		lib/vroot/lock.o lib/vroot/lstat.o \
		lib/vroot/mkdir.o lib/vroot/mount.o \
		lib/vroot/open.o lib/vroot/readlink.o \
		lib/vroot/report.o lib/vroot/rmdir.o \
		lib/vroot/setenv.o lib/vroot/stat.o \
		lib/vroot/truncate.o lib/vroot/unlink.o \
		lib/vroot/utimes.o lib/vroot/vroot.o

.cc.o:
	${CXX} ${CXXFLAGS} -c -o $@ $<

all: ${OBJS} ${BSDOBJS} ${MKSHOBJS} ${VROOTOBJS}
	${CXX} ${LDFLAGS} -o ${PROG} ${OBJS} ${BSDOBJS} \
		${MKSHOBJS} ${VROOTOBJS} ${LIBS}

install:
	install -c -s -o root -g wheel -m 755 sunmake \
		/usr/local/bin
	install -d -m 755 /usr/local/share/sunmake
	install -c -o root -g wheel -m 444 \
		bin/svr4.make.rules.file \
		/usr/local/share/sunmake/svr4.make.rules
	install -c -o root -g wheel -m 444 \
		bin/make.rules.file \
		/usr/local/share/sunmake/make.rules

clean:
	rm -f ${PROG} ${OBJS} ${BSDOBJS} ${MKSHOBJS} \
		${VROOTOBJS}
