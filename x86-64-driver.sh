
#!/bin/sh

# Script that takes a file (ending with .calc)as input
# and produces runnable code

USAGE="Usage: $0 fileName.calc"
FILE_ENDING=".calc"
FILE_NAME=""
BIN_FOLDER="bin"
LIB_FOLDER="lib"
COMPILER="calc3i.exe"

ASSEMBLY_START=".data\n"
for x in {a..z}; do
  ASSEMBLY_START+="\t${x}:\t.quad 0\n"
done
ASSEMBLY_START+="\n.text\n.global main\nmain:\n\tpushq\t\$0"
ASSEMBLY_END="\tpopq\t%rax\n\tret\n"

# Check for right amount of parameters
if [ $# -ne 1 ]; then
  echo -e "ERROR: Invalid number of parameters!\n${USAGE}"
  exit 1
fi

# Check if file ends with calc
if [[ $1 != *${FILE_ENDING} ]]; then
  echo -e "ERROR: Invalid file type!\n${USAGE}"
  exit 1
fi

# Check if the file exists
if [ ! -f $1 ]; then
  echo -e "ERROR: File: \"$1\" does not exist!"
  exit 1
fi

# Get file name without the ending
FILE_NAME=${1%%${FILE_ENDING}}
# Print begining part into the assembly file
echo -e ${ASSEMBLY_START} > ${FILE_NAME}.s
# Compile into assembly and append it into the assembly file
cat $1 | ./${BIN_FOLDER}/${COMPILER} >> ${FILE_NAME}.s
# Append end part into the assembly file
echo -e ${ASSEMBLY_END} >> ${FILE_NAME}.s
# Compile with instructions
gcc ${FILE_NAME}.s ${LIB_FOLDER}/instructions.o -o ${FILE_NAME}
