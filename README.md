# Prometheus with Grafana using Ansible

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

