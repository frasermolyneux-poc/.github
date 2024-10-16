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

  dynamic "template" {
    for_each = each.value.github.template != null ? [each.value.github.template] : []

    content {
      owner      = template.value["owner"]
      repository = template.value["repository"]
    }
  }
}

resource "github_repository_ruleset" "main_protection" {
  for_each = { for each in local.projects : each.name => each if each.github != null }

  name       = "main"
  repository = github_repository.repository[each.value.name].name

  target      = "branch"
  enforcement = "active"

  conditions {
    ref_name {
      include = ["~ALL"]
      exclude = []
    }
  }

  rules {
    creation                = true
    update                  = true
    deletion                = true
    required_linear_history = true
    required_signatures     = true

    required_status_checks {
      required_check {
        context        = "terraform-plan-poc"
        integration_id = 1
      }

      strict_required_status_checks_policy = true
    }
  }
}
