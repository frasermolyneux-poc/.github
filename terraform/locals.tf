locals {
  json_files = [for f in fileset("projects", "*.json") : jsondecode(file("projects/${f}"))]

  projects = [for content in local.json_files : {
    name = content.name
    github = lookup(content, "github", null) != null ? {
      name          = content.name
      description   = content.description
      visibility    = lookup(content.github, "visibility", "public")
      topics        = lookup(content.github, "topics", [])
      has_downloads = lookup(content.github, "has_downloads", false)
      has_issues    = lookup(content.github, "has_issues", false)
      has_projects  = lookup(content.github, "has_projects", false)
      has_wiki      = lookup(content.github, "has_wiki", false)
      is_template   = lookup(content.github, "is_template", false),
      template = lookup(content.github, "template", null) != null ? {
        owner      = lookup(content.github.template, "owner", null)
        repository = lookup(content.github.template, "repository", null)
      } : null
    } : null,
    environments = [for environment in lookup(content, "environments", []) : {
      name                      = environment.name,
      configure_terraform_state = lookup(environment, "configure_terraform_state", false),
      vnet_spoke = lookup(environment, "vnet_spoke", null) != null ? {
        address_space = environment.vnet_spoke.address_space
      } : null
    }]
  }]

  project_environments = flatten([
    for project in local.projects : [
      for environment in project.environments : {
        key                       = format("%s-%s", project.name, environment.name)
        project                   = project.name
        environment               = environment.name
        configure_terraform_state = environment.configure_terraform_state
        vnet_spoke                = environment.vnet_spoke
      }
    ]
  ])
}
