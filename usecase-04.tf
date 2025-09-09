locals {
    json_data = jsondecode(file("./app.json"))
    csv_data = csvdecode(file("./sg-04.csv"))
    processed_data = { for index,data in local.csv_data: index => {
        direction = data.direction
        protocol = data.protocol
        cidr_block = local.json_data[data.cidr_block]
        port = data.port
    } }
}

resource "aws_security_group" "app-sg" {
    name = "mainapp-sg"
}

resource "aws_vpc_security_group_ingress_rule" "main-inbound-rule" {
    for_each = { for index,data in local.processed_data: index => data}
    security_group_id = aws_security_group.app-sg.id
    cidr_ipv4 = each.value.cidr_block
    ip_protocol = each.value.protocol
    from_port = each.value.port
    to_port = each.value.port
}

output "test" {
    value = local.processed_data
}