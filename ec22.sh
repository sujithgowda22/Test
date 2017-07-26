#!/bin/bash

function print_ansible_parameters {
cat<<EOF

Usage: $0  -r region  -a aws_access_key -p aws_secret_key -i instancetype -v volumesize

      -k pass the keypair name to be created
	  -r specify the region where instance as to be created
	  -a provide the aws access keyname
	  -p provide the aws secret keyname
	  -i provide the instance type
	  
Examples:
   
    running the ansible file with parameters  
    ./create.sh  -r us-west-2 -a asdfsdg -p asdfasdsdfasdfsddd -i t2.micro"
EOF

exit 1 
}

while getopts "k:r:a:p:i:v" opt; do 
 	case "$opt" in 
 		r) 
 			region=$OPTARG 
			;; 
 		a) 
 			accesskey=$OPTARG
			;;
 		p) 
 			secretkey=$OPTARG 
 			;; 
		i) 
			instancetype=$OPTARG 
 			;;  
		v)  
		    volumesize=$OPTARG
		*) 
 			print_ansible_parameters
 			;; 
        esac 
done 
#export AWS_ACCESS_KEY=$accesskey
#export AWS_SECRET_KEY=$secretkey

#[[ "$region" && "$accesskey" && "$secretkey" && "$instancetype" ]] || print_ansible_parameters

[[ "$region" && "$instancetype" ]] || print_ansible_parameters
#[[ "$keypair" ]] && {"$region";"$accesskey"} || print_ansible_parameters
echo $region
echo $instancetype
ansible-playbook ec22.yaml -e "region=$region instancetype=$instancetype"
#ansible-playbook ec2.yaml -e "region=$region aws_access_key=$accesskey aws_secret_key=$secretkey instancetype=$instancetype"
