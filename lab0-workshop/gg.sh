#!/bin/bash
#
# CMPT 332 pre-submit audit script
# Run this in the ROOT of the handin directory before you create your tar.
# Usage: bash verify_submit.sh
#
# This script will:
#  - check max line length (<=80)
#  - check for Windows CRLF (\r)
#  - check group-read permission
#  - show which files will cause mark deductions
#
# Exit code:
#   0 = clean
#   1 = issues found

clear

RED="$(printf '\033[31m')"
GRN="$(printf '\033[32m')"
YEL="$(printf '\033[33m')"
RST="$(printf '\033[0m')"

echo "===== CMPT 332 Submission Audit ====="

# You can tweak which files are considered “source”
SOURCE_FILES=$(find . \
    -type f \
    \( -name "*.c" -o -name "*.h" -o -name "Makefile" -o -name "*.mk" -o -name "*.txt" -o -name "*.md" \) \
    ! -path "*/.git/*" \
)

ISSUES=0

########################################
# 1. Check for lines > 80 columns
########################################
echo
echo ">> Checking line length ( >80 chars )..."
LONG_LINES_FOUND=0
while IFS= read -r file; do
    # grep: show any line with length 81 or more
    # -n for line numbers
    bad=$(grep -nH '.\{81\}' "$file")
    if [ -n "$bad" ]; then
        LONG_LINES_FOUND=1
        ISSUES=1
        echo "${RED}[FAIL]${RST} $file has lines over 80 chars:"
        echo "$bad" | sed "s/^/       /"
    fi
done <<< "$SOURCE_FILES"

if [ $LONG_LINES_FOUND -eq 0 ]; then
    echo "${GRN}[OK]${RST} No lines exceed 80 characters."
fi


########################################
# 2. Check for CRLF line endings
########################################
echo
echo ">> Checking for Windows CRLF line endings (\\r)..."
CRLF_FOUND=0
while IFS= read -r file; do
    if grep -Iq . "$file"; then
        if grep -q $'\r' "$file"; then
            CRLF_FOUND=1
            ISSUES=1
            echo "${RED}[FAIL]${RST} $file contains CRLF line endings (\\r)."
            echo "       Run: dos2unix \"$file\""
        fi
    fi
done <<< "$SOURCE_FILES"

if [ $CRLF_FOUND -eq 0 ]; then
    echo "${GRN}[OK]${RST} No CRLF line endings found."
fi


########################################
# 3. Check group read permission (g+r)
########################################
echo
echo ">> Checking file permissions (group-readable g+r)..."
PERM_ISSUES=0
while IFS= read -r f; do
    # skip directories
    [ -d "$f" ] && continue

    # get octal perms, e.g. 640
    # cut to just the last 3 digits
    perms=$(stat -c "%a" "$f" 2>/dev/null | tail -c 4)
    # isolate group bits (middle digit)
    groupperm=$(echo "$perms" | sed 's/^\(.\)\(.\)\(.\)$/\2/')

    # group read bit is value 4, so allowed group perms are 4,5,6,7
    case "$groupperm" in
        4|5|6|7)
            # ok
            ;;
        *)
            PERM_ISSUES=1
            ISSUES=1
            echo "${RED}[FAIL]${RST} $f is not group-readable (perms = $perms)"
            echo "       Fix with: chmod g+r \"$f\""
            ;;
    esac
done < <(find . -type f ! -path "*/.git/*")

if [ $PERM_ISSUES -eq 0 ]; then
    echo "${GRN}[OK]${RST} All files are group-readable (g+r)."
fi


########################################
# 4. Optional auto-fix (permissions only)
########################################
if [ $PERM_ISSUES -eq 1 ]; then
    echo
    echo "${YEL}Would you like me to run 'chmod -R g+r .' for you? (y/n)${RST}"
    read ans
    if [ "$ans" = "y" ] || [ "$ans" = "Y" ]; then
        chmod -R g+r .
        if [ $? -eq 0 ]; then
            echo "${GRN}[FIXED]${RST} Group read bit added recursively."
        else
            echo "${RED}[ERR]${RST} chmod failed. You may need to run manually."
        fi
    else
        echo "Skipping auto-fix."
    fi
fi


########################################
# 5. Summary / exit code
########################################
echo
if [ $ISSUES -eq 0 ]; then
    echo "${GRN}All checks passed. You are submission-safe.${RST} ✅"
    exit 0
else
    echo "${RED}Some checks FAILED.${RST} Fix them before you tar/submit."
    echo "If you submit with these issues, marks may be deducted."
    exit 1
fi
