### Execution Information ### 


### Terraform ###
Terrafform IaC code has been developed to deploy set of HA, Scalable, Load Balanced EC2 Server.
There is also a script to setup a demo HTTP response page.

### Steps to execute the code ###
Go to the terraform demo directory
Execute --> terraform init
            terraform plan
            terraform apply

### SECURITY MEASURES TAKEN FOR THIS TASK ###
1) All the ec2 instances are only accessible through the load balancer.
2) Proper security groups have been setup with necessary ingress & egress rules
3) Users(even ansible) can access the ec2 servers only via a predefined key through the aws console. ( When deploying the node_exporter via ansible, anisble must me executed while referring to these keys.).
4) Subnets have been allocated based on the availabilty zones and load balanced instances are hosted in various regions, this will make sure the instances are hosted in differnet networks and cannot be accessed through a same network.
5) All the instances (both the load balancer and the ec2 instances) are in a seprate vpc which are isolated from the other vpcs.
6) SSL can be configured until the load balancer layer and to step off from it after the traffic passes through the load balacner. (This will increase both the security and the performance of the setup, but for the demo purposes this was not in the IaC),

Kindly notice that keys should be created and assigned to the ec2 instances before go through the following section
The following article will help you to move ahead with this.
https://docs.aws.amazon.com/ground-station/latest/ug/create-ec2-ssh-key-pair.html


#### Prometheus with Grafana using Ansible ####

In this project, we are configurating prometheus, node_exporter, alertmanager and Grafana. We setup Grafana dashboard which can use source as Prometheus.

## Getting Started

Step 1: Update ip address of instances in inventory file.

Step 2: Run ansible command to setup prometheus, node_exporter, alertmanager and Grafana services

Ansible command: ansible-playbook playbook.yml -k "password of the remote server"
(In my case I have installed alert manager, ansible, grafana and prometheus in the same machine).

Step 3: Configure the data sources manually through grafana after the execution.
Kindly notice that initial deafault username and password is admin. This is defined by Grafana itself.
Then it allows to setup a password on our own.

To setup prometheus as the data source go through the following steps
i) Go to configurations in the Grafana left pane
ii) Click data sources
iii) Click add data source
iv) Then add the your Prometheus instance

Step 4: Configure the /etc/prometheus/prometheus.conf with the following 

scrape_configs:
  - job_name: 'prometheus'
    scrape_interval: 5s
    static_configs:
      - targets: ['localhost:9090']

  - job_name: 'node_exporter'
    scrape_interval: 5s
    static_configs:
      - targets: ['node-exporter-server-ip:9100']
