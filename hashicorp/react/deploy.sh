#!/bin/bash
set -x
set -e

# Copyright Jiaqi Liu
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# This file serves as the 'local' version of action.yml config & execution
# The following script variables need to be defined:
# - export REACT_DIR
# - export HC_DIR
# - export HC_CONFIG_DIR
# - export AWS_ACCESS_KEY_ID
# - export AWS_SECRET_ACCESS_KEY

# Build dist
cd $REACT_DIR
yarn && yarn build
rm -rf ../../dist
mv dist ../../

cd $HC_DIR/images
cp $HC_CONFIG_DIR/aws-react.pkrvars.hcl aws-react.auto.pkrvars.hcl
packer init .
packer validate -var "skip_create_ami=true" .
packer build -var "skip_create_ami=false" .

cd $HC_DIR/instances
cp $HC_CONFIG_DIR/aws-react.tfvars aws-react.auto.tfvars
terraform init
terraform validate
terraform apply -auto-approve

# cleanup
rm $HC_DIR/images/aws-react.auto.pkrvars.hcl
rm $HC_DIR/instances/aws-react.auto.tfvars
rm -r $REACT_DIR/../../dist
rm -rf $HC_DIR/instances/.terraform
rm -rf $HC_DIR/instances/.terraform.lock.hcl
rm -rf $HC_DIR/instances/terraform.tfstate
rm -rf $HC_DIR/instances/terraform.tfstate.backup
rm -rf $HC_DIR/instances/.terraform.tfstate.lock.info