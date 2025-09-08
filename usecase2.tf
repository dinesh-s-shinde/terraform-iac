locals {
    csv_record = csvdecode(file("./sg-2.csv"))
    inbound_sg_rules = [for data in local.csv_record: data if data.direction == "in"]
    processed_record = {for index,rules in local.inbound_sg_rules: index => rules}
}

resource "aws_security_group" "webapp-sg" {
    name = "tf-firewall"
}

resource "aws_vpc_security_group_ingress_rule" "inbound_rules" {
    for_each = {for index,rules in local.inbound_sg_rules: index => rules}
    security_group_id = aws_security_group.webapp-sg.id
    cidr_ipv4 = each.value.cidr_block 
    from_port = each.value.port 
    to_port = each.value.port 
    ip_protocol = each.value.protocol
}

output "demo1" {
    value = local.processed_record
}