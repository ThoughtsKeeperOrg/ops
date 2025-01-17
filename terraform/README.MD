1. create ECR
1. Retrieve login
1. Push images


Use the following steps to authenticate and push an image to your repository. For additional registry authentication methods, including the Amazon ECR credential helper, see Registry Authentication

Retrieve an authentication token and authenticate your Docker client to your registry. Use the AWS CLI:

```
aws ecr get-login-password --region us-west-2 | docker login --username AWS --password-stdin 869017893179.dkr.ecr.us-west-2.amazonaws.com
```

Note: If you receive an error using the AWS CLI, make sure that you have the latest version of the AWS CLI and Docker installed.
Build your Docker image using the following command. For information on building a Docker file from scratch see the instructions here 
. You can skip this step if your image is already built:
```
docker build -t thoughts_keeper-repo .
```
After the build completes, tag your image so you can push the image to this repository:
```
docker tag thoughts_keeper-repo:latest 869017893179.dkr.ecr.us-west-2.amazonaws.com/thoughts_keeper-repo:latest
```
Run the following command to push this image to your newly created AWS repository:
```
docker push 869017893179.dkr.ecr.us-west-2.amazonaws.com/thoughts_keeper-repo:latest
```