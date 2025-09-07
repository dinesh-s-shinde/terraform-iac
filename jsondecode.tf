# locals {
#     contents = file("test-json.json") #fetch the file present in the local workspace.
#     decode = jsondecode(local.contents)
# }

# output "jsondecode" {
#     value = local.decode["name"] 
# }