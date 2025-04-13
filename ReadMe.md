🔐 Secure Analytics Platform Overview
Hosted fully inside a secure AWS VPC.

🏗️ **Infrastructure Components**
Amazon Redshift Serverless

Runs entirely within VPC.

Only accessible via specific Security Group.

Integrated with KMS for encryption.

Monitors connection logs (via system tables like stl_connection_log, svl_qlog).

Amazon S3

Used to load data into Redshift.

Encrypted with Server-Side Encryption (SSE-KMS).

Requires users to have access to KMS key for interaction.

Amazon Workspaces / IDE Access

Resides inside the same VPC.

Uses AWS-provided Redshift Drivers for secure access.

👥 **User Access Flow**

Must be part of dedicated compnay account (SSO integration).

Access to Redshift Console

Must belong to a specific Active Directory (AD) group.

This does not grant access to data.

Access to Data

Inside Redshift:

Requires SQL grants (schemas, tables, views).

Users assigned to Redshift groups mapped to IAM roles.

Credentials managed via IAM + Redshift role association or IAM database authentication.

🧱 Access Controls
Redshift schema-level and table-level grants.

Workspace-to-Redshift controlled via:

SG rules

IAM roles

AD group membership

KMS access required for S3 + Redshift integration.

⚙️ Terraform Goals
You want to use Terraform to automate the following:

VPC setup (Redshift Serverless, SGs).

IAM roles and policies.

KMS key and policies.

Redshift Serverless configuration.

Redshift users/groups/privileges.

S3 buckets with SSE-KMS.

Possibly AD group membership (if using AWS Managed Microsoft AD or IAM Identity Center).

*Terraform*
tool that lets you define services as code and deploy them consistently.
in terraform you define 'provider' which cloud service you want to use
'variables' which you can re use
what 'resource' you want to use, what 'output' you want to see when it is deployed,
'state' keep a track of what is created.

terraform init initialzes the 

*VPC*
*VPC* is virtual private cloud where you can define your private network in your aws. it is like a building in aws.
subnet, subdivision inside of vpc.
*CIDR* class less inter domain routing defines range of IP addresses inside of VPC or subnet
*Security group* it is a firewall to aws resources. it controls who can connect to the resources like redshift,EC2.It is tied to individual aws resources. it is not shared across VPC or subnet
*init* initializes the project. download any plugins required
*plan* compares desired state to the present state. it will show what will be changes,created or destroyed

1 VPC
3 private subnets
CIDR blocks for 37 IP requirements
1 security group 

*Reshift Server less*
Namespace - data and metadata layer.stores tables,database,users,KMS key.can be shared across multiple workgroups.central place to store and manage data and metadata
Workgroup - collection of compute,vpc,subnets,

*IAmUser*
A User is another identity under the aws account. each user has its own access keys, fine grained permissions,audit its activity

creating a terraform user cuz root should not be use for day to day tasks its too powerfull.it is to be used only create i am roles, users,auridts, cost

*IAM user*
represents a permanent identity with permanenent credentials
This is for humans, applications, cli tools, services
represent user, appliation or service that wants acces to aws resources. i thas it own credentials. provides long term access with crednetials

*IAM role*
set of permissiossions.temporary id assumed by services . used by aws services like glue , ec2