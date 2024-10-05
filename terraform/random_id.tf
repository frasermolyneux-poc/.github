resource "random_id" "environment" {
  for_each = { for each in local.project_environments : each.key => each }

  byte_length = 6
}
