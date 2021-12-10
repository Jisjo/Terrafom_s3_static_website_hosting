# Hosting a Secure Static Website on AWS S3 using Terraform
[![Builds](https://travis-ci.org/joemccann/dillinger.svg?branch=master)](https://travis-ci.org/joemccann/dillinger)


Terraform is a tool for building infrastructure with a variety of technologies, including Amazon AWS, Microsoft Azure, Google Cloud and vSphere. Here is a simple document on how to use Teraform to make s3-static-website.

![s3 bucket diagram](https://github.com/Jisjo/Terrafom_s3_static_website_hosting/raw/main/s3.png)

----
## Prerequisites

- [AWS Access Key and Secret Key](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_users_create.html)
- [Install Terraform](https://learn.hashicorp.com/tutorials/terraform/install-cli?in=terraform/aws-get-started)
- [Install Git](https://github.com/git-guides/install-git)

## Usage

- Clone the code from the git

```hcl
git clone https://github.com/Jisjo/Terrafom_s3_static_website_hosting.git
cd Terraform-s3-static-website
terraform init
terraform apply
```
----

> Note: Update the region, AWS access key, secret key in the provider.tf file, s3 bucket name, and the location of the website files in the variables.tf file.


Here I'm using [Terraform Template Directory Module](https://registry.terraform.io/modules/hashicorp/dir/template/latest) to gathers all of the files under a particular base directory and [for_each](https://www.terraform.io/docs/language/meta-arguments/for_each.html)to uploading files to Amazon S3.

```hcl
module "template_files" {
  source = "hashicorp/dir/template"

  base_dir = "${var.websiteFiles}"
  
}

#uploading mutiple files using module templete file


resource "aws_s3_bucket_object" "static_files" {
  for_each = module.template_files.files
  bucket       = aws_s3_bucket.my_bucket.id
  key          = each.key
  content_type = each.value.content_type
  source  = each.value.source_path
  content = each.value.content
  etag = each.value.digests.md5
}

```


Alternatively, you can use the awscli commands with null_resource provisioner.

```hcl
resource "null_resource" "upload_to_s3" {
  provisioner "local-exec" {
    command = "aws s3 sync ${var.websiteFiles} s3://${aws_s3_bucket.bucket.id}"
  }
}
```

#### ⚙️ Connect with Me

<p align="center">
<a href="mailto:jisjo@hotmail.com"><img src="https://img.shields.io/badge/Gmail-D14836?style=for-the-badge&logo=gmail&logoColor=white"/></a>
<a href=" www.linkedin.com/in/jisjo"><img src="https://img.shields.io/badge/LinkedIn-0077B5?style=for-the-badge&logo=linkedin&logoColor=white"/></a> 
<a href="https://wa.me/%2B918893399806?text=This%20message%20from%20GitHub."><img src="https://img.shields.io/badge/WhatsApp-25D366?style=for-the-badge&logo=whatsapp&logoColor=white"/></a>



