# Sinatra App Deployment using Packer, Ansible and AWS EC2

We are deploying this applicaiton on Ubuntu based systems. Currently, I have targetted both local workstation and application server based on Ubuntu. Later, we can modify the solution ready for multiple OS.

This codebase is divided into 3 directories as mentioned below and their usage
###### 1. Step1 - to setup local workstation 
###### 2. Step2 - to create a base image over Ubuntu OS
###### 3. Step3 - to launch an Amazon Ubuntu EC2 using base image created by above step

### Need to have before starting further
1. Before starting further I would request to sign up for a new AWS account and download ACCESS Key ID and SECRET ACCESS Key from AWS console -> My Security Credentials -> ACCESS Keys. Make sure you download this as you will not get to see this again if you have missed to note down or download the credentials.
2. Generate ssh keys from your Ubuntu system using below command 
```sh
$ ssh-keygen
```
Hit enter when prompted. Ignore if you already have created the keys. Once it is done then copy the public keys 
```sh
$ cat ~/.ssh/id_rsa.pub
ssh-rsa........
```
and add the public keys into your github account in settings -> SSH Keys

3. Configure your local account to access sudo privilege without password. First login as root add your local account to sudo group.
```sh
$ usermod -aG sudo <username>
```
then logout and relogin as above user and modify the sudoers file to allow firing all commands without password. Modify sudoers file by below command and append the line at bottom of the file.
```sh
$ sudo visudo
$ %sudo	ALL=(ALL) NOPASSWD: ALL
```
Verify the above configuration and it should display something like below.
```sh
$ sudo -l
 (ALL) NOPASSWD: ALL
```

### Let's get started 
Update the system and install AWS CLI tools before cloing the repo. Type yes when prompted.
```sh
$ sudo apt-get update && sudo apt-get install -y build-essential software-properties-common python-dev python-pip git
$ pip install boto --user
$ pip install boto3 --user
$ sudo pip install awscli
$ git clone git@github.com:guddu07/Rea.git
$ cd Rea
```
Run aws configure command and provide access key and secret access key which you had downloaded above. Also, provide default region and output format as per your wish.
```
$ aws configure
AWS Access Key ID [****************6QDQ]: 
AWS Secret Access Key [****************jJrC]: 
Default region name [us-east-1]: 
Default output format [None]: 
```

Let's configure your local workstation first

# Setup local workstation
Move to Step1 directory and make bash script executable
```sh
$ cd Step1
$ sudo chmod 755 setup.sh
$ ./setup.sh
```
Hit enter when prompted. Above script will install basic dependencies, install ansible and run a playbook which installs packer, download EC2 dynamic inventory files, etc., to configure your workstation ready to fly. 

Once done then open a new terminal and proceed with further steps.

## Setup Base Image
Move to Step2 directory and run below command to build the base image using Packer. It will launch a temporary EC2 instance in your region and create a base image on top of it. Once base image is ready, temporary instance will be terminated and command output will provide you ready image id.

Make sure to update the temporary Ubuntu AMI, instance-type, desired ami name and region as per your choice in below file.
```sh
$ cd ../Step2
$ nano ami.json
```
Once you have updated the details then run below command. 

Note: if your AWS account is new then you will not have access to few regions and Amazon take some time to verify your account before you can use all resource. Also, you may be charged a little amount for the running time of temporary instance packer will create to configure the base image.

Modify the below file to change the desired app path
```sh
$ nano appdeploy.yml
```
Once all settings are modified then launch the below command to start creating base image.
```sh
$ packer build ami.json
```

Now you have image readily available which you can just use to launch a new instance and that instance will be readily available. You can modify any launch configuration to pick above created image and that instance will be available immediately to serve the traffic behind load balancer or Auto Scaling group.

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

## I could have provided the IP address after the instance launched but server is not accepting any traffic other than port 80.
