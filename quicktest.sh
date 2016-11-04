#!/usr/bin/env bash

flunk() {
  {
    if [[ "$#" -eq 0 ]]; then
      cat -
    else
      echo "$@"
    fi
  } | flunk
  return 1
}

flunk "$@"
