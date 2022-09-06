#! /bin/bash

ssh -o "StrictHostKeyChecking no" $(terraform output prefix)@$(terraform output node-ip)

