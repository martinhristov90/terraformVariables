## This reposistory is created with learning purposes for Terraform, focusing on Terraform Variables.

## Purpose :

- It provides a simple example of how to create AWS instance using Terraform and providing the needed parameters using variables.

## How to install terraform : 

- The information about installing terraform can be found on the HashiCorp website 
[here](https://learn.hashicorp.com/terraform/getting-started/install.html)

## What is a Terraform Variable :

- Variable in common meaning are storage containers for a values, which also has identifier (name), which can be used for referring to the variable. This definition is valid also for Terraform variables, to declare a variable, following syntax should be used :

    ```

    variable "VARIABLE_NAME" {

    }

    ```

    This syntax provides only the identifier of a variable, it has no value. Terraform is going to try to get the value by using user's input, it is going to prompt the user when `terraform plan` is initiated. Having variables with no values is good approach to provide sensitive information like AWS keys, since the user is always going to be prompted for the values, instead having the values hard-coded in `.tf` files.

- In order to get the value inside the Terraform code, "interpolation" needs to be used. In mathematical sense "interpolation" means finding out intermediate unknown values of a function by using values that are already known. In Terraform interpolation has the following syntax :

    ```

    var = "${var.VARIABLE_NAME}"

    ```

    This method for providing values is used in the `main.tf` file of this repository. When `terraform plan` is executed, Terraform is going to prompt the user for `var.access_key` and `var.secret_key`. 
    
- There are other methods to provide the values for those variables, for example to use `variables.tf` and `terraform.tfvars` files. The file `variables.tf` is used to define/declare the variables and `terraform.tfvars` to pass the value for variables defined in `variables.tf`. This method is going to be used for providing the `var.region` variable. 
This way the user can have all the variables defined in the `variable.tf` needed for the Terraform code execution,but providing different values based on the environment where the infrastructure is going to be deployed. For exampleUAT/stage/prod, or in the case of `var.region`, setting different region. Take a look at the `terraform.tfvars` it isa key-value pair looking file, the `region` variable is set to `us-east-2`, if this value is not provided the`default` setting from the `variables.tf` is going to be used.
- One additional way is to use environmental variables for setting values of Terraform variables. For example `export TF_VAR_region = "us-east-1` is going to set the variable `region` to value `us-east-1`. This value will be retain until the current session of the shell is running, unless specified in `.bashrc` or `.bash_profile` for your user. 



## How to use it :

- In a directory of your choice, clone the github repository 
    ```
    
    git clone https://github.com/martinhristov90/terraformOutputs.git
    
    ```

- Change into the directory
    ```

    cd terraformOutputs

    ```

- It is good practice to have a separate user that Terraform is going to perform actions with, more information [how to create a user in AWS](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_users.html)

- You are going to be prompted by Terraform to provide your AWS access_key and secret_key.

- Use your favorite text editor to modify the file `main.tf`. Set the following values : 
    - `subnet_id`  - Sets the subnet in which the instance is going to be attaced.
    - `vpc_security_group_ids` - Sets the ID of the security group.
    
- Modify the `terraform.tfvars` to select the desired region.

- After all the values of the variables are set correctly, go ahead and execute `terraform init`. 
The output should look like this :

    ```shell

    --- SNIP ---

    * provider.aws: version = "~> 2.11"

    Terraform has been successfully initialized!

    --- SNIP ---
    
    ```
    
- Now, Terraform has downloaded the AWS provider for you, automatically.
- To preview what is going to happen without actually performing any actions, execute `terraform plan`. You are going to be asked to enter AWS `access_key` and `secret_key`. The output should look like this :

    ```shell
    
    Refreshing Terraform state in-memory prior to plan...
    The refreshed state will be used to calculate this plan, but will not be
    persisted to local or remote state storage.
    
    
    ------------------------------------------------------------------------
    
    An execution plan has been generated and is shown below.
    Resource actions are indicated with the following symbols:
      + create
    
    Terraform will perform the following actions:
    
      + aws_instance.web
          --- SNIP ---
          ami:                               "ami-0444fa3496fb4fab2"
          --- SNIP ---
          get_password_data:                 "false"
          instance_type:                     "t2.micro"
          source_dest_check:                 "true"
          --- SNIP ---
          subnet_id:                         "subnet-2f591701"
          tags.%:                            "2"
          tags.name:                         "MYMACHINE"
          tags.ping:                         "pong"
          vpc_security_group_ids.#:          "1"
          vpc_security_group_ids.2189854857: "sg-3ddbcb64"
    
    
    Plan: 1 to add, 0 to change, 0 to destroy.
    
    ------------------------------------------------------------------------
    
    Note: You didn't specify an "-out" parameter to save this plan, so Terraform
    can't guarantee that exactly these actions will be performed if
    "terraform apply" is subsequently run.
    
    ```
    
- If everything looks good, execute `terraform apply` to actually provision the resources defined in `main.tf`.

- Now you should have a running instance in AWS.

- In order to destroy whatever resources have been created by Terraform, execute `terraform destroy`. 


