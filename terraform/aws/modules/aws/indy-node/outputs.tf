output "node_address" {
  value = aws_instance.indy_node.public_dns
}

output "node_vpc_id" {
  value = aws_vpc.indy_vpc.id
}