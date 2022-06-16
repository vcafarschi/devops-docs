What is IAC ?
Infrastructure as Code (IaC) is the managing and provisioning of infrastructure through code instead of through manual processes.

IAC benefits:
  - Speed: infrastructure gets deployed faseter as a computer can execute code faster than a person who does all actions manually. When someone says about speed it seems like you can make errors but not in that case, look at safety.
  - Safety :
          - first aspect () : automation removes the risk associated with human error, like manual misconfiguration; removing this can decrease downtime and increase reliability.
          - second aspect (review): you can write some wrong code and this will lead to misconfiguration as well, but when your infrastructure deployment is represented as code, it can be reviewed by other team members.
          - third (tests) : even if team members approved your changes, you can run some tests to make sure the infrastructure gets created properly.
  - consistency, everytime you run the code you will get as a result the things your wrote in your code and nothing more.
  - Reuse, you can take your code, change the environment type from dev to stage and run the code, and you get it.
  - Version

  much faster than manually clicking in the console
  self-service
  standardize deployment workflow

Multi-Cloud Deployment

# Terraform

What is the best way to version and develop modules ?
  1. TO have a separate repository for every module (1 module = 1 repository) ?
  2. TO have one repository and multiple modules in it ?

Mono-repo:
  Advantages:
    Complete view of the entire system
    Painless modules-Wide Refactorings
  Disadvantages:
    Repo grows big over time
    Requires Download of Entire Codebase
    Unmodified Libraries May Be Newly Versioned


Multi-repo:
  Advantages:
    Each module Can Be Versioned Separately
    Security per repo
    Pipeline per repo- makes it fast
  Disadvantages:
      Painfull modules-Wide Refactorings


Gradually you can break that monorepo down into a bunch of smaller repositories that could be managed by different individuals, or different teams.
If your team is small, it's recommended to avoid decoupling the infrastructure code into multiple repositories and consider using modules within your existing repositories. A single module on a single repository is an ideal code structure, but this may fit only large teams

A repository for your Terraform module (or perhaps you want to have multiple modules in the same repository).
A pipeline running Terratest code validating your Terraform module in an isolated environment (e.g. a seperate AWS account).
Also validation and security scans with e.g. TfSec and TfLint.


When to deploy terraform code locally ?
  1. When this is a POC and the company just starts using TF.

When NOT to deploy terraform code locally ?
  1. When you have more than one person that wants to use / develop TF code, cos you will need
    - SHARED STORAGE FOR STATE FILES
    - After solving the issue with shared storage for State Files, you will need to somehow prevent concurrent updating of STATE FILES, which can lead to state file corruption, data loss.
  2. When yo want to be have visibility of changes ( be sure who and what changes has made to infrastructure )

What issues you can meet when you have CI implemented for Terraform ?
1. imagine a situation where two operators open a pull request within several seconds of one another. 
  The pipeline gets triggered immediately for both, and one pull request will be marked as successful, while the other will be marked as failed.
  (This situation will definitely happen if you are using state locking.)


Occasionally, Terraform will fail to save state after running terraform apply. For example, if you lose internet connectivity partway through an apply, not only
“will the apply fail, but Terraform won’t be able to write the updated state file to your remote backend (e.g., to Amazon S3). In these cases, Terraform will save the state file on disk in a file called errored.tfstate. Make sure that your CI server does not delete these files (e.g., as part of cleaing up the workspace after a build)! If you can still access this file after a failed deployment, as soon as internet connectivity is restored, you can push this file to your remote backend (e.g., to S3) using the state push command so that the state information isn’t lost:”

Modules:

A module intended to be called by one or more other modules must not contain any provider blocks

Providers can be passed down to descendent(child) modules in two ways: 
  - implicitly through inheritance
  - explicitly via the providers argument within a module block


Disadvantages of containing provider configuration inside child module
  - NOT compatible with the for_each, count, and depends_on meta-arguemnts in root module

Provider configurations are used for all operations on associated resources, including destroying remote objects and refreshing state. Terraform as part of its state retains a reference to the provider configuration that was used to apply changes to each resource. When a resource block is removed from the configuration, this record in the state will be used to locate the appropriate configuration because the resource's provider argument (if any) will no longer be present in the configuration.

As a consequence, you must ensure that all resources that belong to a particular provider configuration are destroyed before you can remove that provider configuration's block from your configuration. If Terraform finds a resource instance tracked in the state whose provider configuration block is no longer available then it will return an error during planning, prompting you to reintroduce the provider configuration.

Although provider configurations are shared between modules, each module must declare its own provider requirements, so that Terraform can ensure that there is a single version of the provider that is compatible with all modules in the configuration

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 2.7.0"
    }
  } 
}


1. Supose you have your terraform in your local/cloud and you can communicate only with aws. How do you do terraform init?
terraform init does 3 things: 
  1.1 downloads modules 
  1.2 downloads configuration provider
  1.3 configures backend

  1.1 So to download modules from github, i suppose that there is Github Enterprise installed on an Ec2 instance and you can get modules from there.

  1.2 Usually Terraform downloads configuration provider plugins from hashicorp, but you can change it's behaviour by using use a config file terraformrc.
    - Install confir provider pluign on s3 as a zip.
    - install them from S3 using network_mirror .
    - Or Using CI/CD tool download config provider plugins from S3 and use filesystem_mirror or plugin_cache_dir.

  1.3 For backend configuration you need yo have permissions to list, get and update the bucket in case you are using S3 and permissions over DynamoDB for state locking.

2. Supose you have a state and zipped terraform plugins in an s3 bucket. How do you move those in another bucket and change the remote backend.
  2.1 change it's path in backend configuration of you terraform live code
  2.2 run terraform init (which will copy your backend to new path in your bucket)

3. Supose you want to have a ec2 with nginx installed. How do you do that with terraform?
  1. Use user_data
  2. Create an ami an reuse it

4. How to set up a custom ec2 image . How do you handle aws ami using terraform?
  - 

5. How do you structure your terraform repositories and why?
  - Every env like dev, stage, prod should have it's separate directory.
  - Each env folder should be separated to global resources (like s3), datastore (RDS), compute (ec2), and depending on the case the structure can be different

6. Explain workspaces, dynamic blocks, data blocks and examples where and why you used them.
  - Workspaces can be used in case you want to 
  - Dynamic blocks are used to create multiple inline resources like routes, ingress / egress and so no. But it's better to avoid them and use separate resources like aws_security_group_rule.
  - Data blocks are used to get the information about resources like AZ, AMI and so on.

7. Have you worked with terragrunt. Link -> https://terragrunt.gruntwork.io/