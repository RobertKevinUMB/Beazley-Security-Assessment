Beazley Security Tech Challenge – DevOps Solution
Overview
This repository contains my solution for the Beazley Security Tech Challenge, covering all three tasks as described in the challenge brief. The project demonstrates modern DevOps practices, including Infrastructure as Code (IaC), Kubernetes orchestration, cloud metadata querying, and robust Python scripting with error handling and unit testing.

Table of Contents
Overview

Task 1: Kubernetes Cluster Infrastructure

Task 2: Instance Metadata Query Script

Task 3: Nested Object Key Retrieval

Repository Structure

Setup & Usage

Testing

Design Decisions & Notes

License

Task 1: Kubernetes Cluster Infrastructure
Goal:
Provision a 3-tier Kubernetes cluster across 3 availability zones, ensuring that 3 instances are always up, using Infrastructure as Code.

Approach:

IaC Tooling:
Used Terraform for cloud infrastructure provisioning and Ansible for server configuration and Kubernetes setup.

Multi-Zone High Availability:
Subnets and node groups are distributed across three availability zones (a/b/c), ensuring resilience and compliance with the "3 UP instances" NFR.

Automation:
All resources (VPC, subnets, security groups, EC2 instances, Kubernetes installation) are defined in code for reproducibility and version control.

Validation:
After deployment, kubectl get nodes -o wide confirms nodes are spread across zones.

Relevant Directories:

Kubrenetes-Creation-IAC/: Terraform code for network and compute provisioning.

Kubrenetes-Config-Ansible/: Ansible roles and playbooks for configuring master and worker nodes.

Task 2: Instance Metadata Query Script
Goal:
Create a script to query instance metadata from a cloud provider and output the result in JSON. The script must allow for retrieval of a specific key and include unit testing.

Approach:

Language: Python 3 with boto3 for AWS API access and requests for direct metadata endpoint queries.

Features:

Retrieves all metadata for a given instance ID or a specific key.

Outputs results in JSON format.

Includes robust error handling for missing/invalid keys and AWS errors.

Unit tests provided using Python’s unittest and unittest.mock.

Usage:

Run interactively or with command-line arguments to specify instance ID and key.

Can be executed on any machine with AWS credentials and permissions.

Relevant Directory:

query-metadata-script/: Contains the Python script and associated unit tests.

Task 3: Nested Object Key Retrieval
Goal:
Implement a function that retrieves the value of a slash-separated key path from a nested object, with error handling and unit testing.

Approach:

Language: Python 3.

Functionality:

Accepts a nested dictionary and a slash-separated key path (e.g., a/b/c).

Returns the value at the specified path or raises a descriptive error if the path is invalid.

User Input Script:

Prompts user for a JSON object and key path, then prints the result or error.

Unit Tests:

Comprehensive test suite covering valid retrieval, missing keys, non-dict traversal, and empty paths.

Relevant Directory:

nested-object/: Contains the function, user input script, and unit tests.
