# Overview
This codebase builds a docker container with all the tools to run kitchen-terraform, a tool for testing terraform code. There is an example test in the aws/container_repository folder.

# Prerequisites
* Docker for windows (linux will do with adjustments to the docker run command)
* AWS credentials profile setup in C:\Users\[current user]\.aws\credentials file

# Build
Build the docker container
```
docker build -t kitchen-terraform-docker .
```

# Run kitchen tests
Cd to the aws/container_repository and run a variation of the command below.

Example:
```
docker run -it -v C:\Users\AUMANJ\.aws:/root/.aws -v %cd%:/root/kitchen -e AWS_REGION=eu-west-2 -e AWS_PROFILE=katachi -w /root/kitchen kitchen-terraform-docker "bundle exec kitchen test"
```

## Docker run command parameters
* -v (..):/root/.aws    => mount the AWS creds directory on host machine in the /root/.aws directory in the container
* -v (..):/root/kitchen => mount the code directory (this directory) in the /root/kitchen folder in the container
* -e (..)               => environment variables required by kitchen to authenticate with AWS
* -w (..)               => workdir to run the commands from
