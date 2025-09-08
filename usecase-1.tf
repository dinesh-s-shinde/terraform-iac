locals {
    csv_data = csvdecode(file("./sg-01.csv"))
    inbound_rules = [for rule in local.csv_data: rule if rule.direction == "in"]
    outbound_rules = [for rule in local.csv_data: rule if rule.direction == "out"]
    incoming_processed_data = {for rule in local.inbound_rules: rule.name => rule}

    }


resource "aws_security_group" "websg" {
    name = "usecase-1-sg"
}


resource "aws_vpc_security_group_ingress_rule" "test-example" {
    for_each = {for rule in local.inbound_rules: rule.name => rule}
    security_group_id = aws_security_group.websg.id
    cidr_ipv4 = each.value.cidr_block
    from_port = each.value.port
    to_port = each.value.port
    ip_protocol = each.value.protocol
}


output "test" {
    value = local.incoming_processed_data
}