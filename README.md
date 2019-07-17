The branch will deploy the kubernetes to a small dev stack. 

Need to make ssh key to attach to instance.
It spinup a single EC2 instance and then uses vagrant to spin up multiple machines within it.
This is done wit ansible

# Packer

Consul and npm install example from shell.

```json
[
      {
          "type": "shell",
          "inline": [
              "sudo yum -y install python-pip",
              "chmod -R 777 /tmp/scripts/install-consul",
              "sed -i -e 's/\r$//' /tmp/scripts/install-consul/install-consul",
              "/tmp/scripts/install-consul/install-consul --version {{user `consul_version`}}"
          ],
          "pause_before": "5s"
      },
            {
          "type": "file",
          "source": "{{template_dir}}/mnt",
          "destination": "/tmp/mnt"
      },
      {
          "type": "shell",
          "inline": [
              "sudo yum update -y",
              "curl --silent --location https://rpm.nodesource.com/setup_8.x | sudo bash -",
              "sudo yum -y install nodejs",
              "sudo yum -y install git",
              "sudo wget https://dl.yarnpkg.com/rpm/yarn.repo -O /etc/yum.repos.d/yarn.repo",
              "sudo yum -y install yarn",
              "sudo npm i -g pm2"
          ],
          "pause_before": "10s"
      }
]
```

# Reference

https://kubernetes.io/blog/2019/03/15/kubernetes-setup-using-ansible-and-vagrant/


