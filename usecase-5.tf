locals {
    csv_info = csvdecode(file("./sg-05.csv"))
    json_info = jsondecode(file("./app2.json"))

    name_mapping = {
        app1 = "app",
        app2 = "database"
    }

    process_data = { for index,data in local.csv_info: index => {
            protocol = data.protocol
            port = data.port
            cidr_block = local.json_info[local.name_mapping[data.cidr_block]]  #           
            
    }}
}

output "demotest" {
    value = local.process_data
}