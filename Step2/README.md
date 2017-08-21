## Setup Base Image
Move to Step2 directory and run below command to build the base image using Packer. It will launch a temporary EC2 instance in your region and create a base image on top of it. Once base image is ready, temporary instance will be terminated and command output will provide you ready image id.

Make sure to update the temporary Ubuntu AMI, instance-type, desired ami name and region as per your choice in below file.
```sh
$ cd ../Step2
$ nano ami.json
```
Once you have updated the details then run below command. 

Note: if your AWS account is new then you will not have access to few regions and Amazon take some time to verify your account before you can use all resource. Also, you may be charged a little amount for the running time of temporary instance packer will create to configure the base image.

```sh
$ packer build ami.json
```

Modify the below file to change the desired app path
```sh
$ nano appdeploy.yml
```
Now you have image readily available which you can just use to launch a new instance and that instance will be readily available. You can modify any launch configuration to pick above created image and that instance will be available immediately to serve the traffic behind load balancer or Auto Scaling group.

