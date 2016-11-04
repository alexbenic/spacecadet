#!/usr/bin/env bats

load test_helper

@test "(cli) should print usage with no arguments passed" {
    run /home/beni/Cloud/Projects/spacecadet/spacecadet
    echo "output: "$output
    echo "status: "$status
    IFS=" "
    assert_line  4 "    Utility script to generate/set/unset keybinding in X windows"
}

#@test "(cli) should print missing dependencies" {

#}
