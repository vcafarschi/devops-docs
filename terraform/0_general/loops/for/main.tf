# map
variable "iam-policy-users-map" {
  type = map(list(string))
  default = {
    "policy1" = [ "user1" ]
    "policy2" = [ "user1", "user2" ]
  }
}


locals {

    vlad_v1 = [
    for policy, users in var.iam-policy-users-map : [
      for user in users: {
        policy = policy
        user   = user
      }
    ]
  ]


  vlad_v2 = flatten([
    for policy, users in var.iam-policy-users-map : [
      for user in users: {
        policy = policy
        user   = user
      }
    ]
  ])

}





# variable "smth" {
#   type = map(object({}))
#   default = {
#     key1 = {
#       key1 = value1
#       key2 = value2
#       key3 = value3
#     },
#     key2 = {
#       key1 = value1
#       key2 = value2
#       key3 = value3
#     }
#   }
# }

# variable "smth2" {
#   type = list(object({}))
# }

# ########################
# locals {

#   records_list = flatten([
#     for domain, zone in var.public_zones: [
#       for k, v in zone.records: {
#         domain=domain
#         subdomain=v.subdomain
#         type=v.type
#         ttl=v.ttl
#         records=v.records
#       }
#     ]
#   ])

#   public_records_map = {
#     for value in var.public_records: "${value.subdomain}.${value.domain}" => value
#   }

#   cloud_front_records_map = {
#     for value in var.cloudfront_records: "${value.subdomain}.${value.domain}" => value
#   }

# }


# resource "aws_route53_zone" "multi_public" {
#   for_each = {
#     for domain, zone in var.public_zones:
#     domain => zone
#   }

#   name          = "${trimsuffix(each.value.domain_name, ".")}."
#   comment       = lookup(each.value, "comment", null)
#   force_destroy = false
# }

# resource "aws_route53_record" "multi_inside_hosted_zone" {
#   for_each = {for v in local.records_list: "${v.subdomain}.${v.domain}" => v}

#   zone_id = aws_route53_zone.multi_public[each.value.domain].zone_id

#   name                             = "${each.value.subdomain}.${each.value.domain}"
#   type                             = each.value.type
#   ttl                              = each.value.ttl
#   records                          = each.value.records
#   allow_overwrite                  = false
# }

# data "aws_route53_zone" "outside_hosted_zone" {
#   for_each = local.public_records_map

#   name         = each.value.domain
#   private_zone = false
# }

# resource "aws_route53_record" "outside_hosted_zone" {
#   for_each = local.public_records_map

#   zone_id = data.aws_route53_zone.outside_hosted_zone[each.key].zone_id

#   name                             = each.key
#   type                             = each.value.type
#   ttl                              = each.value.ttl
#   records                          = each.value.records
#   allow_overwrite                  = false
# }




# ##########
# variable "public_zones" {
#   type        = any
#   default     = {
#     "vcafarschi.com": {
#       "domain_name": "vcafarschi.com",
#       "comment": "Test public hosted zone",
#       "force_destroy": false,
#       "records": [
#         {
#           "name": "www",
#           "type": "A",
#           "ttl": 300,
#           "records": [
#             "191.186.12.15"
#           ]
#         },
#         {
#           "name": "www2",
#           "type": "A",
#           "ttl": 300,
#           "records": [
#             "191.186.12.152"
#           ]
#         }
#       ]
#     },
#     "vcafarschitest.com": {
#       "domain_name": "vcafarschitest.com",
#       "comment": "Test public hosted zone",
#       "force_destroy": false,
#       "records": [
#         {
#           "name": "www",
#           "type": "A",
#           "ttl": 300,
#           "records": [
#             "191.186.12.16"
#           ]
#         }
#       ]
#     }
#   }
# }


# locals {
#   zone_records =flatten([
#     for domain, zone in var.public_zones: [
#       for v in zone.records: {
#         domain=domain
#         name=v.name
#         type=v.type
#         ttl=v.ttl
#         records=v.records
#       }
#     ]
#   ])

