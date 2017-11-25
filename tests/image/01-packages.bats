#!/usr/bin/env bats

@test "ruby version is 2.3" {
  run sh -c "ruby --version | cut -d ' ' -f 2"
  [ "$status" -eq 0 ]

  major=$(echo "$output" | cut -d '.' -f 1)
  minor=$(echo "$output" | cut -d '.' -f 2)
  [ "$major" -eq "2" ]
  [ "$minor" -eq "3" ]
}


@test "fluentd is installed" {
  run which fluentd
  [ "$status" -eq 0 ]
}

@test "fluentd runs ok" {
  run fluentd --help
  [ "$status" -eq 0 ]
}

@test "fluentd has correct version" {
  run fluentd --version
  [ "$status" -eq 0 ]
  actual=$(echo "$output" | cut -d ' ' -f 2 | tr -d " \n")
  expected="$FLUENTD_VERSION"

  [ "$actual" == "$expected" ]
}


@test "gem 'oj' is installed " {
  run sh -c "gem list --local oj | grep -e '^oj '"
  [ "$status" -eq 0 ]
}

@test "gem 'json' is installed " {
  run sh -c "gem list --local json | grep -e '^json '"
  [ "$status" -eq 0 ]
}