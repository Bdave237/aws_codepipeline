
variable "deletion_window_in_days" {
    type = number
    default = 10
}
variable "bucket" {
    type = string
}


variable "secret_key" {
    
}

variable "access_key" {
    type = string
}

variable "region" {
    type = string
    default = "us-east-1"
}
