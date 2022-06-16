  variable "db_subnet_group_creation" {
    type = object ({
      create_db_subnet_group = bool
      db_subnet_group_name   = optional(string)
      subnet_ids             = optional(list(string))
      existing_db_subnet_group_name = optional(string)
    })

    default = {
      create_db_subnet_group = false
      existing_db_subnet_group_name = ""
    }

    validation {
      condition = (
        var.db_subnet_group_creation.create_db_subnet_group == true &&
        length(var.db_subnet_group_creation.existing_db_subnet_group_name) > 0
      )

      error_message = "If create_db_subnet_group = true, you can't use existing_db_subnet_group_name variable. Please remove this variable and use db_subnet_group_name and subnet_ids."
    }

    validation {
      condition = (
        var.db_subnet_group_creation.create_db_subnet_group == true &&
        var.db_subnet_group_creation.db_subnet_group_name == "" &&
        var.db_subnet_group_creation.subnet_ids == ""
      )

      error_message = "Varible create_db_subnet_group = true, Please add db_subnet_group_name and subnet_ids as these are required variables."
    }

    validation {
      condition = (
        var.db_subnet_group_creation.create_db_subnet_group == false &&
        var.db_subnet_group_creation.db_subnet_group_name == null &&
        var.db_subnet_group_creation.subnet_ids == null
      )

      error_message = "Varible create_db_subnet_group = false, Please remove db_subnet_group_name and subnet_ids as these variable are not compatible."
    }

    validation {
      condition = (
        var.db_subnet_group_creation.create_db_subnet_group == false &&
        var.db_subnet_group_creation.existing_db_subnet_group_name != null
      )

      error_message = "Varible 'create_db_subnet_group = false', Please add 'existing_db_subnet_group_name' as this is required variable."
    }

    validation {
      condition = (
        var.db_subnet_group_creation.create_db_subnet_group == false &&
        var.db_subnet_group_creation.existing_db_subnet_group_name != ""
      )

      error_message = "Varible 'create_db_subnet_group = false', Please define 'existing_db_subnet_group_name' as this variable can't be empty."
    }
  }


https://dev.to/drewmullen/terraform-variable-validation-with-samples-1ank