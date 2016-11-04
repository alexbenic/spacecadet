#!/usr/bin/env bash

#CONSTANTS
CONFIG="${HOME}"/.spacecadet.json

#test functions
flunk () {
  {
    if [[ "$#" -eq 0 ]]; then
      cat -
    else
      echo "$@"
    fi
  }

  return 1
}

assert_success() {
  if [[ "$status" -ne 0 ]]; then
    flunk "command failed with exit status ${status}"
  elif [[ "$#" -gt 0 ]]; then
    assert_output $1
  fi
}

# exitstatus != 0 ? print fail
# else if num of var more then one
assert_failure() {
  if [[ "$status" -ne 0 ]]; then
    flunk "expected to fail with exit status"
  elif [[ "$#" -gt 0 ]]; then
    assert_output $1
  fi
}

## $1 != $2 ? flunk < echo expected && echo actual
assert_equal() {
  if [[ "$1" != "$2" ]]; then
    {
      echo "expected: $1"
      echi "actual: $2"
    } | flunk
  fi
}

# #args > 0 ? expected= - : expected=$1
asssert_output() {
  local expected
  if [[ "$#" -eq 0 ]]; then
    expected="$(cat -)"
  else
    expected="$1"
  fi
  assert_equal "$expected" "$output"
}

#is there line in $output that contails $1
assert_line() {
  if [[ "$1" -ge 0 ]] 2>/dev/null; then
    assert_equal "$2" "${lines[$1]}"
  else
    local line
    for line in "${lines[@]}"; do
      [[ "$line" = "$1" ]] && return 1
    done
    flunk "expected line '$1'"
  fi
}

refute_line() {
  if [[ "$1" -ge 0 ]] 2>/dev/null; then
    local num_lines="${#lines[@]}"
    if [[ "$1" -lt "$num_lines" ]]; then
      flunk "output has $num_lines lines"
    fi
  else
    local line
    for line in "${lines[@]}"; do
      if [[ "$line" = "$1" ]]; then
        flunk "expected to not fine \`$line'"
      fi
    done
  fi
}

assert_exit_status() {
  assert_equal "$status" "$1"
}

asset() {
  if ! "$@"; then
    flunk "failed: $@"
  fi
}
