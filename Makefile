#----------------------------------------------------------------------
# Make directories
#----------------------------------------------------------------------
OBJS = $(src, bin, lib, lexyacc-code)
mkdir -p $(OBJS)
mkdir -p src/ofiles

#----------------------------------------------------------------------
# Compile code
#----------------------------------------------------------------------
bison -y -d src/calc3.y #
flex src/calc3.l #
gcc -c src/y.tab.c src/lex.yy.c
mv src/y.tab.o bin/y.tab.o 
mv src/lex.yy.o bin/lex.yy.o
gcc src/ofiles/y.tab.o src/lex.yy.o src/calc3a.c -o bin/calc3a.exe #
gcc src/ofiles/y.tab.o src/lex.yy.o src/calc3b.c -o bin/calc3b.exe #
gcc src/ofiles/y.tab.o src/lex.yy.o src/calc3g.c -o bin/calc3g.exe #
gcc src/ofiles/y.tab.o src/lex.yy.o src/calc3i.c -o bin/calc3i.exe #
