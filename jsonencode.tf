# resource "local_file" "demofile" {
#     filename = "dev.json"
#     content = jsonencode({
#         name = "Diya"
#         age = 01
#         city = "Bengaluru"
#     })
# }

# output "jsonencode_file" {
#     value = local_file.demofile.content
# }