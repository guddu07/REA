# Setup local workstation
Move to Step1 directory and make bash script executable
```sh
$ cd Step1
$ sudo chmod 755 setup.sh
$ ./setup.sh
```
Hit enter when prompted. Above script will install basic dependencies, install ansible and run a playbook which installs packer, download EC2 dynamic inventory files, etc., to configure your workstation ready to fly. 

Once done then open a new terminal and proceed with further steps.
