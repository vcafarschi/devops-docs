  ### DB subnet group
  create_db_subnet_group = false
  existing_db_subnet_group_name = aurora-postgresql11


  Or use
  create_db_subnet_group = true
  db_subnet_group_name   = "aurora-postgre"
  subnet_ids             = ["subnet-0cc7d3b7c3a07f6cd","subnet-08688bfb750aede73","subnet-0b71d9c27106e9d6a"]

In case you specify an unexisting subnet group, tf will create the default one in the default VPC which might be not what you are expecting.


Use case 1:
create_instance_db_parameter_group = false
allow_major_version_upgrade        = false