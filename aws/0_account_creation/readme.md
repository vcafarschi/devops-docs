# Account provisioning

- AWS Account is a container for Identities(users) and Resources(EC2)
- When creating an AWS account you provide:
  - Account name e.g. Dev
  - Unique Email Address (CANT be the same for multiple accounts)
  - Payment Method (Credit card, which can be used for multiple accounts)
- Every AWS Account has "Root User" of this account
  - Account "Root User" has full control over this AWS Account and any **resources** created within it
  - "Root User" can't be restricted

## How to create multiple emails from one email ?
- All unique emails no pre-setup required
- vladislav.cafarschi@gmail.com
- vladislav.cafarschi+AWSACCOUNT1@gmail.com
- vladislav.cafarschi+AWSACCOUNT1@gmail.com
- vladislav.cafarschi+AWSACCOUNT1@gmail.com


Activate **IAM user and Role Access to Billing Information**
- if not checked, even if we would give a user a full controll over billing, he will not have access to it

## MFA
- **Usernames** and **Password** if leaked, anyone can be you
- **Factors**: different pieces of evidence which provide identity
  - Knowledge
  - Possesion
  - Inherent
  - Location