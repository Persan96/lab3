#-------****
# Variables
#-------****
CC = gcc
LD = gcc
LIB_DIR = lib
BIN_DIR = bin
SRC_DIR = src
LEX_DIR = lexyacc-code
COMP = calc3i.exe
RM = /bin/rm
#----------------------------------------------------------------------
# Compile code
#----------------------------------------------------------------------
all: compiler library

# Fix compiler
compiler: bisonflex
		cd $(LEX_DIR); \
		gcc -c y.tab.c lex.yy.c; \
		gcc y.tab.o lex.yy.o calc3i.c -o ../$(BIN_DIR)/$(COMP);

# Fix bison and flex
bisonflex:
			cd $(LEX_DIR); \
			bison -y -d calc3.y; \
			flex calc3.l;

# Fix library
library:
		mkdir -p $(LIB_DIR); \
		cd $(SRC_DIR); \
		$(CC) -c instructions.s -o ../$(LIB_DIR)/instructions.o;

# Clean up
clean:
	$(RM) $(LEX_DIR)/lex.yy.o $(LEX_DIR)/y.tab.o $(BIN_DIR)/$(COMP) $(LIB_DIR)/instructions.o
