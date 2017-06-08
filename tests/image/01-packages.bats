@test "package 'fluentd' should be present" {
  run which fluentd
  [ $status -eq 0 ]
}
