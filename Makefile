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
OBJS = $($(patsubst $(SRC_DIR)/y.tab.c,$(OBJ_DIR)/y.tab.o,$(SRCS))$(patsubst $(SRC_DIR)/lex.yy.c,$(SRC_DIR)/lex.yy.o,$(SRCS))
PROG = ($calc3a.exe,$calc3b.exe,$calc3g.exe,$calc3i.exe)
RM = /bin/rm
#----------------------------------------------------------------------
# Compile code
#----------------------------------------------------------------------
all: install bisonflex $(PROG)

$(PROG): $(OBJS)
	$(LD) $^ -o $(PROG)

$(OBJ_DIR)/%.o: $(SRC_DIR)/%.c
	$(CC) $(FLAGS) -c $< -o $@ #ERROR HÄR

bisonflex: 
	bison -y -d lexyacc-code/calc3.y #
	flex lexyacc-code/calc3.l #

clean:
	$(RM) $(PROG) $(OBJS)

#----------------------------------------------------------------------
# Make directories
#----------------------------------------------------------------------
install:
	mkdir -p .lib
	mkdir -p .bin
	mkdir -p .src
	mkdir -p .lexyacc-code
	if [ bison -V > /dev/null 2>&1 ]; then
		echo"Bison not installed"
	fi