#   zone_records01 =flatten([
#     for domain, zone in var.public_zones: [
#       for v in zone.records: v
#     ]
#   ])

#   zone_records2 = {
#     for domain, zone in var.public_zones:
#       domain => [ for v in zone.records: v]
#   }

#   zone_records3 =flatten([
#     for domain, zone in var.public_zones: [
#       for k, v in zone.records: {
#         domain=domain
#         name=v.name
#         type=v.type
#         ttl=v.ttl
#         records=v.records
#       }
#     ]
#   ])

# }


# variable "public_records" {
#   type = any
#   default = {
#     "dagger.vcafarschi.com": {
#       "domain": "vcafarschi.com",
#       "subdomain": "dagger",
#       "records": [
#         "19.1.2.3"
#       ],
#       "ttl": 300,
#       "type": "A"
#     },
#     "bkb.vcafarschi.com1": {
#       "domain": "vcafarschi.com",
#       "subdomain": "bkb",
#       "records": [
#         "19.1.2.4"
#       ],
#       "ttl": 300,
#       "type": "A"
#     }
#   }
# }

# ######################
# locals {
#   records_map_inside_hosted_zone = {
#     for value in var.records : (
#       lookup(value, "policy", "") == "" ?
#         "${value.subdomain}.${var.name}.${value.type}":
#       (
#         lookup(value.policy, "region", "") != "" ? "${value.subdomain}.${var.name}.${value.type}.${value.policy.region}":
#           (
#             lookup(value.policy, "set_identifier", "") != "" ? "${value.subdomain}.${var.name}.${value.type}.${value.policy.set_identifier}":
#               (
#                 lookup(value.policy, "continent", "") != "" ? "${value.subdomain}.${var.name}.${value.type}.${value.policy.continent}":
#                   (
#                     lookup(value.policy, "country", "") != "" ? "${value.subdomain}.${var.name}.${value.type}.${value.policy.continent}": ""
#                   )
#               )
#           )
#       )
#     ) => value
#         if length(var.records) != 0
#   }

#   records_map_inside_hosted_zone1 = {
#     for value in var.records : (
#       (lookup(value, "policy", "") == "") ?
#         "${value.subdomain}.${var.name}.${value.type}" :
#       (lookup(value.policy, "region", "") != "" ?
#         "${value.subdomain}.${var.name}.${value.type}.${value.policy.region}" :
#       (lookup(value.policy, "set_identifier", "") != "" ?
#         "${value.subdomain}.${var.name}.${value.type}.${value.policy.set_identifier}" : ""))
#     ) => value
#     if length(var.records) != 0
#   }
# }

# variable "records" {
#   type        = any
#   default     =  [
#     {
#       "subdomain": "www",
#       "type": "A",
#       "ttl": 300,
#       "records": [
#         "191.186.12.16"
#       ]
#     },
#     {
#       "subdomain": "www",
#       "type": "AAAA",
#       "ttl": 300,
#       "records": [
#         "2001:0db8:85a3:0000:0000:8a2e:0370:7334"
#       ]
#     },
#     {
#       "subdomain": "weighted",
#       "type": "A",
#       "ttl": 300,
#       "policy": {
#         "set_identifier": "prod",
#         "weight": 10
#       },
#       "records": [
#         "3.2.2.4"
#       ]
#     },
#     {
#       "subdomain": "latency",
#       "type": "A",
#       "ttl": 300,
#       "policy": {
#         "set_identifier": "dev",
#         "region": "us-east-1"
#       },
#       "records": [
#         "1.2.2.2"
#       ]
#     },
#     {
#       "subdomain": "geo",
#       "type": "A",
#       "ttl": 300,
#       "policy": {
#         "set_identifier": "dev",
#         "continent": "EU"
#       },
#       "records": [
#         "5.2.2.2"
#       ]
#     },
#     {
#       "subdomain": "cloudfront",
#       "type": "A",
#       "ttl": 300,
#       "cloudfront_distribution_id": "ESOPRFD3LVOIK"
#     }
#   ]
# }

##################