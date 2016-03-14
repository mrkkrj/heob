
HEOB_VERSION:=1.3-dev-$(shell date +%Y%m%d)

BITS=32
ifeq ($(BITS),32)
  PREF=i686-w64-mingw32-
else ifeq ($(BITS),64)
  PREF=x86_64-w64-mingw32-
else
  PREF=
endif

CC=$(PREF)gcc
CXX=$(PREF)g++
CPPFLAGS=-DNO_DWARFSTACK
CFLAGS=-Wall -Wextra -Wshadow -fno-omit-frame-pointer -fno-optimize-sibling-calls
CFLAGS_HEOB=$(CPPFLAGS) $(CFLAGS) -O3 -DHEOB_VER="\"$(HEOB_VERSION)\"" \
	    -ffreestanding -mno-stack-arg-probe
LDFLAGS_HEOB=-s -nostdlib -lkernel32
CFLAGS_TEST=$(CFLAGS) -O3 -g


all: heob$(BITS).exe allocer$(BITS).exe

heob$(BITS).exe: heob.c heob-inj.c heob.h
	$(CC) $(CFLAGS_HEOB) -o$@ heob.c heob-inj.c $(LDFLAGS_HEOB) || { rm -f $@; exit 1; }

allocer$(BITS).exe: allocer.cpp libcrt$(BITS).a dll-alloc$(BITS).dll dll-alloc-shared$(BITS).dll
	$(CXX) $(CFLAGS_TEST) -o$@ $^ -nostdlib -lmsvcrt -lkernel32

dll-alloc$(BITS).dll: dll-alloc.cpp libcrt$(BITS).a
	$(CXX) $(CFLAGS_TEST) -shared -o$@ $^ -static-libgcc

dll-alloc-shared$(BITS).dll: dll-alloc$(BITS).dll
	cp -f $< $@

libcrt$(BITS).a: crt$(BITS).def
	$(PREF)dlltool -k -d $< -l $@


package: heob-$(HEOB_VERSION).7z

package-src:
	git archive "HEAD^{tree}" |xz >heob-$(HEOB_VERSION).tar.xz

heob-$(HEOB_VERSION).7z: heob32.exe heob64.exe
	7z a -mx=9 $@ $^


.PHONY: force

ifneq ($(BITS),32)
heob32.exe allocer32.exe: force
	$(MAKE) BITS=32 $@
endif
ifneq ($(BITS),64)
heob64.exe allocer64.exe: force
	$(MAKE) BITS=64 $@
endif


