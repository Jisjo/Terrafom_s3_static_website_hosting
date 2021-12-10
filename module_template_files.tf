
module "template_files" {
  source = "hashicorp/dir/template"

  base_dir = "${var.path_to_site}"
  
}

#https://registry.terraform.io/modules/hashicorp/dir/template/latest