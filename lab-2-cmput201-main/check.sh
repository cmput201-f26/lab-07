#!/usr/bin/env bash
declare -r src="$1"

declare -ar test_cases=(\
  "1 2"             "2"
  "3 4 1 3"         "1 3 4"
  "0"               ""
  "2 4 4"           "4 4"
)

if [[ -z "$src" ]]; then
  echo "Please provide a file to compile."
  echo "Example usage: \`bash check.sh main.c\`"
  exit 1
fi

if ! gcc -std=c99 -Wall -Wextra -Werror "$src"; then
  echo "Your program failed to compile without errors"
  exit 1
fi

declare -r tmp_student="$(mktemp)"
declare -r tmp_expected="$(mktemp)"

# The following loop actually tests the program
for ((i=0; i < ${#test_cases[@]}; i+=2)); do
  args=(${test_cases[i]})  # Here we convert each string like "1 2 3" into an array like [1, 2, 3]

  echo "${test_cases[i+1]}" > "$tmp_expected"  # This is the output we want

  # The below runs the compiled program using the array as arguments. It saves
  # the output in the variable student_output and silences the debug output.
  ./a.out "${args[@]}" 2>/dev/null > "$tmp_student"

  if ! diff "$tmp_student" "$tmp_expected"; then
    echo "Student output does not match expected output for input: $args"
    rm "$tmp_student" "$tmp_expected"
    exit 2
  fi
done

echo "Your program passed! Remember to push it to Github before the deadline."
rm "$tmp_student" "$tmp_expected"