T_H01=-p1 -a4 -f0
T_A01=0
T_H02=-p1 -a4 -f0
T_A02=1
T_H03=-p1 -a4 -f0
T_A03=2
T_H04=-p2 -a4 -f0
T_A04=2
T_H05=-p1 -a4 -f0
T_A05=3
T_H06=-p2 -a4 -f0
T_A06=3
T_H07=-p1 -a4 -f0
T_A07=4
T_H08=-p1 -a1 -f0
T_A08=4
T_H09=-p1 -a4 -f0
T_A09=5
T_H10=-p1 -a4 -f0
T_A10=6
T_H11=-p1 -a4 -f1
T_A11=6
T_H12=-p1 -a4 -f0
T_A12=7
T_H13=-p1 -a4 -f0 -m2
T_A13=8
T_H14=-p1 -a4 -f0 -m0
T_A14=8
T_H15=-p1 -a4 -f0 -l0
T_A15=1
T_H16=-p1 -a4 -f0 -d0
T_A16=10
T_H17=-p1 -a4 -f0 -d1
T_A17=10
T_H18=-p1 -a4 -f0 -d2
T_A18=10
T_H19=-p1 -a4 -f0 -e1
T_A19=0
T_H20=-p1 -a4 -f0 -m1
T_A20=8
T_H21=-h0
T_A21=12
T_H22=-h1 -n0
T_A22=12
T_H23=-p1 -a4 -f1
T_A23=7
T_H24=-p1 -a4 -f0 -d3
T_A24=10
T_H25=-p1 -a4 -f0 -r1
T_A25=7
T_H26=-p1 -a4 -f0 -r1
T_A26=5
T_H27=-p1 -a4 -f0 -r0
T_A27=13
T_H28=-p1 -a4 -f1 -r0
T_A28=13
T_H29=-p1 -a4 -f0 -r1
T_A29=13
T_H30=-p1 -a4 -f1 -r1
T_A30=13
T_H31=-p1 -a4 -f0 -M1 -n0
T_A31=14
T_H32=-p1 -a4 -f0 -M5000
T_A32=14
T_H33=-p1 -a8 -f0 -l0
T_A33=15
T_H34=-p1 -a8 -f0 -l1
T_A34=15
T_H35=-p1 -a8 -f0 -l2
T_A35=15
T_H36=-p1 -a8 -f0 -l3
T_A36=15
T_H37=-p1 -a8 -f0 -l4
T_A37=15
T_H38=-p1 -a8 -f0 -l5
T_A38=15
T_H39=-p1 -a4 -f0 -m1 -r2
T_A39=8
T_H40=-p1 -a4 -f0 -M1 -n1
T_A40=14
T_H41=-p1 -a4 -f1 -M1 -n0
T_A41=16
T_H42=-p1 -a4 -f1 -M5000 -n0
T_A42=16
T_H43=-p1 -a4 -f1 -M1 -n1
T_A43=16
T_H44=-p1 -a4 -f0 -L0
T_A44=17
T_H45=-p1 -a4 -f0 -L10
T_A45=17
T_H46=-p1 -a4 -f0 -L100
T_A46=17
T_H47=-p1 -a4 -f0 -L100 -I1
T_A47=18
T_H48=-p1 -a4 -f0 -L100 -I0
T_A48=18
T_H49=-p1 -a4 -f0 -R3 -R5
T_A49=1
T_H50=-p0 -a4 -f0
T_A50=19
T_H51=-p1 -a4 -f0
T_A51=19
T_H52=-p1 -a4 -f0
T_A52=20
T_H53=-p0 -a4 -f0
T_A53=21
T_H54=-p1 -a4 -f0
T_A54=21
TESTS:=$(shell seq -w 01 54)

testres:
	mkdir -p $@

testc: heob$(BITS).exe allocer$(BITS).exe | testres
	@$(foreach t,$(TESTS),echo heob$(BITS) $(T_H$(t)) allocer$(BITS) $(T_A$(t)) "->" test$(BITS)-$(t).txt; ./heob$(BITS).exe $(T_H$(t)) allocer$(BITS) $(T_A$(t)) |sed 's/0x[0-9A-Z]*/0xPTR/g;/^ *0xPTR/d;s/\<of [1-9][0-9]*/of NUM/g;s/^ *\[/    \[/;/^           *[^\[]/d' >testres/test-$(t).txt;)

TOK=[0;32mOK[0m
TFAIL=[0;31mFAIL[0m

test: heob$(BITS).exe allocer$(BITS).exe
	@$(foreach t,$(TESTS),echo test$(BITS)-$(t): heob$(BITS) $(T_H$(t)) allocer$(BITS) $(T_A$(t)) "->" `./heob$(BITS).exe $(T_H$(t)) allocer$(BITS) $(T_A$(t)) |sed 's/0x[0-9A-Z]*/0xPTR/g;/^ *0xPTR/d;s/\<of [1-9][0-9]*/of NUM/g;s/^ *\[/    \[/;/^           *[^\[]/d' |diff - testres/test-$(t).txt >test$(BITS)-$(t).diff && echo "$(TOK)" && rm -f test$(BITS)-$(t).diff || echo "$(TFAIL)"`;)

testsc:
	$(MAKE) BITS=32 testc

tests:
	$(MAKE) BITS=32 test
	$(MAKE) BITS=64 test


clean:
	rm -f *.exe *.a dll-alloc*.dll
