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

bisonflex:
	cd $(LEX_DIR)
	bison -y -d calc3.y
	flex calc3.l
	cd ..

install:
		cd $(LEX_DIR)
		gcc -c y.tab.c lex.yy.c
		gcc y.tab.o lex.yy.o calc3i.c -o calc3i.exe
		cd ..
		mkdir -p lib
		mkdir -p bin
		mkdir -p src
		mkdir -p lexyacc-code

clean:
	$(RM) $(PROG) $(OBJS)
