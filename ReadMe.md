🔐 **Secure Analytics Platform Overview**  
Hosted entirely within a secure AWS VPC.

🏗️ **Infrastructure Components**  
**Amazon Redshift Serverless**  
- Runs entirely within the VPC.  
- Accessible only via specific Security Groups.  
- Integrated with KMS for encryption.  
- Monitors connection logs (via system tables like `stl_connection_log`, `svl_qlog`).

**Amazon S3**  
- Used to load data into Redshift.  
- Encrypted with Server-Side Encryption (SSE-KMS).  
- Requires users to have access to the KMS key for interaction.

**Amazon Workspaces / IDE Access**  
- Resides inside the same VPC.  
- Uses AWS-provided Redshift Drivers for secure access.

👥 **User Access Flow**  
- Must be part of a dedicated company account (SSO integration).  
- **Access to Redshift Console**  
  - Must belong to a specific Active Directory (AD) group.  
  - This does not grant access to data.  
- **Access to Data**  
  - Inside Redshift:  
    - Requires SQL grants (schemas, tables, views).  
    - Users assigned to Redshift groups mapped to IAM roles.  
    - Credentials managed via IAM + Redshift role association or IAM database authentication.

🧱 **Access Controls**  
- Redshift schema-level and table-level grants.  
- Workspace-to-Redshift controlled via:  
  - Security Group rules  
  - IAM roles  
  - AD group membership  
- KMS access required for S3 + Redshift integration.

⚙️ **Terraform Goals**  
You want to use Terraform to automate the following:  
- VPC setup (Redshift Serverless, Security Groups).  
- IAM roles and policies.  
- KMS key and policies.  
- Redshift Serverless configuration.  
- Redshift users/groups/privileges.  
- S3 buckets with SSE-KMS.  
- Possibly AD group membership (if using AWS Managed Microsoft AD or IAM Identity Center).

**Terraform**  
A tool that lets you define services as code and deploy them consistently.  
In Terraform, you define:  
- **Provider**: which cloud service you want to use.  
- **Variables**: which you can reuse.  
- **Resource**: what you want to use.  
- **Output**: what you want to see when it is deployed.  
- **State**: keeps track of what is created.

`terraform init` initializes the project.

**VPC**  
A *VPC* is a Virtual Private Cloud where you can define your private network in AWS. It is like a building in AWS.  
- **Subnet**: subdivision inside of a VPC.  
- **CIDR**: Classless Inter-Domain Routing defines the range of IP addresses inside of a VPC or subnet.  
- **Security Group**: a firewall for AWS resources. It controls who can connect to resources like Redshift and EC2. It is tied to individual AWS resources and is not shared across VPCs or subnets.  
- **Init**: initializes the project and downloads any required plugins.  
- **Plan**: compares the desired state to the present state. It will show what will be changed, created, or destroyed.

1. VPC  
2. 3 private subnets  
3. CIDR blocks for 37 IP requirements  
4. 1 security group  

**Redshift Serverless**  
- **Namespace**: data and metadata layer. Stores tables, databases, users, and KMS keys. Can be shared across multiple workgroups. Central place to store and manage data and metadata.  
- **Workgroup**: collection of compute, VPC, and subnets.

**IAM User**  
A user is another identity under the AWS account. Each user has its own access keys, fine-grained permissions, and audit activity.  
Creating a Terraform user because the root account should not be used for day-to-day tasks; it is too powerful. It should only be used to create IAM roles, users, audits, and costs.

**IAM User**  
Represents a permanent identity with permanent credentials.  
This is for humans, applications, CLI tools, and services.  
Represents a user, application, or service that wants access to AWS resources. It has its own credentials and provides long-term access with credentials.

**IAM Role**  
A set of permissions. A temporary identity assumed by services. Used by AWS services like Glue and EC2.

glue iam role
define role, then define it that only glue can assume that role-*trust policy*
then define what can role do, this is *permission policy*
then  attcached the permission to the role

A role includes
*trust policy* means who can assume the role
*permission policies* what actions the role can perform

*glue connection*
since redhshift is in private vpc, we need to define glue connection. glue connection will tell glue how to connect to redshift. this is imp for network level info,jdbc credentials,


variable "redshift_admin_password" {
  description = "Password for Redshift admin DB user"
  sensitive   = true
}
variable "redshift_username" {
  description = "Username for Redshift DB connection"
  sensitive   = true
}

variable "redshift_password" {
  description = "Password for Redshift DB connection"
  sensitive   = true
}
