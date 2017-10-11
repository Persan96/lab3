#-------****
# Variables
#-------****
MKDIR_P = mkdir -p
CC = gcc
LD = gcc
LIB_DIR = lib
OBJ_DIR = bin
SRC_DIR = src
LEX_DIR = lexyacc-code
FLAGS = -I$(LIB_DIR)
SRCS = $(wildcard $(SRC_DIR)/*.c,$(LEX_DIR)/*.c)
OBJS = $($(patsubst $(SRC_DIR)/y.tab.c,$(OBJ_DIR)/y.tab.o,$(SRCS))$(patsubst $(SRC_DIR)/lex.yy.c,$(SRC_DIR)/lex.yy.o,$(SRCS)))
COMP = calc3i.exe
RM = /bin/rm
#----------------------------------------------------------------------
# Compile code
#----------------------------------------------------------------------
all: install bisonflex

# Enter library for lexyacc-code
bisonflex:
	cd $(LEX_DIR); \
	bison -y -d calc3.y; \
	flex calc3.l;

# Enter library for lexyacc-code
install:
		cd $(LEX_DIR); \
		gcc -c y.tab.c lex.yy.c; \
		gcc y.tab.o lex.yy.o calc3i.c -o ../bin/calc3i.exe; 

clean:
	$(RM) $(PROG) $(OBJS)
