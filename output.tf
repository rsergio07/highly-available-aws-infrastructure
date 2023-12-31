output "instance_idA" {
  description = "ID of the EC2 instanceA"
  value       = aws_instance.instance_a.id
}

output "instance_idB" {
  description = "ID of the EC2 instanceB"
  value       = aws_instance.instance_b.id
}