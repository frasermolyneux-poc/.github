resource "github_repository" "repository" {
  for_each = { for each in local.projects : each.name => each if each.github != null }

  name        = each.value.github.name
  description = each.value.github.description
  topics      = each.value.github.topics

  visibility = each.value.github.visibility

  has_downloads = each.value.github.has_downloads
  has_issues    = each.value.github.has_issues
  has_projects  = each.value.github.has_projects
  has_wiki      = each.value.github.has_wiki

  vulnerability_alerts = true

  allow_auto_merge       = true
  delete_branch_on_merge = true

  is_template = each.value.github.is_template
}
