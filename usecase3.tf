locals {
    csv_decode = csvdecode(file("./sg-03.csv"))
    processed_data = [for index,data in local.csv_decode: {
        cidr_block = data.cidr_block
        protocol = data.protocol 
        direction = data.direction
        from_port = can(regex("-",data.port))?split("-",data.port)[0]:data.port
        to_port = can(regex("-",data.port))?split("-",data.port)[1]:data.port


    } ]

    }
    

resource "aws_security_group" "webapp-test-sg" {
    name = "terraform-traffic-filter"
}
resource "aws_vpc_security_group_ingress_rule" "demo-rule" {
    security_group_id = aws_security_group.webapp-test-sg.id
    for_each = {for index,data in local.processed_data: index => data}
    cidr_ipv4 = each.value.cidr_block
    ip_protocol = each.value.protocol
    from_port = each.value.from_port
    to_port = each.value.to_port
}



output "demorecord" {
    value = local.processed_data
}