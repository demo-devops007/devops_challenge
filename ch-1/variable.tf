variable "vpn_ip" {
    type = string
    default = "10.0.0.0/16"
}

variable "az" {
    default = "us-east-1a"
}

variable "web_ip" {
    type = string
    default = "10.0.1.0/24"
}

variable "app_ip" {
    type = string
    default = "10.0.2.0/24"
}

variable "db_ip" {
    type = string
    default = "10.0.3.0/24"
}

variable "instance_type" {
    default = "t2.nano"
}

variable "http_port" {}

variable "mysql_port" {}

variable "db_version" {}

variable "db_instance_class" {}