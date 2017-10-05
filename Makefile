#-------****
# Variables
#-------****
CC = gcc
LD = gcc
LIB_DIR = lib
OBJ_DIR = bin
SRC_DIR = src
LEX_DIR = lexyacc-code
FLAGS = -I$(LIB_DIR)
SRCS = $(wildcard $(SRC_DIR)/*.c,$(LEX_DIR)/*.c)
OBJS = $($(patsubst $(SRC_DIR)/y.tab.c,$(OBJ_DIR)/y.tab.o,$(SRCS))$(patsubst $(SRC_DIR)/lex.yy.c,$(SRC_DIR)/lex.yy.o),$(SRCS))
PROG = (calc3a.exe,calc3b.exe,calc3g.exe,calc3i.exe)
RM = /bin/rm
#----------------------------------------------------------------------
# Make directories
#----------------------------------------------------------------------
mkdir -p $($(LIB_DIR),$(OBJ_DIR),$(SRC_DIR),$(LEX_DIR))

#----------------------------------------------------------------------
# Compile code
#----------------------------------------------------------------------
bison -y -d src/calc3.y #
flex src/calc3.l #

all: $(PROG)

$(PROG): $(OBJS)
	$(LD) $^ -o $(PROG)

$(OBJ_DIR)/%.o: $(SRC_DIR)/%.c
	$(CC) $(FLAGS) -c $< -o $@

clean:
	$(RM) $(PROG) $(OBJS)


