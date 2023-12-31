# Highly Available Infrastructure with Terraform

This Terraform project deploys a highly available infrastructure on AWS, including a VPC, subnets, an internet gateway, routing tables, EC2 instances, and an S3 bucket.

## Prerequisites

Before you begin, ensure you have the following:

- [Terraform](https://www.terraform.io/downloads.html) installed on your local machine.
- AWS credentials configured with the necessary permissions.

## Getting Started

1. **Clone this repository:**

    ```bash
    git clone https://github.com/your-username/highly-available-infrastructure.git
    cd highly-available-infrastructure
    ```

2. **Deploy infrastructure using Terraform:**

    ```bash
    terraform init
    terraform plan
    terraform apply
    ```

3. **Once the resources are created, you can find the output details in the Terraform apply output.**

## Project Structure

- **main.tf:** Defines the main Terraform configuration.
- **variables.tf:** (Optional) Separate file for variable definitions.
- **README.md:** Project documentation.

## Resources Created

- AWS VPC with public subnets in two availability zones.
- Internet Gateway for internet access.
- EC2 instances in each subnet.
- S3 bucket for object storage.

## Clean Up

To destroy the created resources and avoid incurring charges, run:

```bash
terraform destroy
```

## Feedback and Contributions

I welcome feedback, suggestions, and contributions. If you encounter issues or have ideas for improvements, please open an issue or submit a pull request.

## License

This project is licensed under the [MIT License](LICENSE). See the [LICENSE](LICENSE) file for details.

Thank you for exploring my resume webpage project! If you have any questions, feel free to reach out.

---

