# terraform validate
The terraform validate command validates the configuration files in a directory whether a configuration is syntactically valid and internally consistent, regardless of any provided variables or existing state.

Validation requires an initialized working

terraform init -backend=false
  - skip backend initialization

# terraform import
- You must update your terraform configuration for the imported resource before attempting to import the resource.
- 

# terraform console
provides an interactive command-line console for evaluating and experimenting with expressions.

# Multi-Cloud Deployment

* state locking is supported to reduce the chance of corrupting the state file. What backends support state locking ?
- S3 with DynamoDB
- Kubernetes
- Consul

* You have decided to move your state file to an Amazon S3 remote backend. You configure Terraform with the proper configuration. What command should be run in order to complete the state migration?
  - terraform init -reconfigure

* You need Terraform to destroy and recreate a single database server that was deployed with a bunch of other resources. You don't want to modify the Terraform code. What command can be used to accomplish this task?
  - terraform apply -replace="aws_instance.database"

* You have deployed your network architecture in AWS using Terraform. A colleague recently logged in to the AWS console and made a change manually and now you need to be sure your Terraform state reflects the new change. What command should you run to update your Terraform state?
  - terraform apply -refresh-only https://learn.hashicorp.com/tutorials/terraform/refresh

* You have a module named prod_subnet that outputs the subnet_id of the subnet created by the module. How would you reference the subnet ID when using it for an input of another module?
  - subnet = module.prod_subnet.subnet_id
Using interpolation, you can reference the output of an exported value by using the following syntax: module.<module name>.<output name>
Don't forget that before you can reference data/values from a module, the module has to have an output declared that references the desired value(s)

* You are using Terraform to manage some of your AWS infrastructure. You notice that a new version of the provider now includes additional functionality you want to take advantage of. What command do you need to run to upgrade the provider?
  - terraform init -upgrade

* The command terraform destroy is actually just an alias to which command?
  - terraform apply -destroy 

* What two options are available to delete all of your managed infrastructure? (select two)
  - terraform destroy
  - terraform apply -destroy 

* Where is the most secure place to store credentials when using a remote backend?
  - Outside terraform

* True or False? Input variables that are marked as sensitive are NOT written to Terraform state.
  - FALSE

* You are managing multiple resources using Terraform running in AWS. You want to destroy all the resources except for a single web server. How can you accomplish this?
  - run terraform state rm to remove it from state file and then destroy the remaining resources using terraform destroy

* As you are developing new Terraform code, you are finding that you are constantly repeating the same expression over and over throughout your code, and you are worried about the effort that will be needed if this expression needs to be changed. What feature of Terraform can you use to avoid repetition and make your code easier to maintain?
  - locals {}

* True or False? When you are referencing a module, you must specify the version of the module in the calling module block.
  - False, While it's not required, we recommend explicitly constraining the acceptable version numbers to avoid unexpected or unwanted changes. Use the version argument in the module block to specify versions.

* When using Sentinel policies to define and enforce policies, it (Sentinel) runs after a terraform plan, but before a terraform apply. Therefore, you can potentially reduce costs on public cloud resources by NOT deploying resources that do NOT conform to policies enforced by Sentinel. For example, without Sentinel, your dev group might deploy instances that are too large, or too many of them, by accident or just because they can. Rather than being REACTIVE and shutting them down after they have been deployed, which it would cost you $, you can use Sentinel to prevent those large resources from being deployed in the first place.


* True or False? A provider block is required in every configuration file so Terraform can download the proper plugin.
  - False, You don't have to specify a provider block since Terraform is smart enough to download the right provider based on the specified resources. That said, Terraform official documentation states that Terraform configurations must declare which providers they require so that Terraform can install and use them. Although Terraform CAN be used without declaring a plugin, you should follow best practices and declare it along with the required_version argument to explicitly set the version constraint.

* True or False? In order to use the terraform console command, the CLI must be able to lock state to prevent changes.
  - TRUE, The terraform console command will read the Terraform configuration in the current working directory and the Terraform state file from the configured backend so that interpolations can be tested against both the values in the configuration and the state file.
    When you execute a terraform console command, you'll get this output:
    $ terraform console
    Acquiring state lock. This may take a few moments...
  
* During a terraform apply, a resource is successfully created but eventually fails during provisioning. What happens to the resource?
  - the resource is marked as tainted

* True or False? When using the Terraform provider for Vault, the tight integration between these HashiCorp tools provides the ability to mask secrets in the terraform plan and state files.
  - False

* Functions lookup, index, 

* When using providers that require the retrieval of data, such as the HashiCorp Vault provider, in what phase does Terraform actually retrieve the data required, assuming you are following the standard workflow of write, plan, and apply?
  - terraform plan ?

* In Terraform, most resource dependencies are handled automatically. Which of the following statements describes best how Terraform resource dependencies are handled?  
  - Terraform analyzes any expressions within a resource block to find references to other objects and treats those references as implicit ordering requirements when creating, updating, or destroying resources.

* Where plugins providers are downloaded and stored on the server ?
  - .terraform/providers

* Where does Terraform OSS store the local state for workspaces?
  - directory called terraform.tfstate.d

test
