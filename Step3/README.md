## Launch Amazon EC2 Ubuntu instance using above created base image

Move to Step3 directory and modify the variables to desired instance you want.
```sh
$ cd ../Step3
$ nano group_vars/all.yml
```
Once you have modified the settings of desired instance then run below Ansible playbook. Make sure you have configured same region, app_path and AMI id which you had used in step 2.

```sh
$ ansible-playbook provision-ec2.yml
```
Once instance is launched then login to your console and find out your launched instance by the tag you had mentioned in variables file above. Get the public IP address and hit in browser and you should see the app running showing 'Hello world'

