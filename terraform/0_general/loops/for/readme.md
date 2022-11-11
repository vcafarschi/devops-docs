# Terraform For Loops

```python
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
}
```



```bash
#### Output
[
  [
    {
      "policy" = "policy1"
      "user" = "user1"
    },
  ],
  [
    {
      "policy" = "policy2"
      "user" = "user1"
    },
    {
      "policy" = "policy2"
      "user" = "user2"
    },
  ],
]
```

```python
  vlad_v2 = flatten([
    for policy, users in var.iam-policy-users-map : [
      for user in users: {
        policy = policy
        user   = user
      }
    ]
  ])
```

```bash
#### Output
[
  {
    "policy" = "policy1"
    "user" = "user1"
  },
  {
    "policy" = "policy2"
    "user" = "user1"
  },
  {
    "policy" = "policy2"
    "user" = "user2"
  },
]
```