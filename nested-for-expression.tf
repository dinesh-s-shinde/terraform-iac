variable "list_01" {
    type = list 
    default = [1,2,3]
}

variable "list_02" {
    type = list 
    default = [4,5,6]
}

output "test" {
    value = [for data in var.list_01: [for value in var.list_02: "${data} ${value}"]]
}