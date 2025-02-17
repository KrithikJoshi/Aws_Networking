variable "subnet_name" {
  description = "Value of the subnet name for the VPC"
  type = string
  default = "MytestSubnet"

}

variable "igw_name" {
    description = "Value of the Internet Gateway Name for the VPC"
    type = string
    default = "MyTestInternetGateway"
  
}

variable "ec2_ami" {
    description = "Value of the AMI ID for the EC2 instance"
    type = string
    default = "ami-0ddfba243cbee3768"  
}

variable "ec2_name" {
  description = "Name of the EC2 instance"
  type = string
  default = "MyTestEC2"
}

variable "vpc_cidr" {
    description = "Value of the CIDR range for the VPC"
    type = string
    default = "10.0.0.0/16"
}

variable "vpc_name" {
  description = "Value of the name of the VPC"
  type = string
  default = "MyTestVPC"
}

variable "subnet_cidr" {
  description = "Value of the subnet cidr for the VPC"
  type = string
  default = "10.0.1.0/24"
}
