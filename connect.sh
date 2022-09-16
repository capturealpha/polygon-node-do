#! /bin/bash

ssh -o "StrictHostKeyChecking no" $(terraform output prefix | tr -d '"')@$(terraform output node-ip | tr -d '"')