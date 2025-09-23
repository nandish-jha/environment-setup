#NANDISH JHA NAJ474 11282001
#!/bin/bash
# filepath: /student/naj474/CMPT332/LABS/NAJ474-CMPT332-LAB0/lab0-workshop/runQsort.bash

set -e
clear

# Check arguments
if [ $# -lt 2 ]; then
    echo "Error: Missing arguments"
fi

# Storing the arguments in variables
MODE=$1
FILE=$2

# Validate mode is a number
if ! [[ "$MODE" =~ ^[0-9]+$ ]]; then
    echo "Error: Mode must be a number"
fi

# Check if input file exists
if [ ! -f "$FILE" ]; then
    echo "Error: Input file '$FILE' does not exist"
    exit 1
fi

echo "Running ./myQsort with Mode $MODE and file $FILE..."
./myQsort "$MODE" < "$FILE"