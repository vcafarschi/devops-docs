# How to manage multiple environments with Terraform

- Separated Directories
- Workspaces
- Branches
- Terragrunt


## Separated Directories Method 1

![](tf-layout1.png)

- we duplicate the same infrastructure in each folder with different values in the terraform.tfvars file
- this is not ideal when you have the same infrastructure in all environments.
- each folder represents a separate environment and you can have a backend in each folder as well and there is nothing common between these folders
- when you are running terraform commands you have to navigate to the respective folder and run the three commands init, plan and apply


Pros
- You can easily add or remove resources in each environment
- Changes in one environment don’t affect other environments

Cons
- Duplication of code
- If you want to change the resource you have to change it in all environments.


## Separated Directories Method 2

![](tf-layout2.png)

- In this method, we maintain the same infrastructure in common files but have different terraform.tfvars in each environment.
- This is not ideal when you have the different infrastructure in all environments.
- Since we are maintaining the same main.tf, variables.tf files, when you are running terraform commands you need to pass different variables based on the environment
```
// Dev Environment
terraform plan --var-file="tfvars/environment/dev.tfvars"
// QA Environment
terraform plan --var-file="tfvars/environment/qa.tfvars"
// Prod Environment
terraform plan --var-file="tfvars/environment/prod.tfvars"
 ```

Pros
- there is no duplication of code
- If you want to change the resource you don’t have to change in all the environments.

Cons
- You can’t easily add or remove resources in each environment
- Changes in one environment do affect other environments since we are using the same files with different var files.



## terragrunt

