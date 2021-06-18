#!/bin/bash 
green="\e[0;92m"
bold="\e[1m"
reset="\e[0m"

echo -e "${green}${bold}"
echo -e "================================================================================================================================================="
echo -e "This script creates the VNet and Storage Account required to:"
echo -e "  1. Run the 2-copy-vhd.sh script to copy a VHD file into the Storage Account in the Container 'vhds'"
echo -e "  2. Run the 3-create-vm-from-vhd.sh script to create a VM from the copied VHD."
echo -e "     Please note that this will be created with an unmanaged disk with the disk file in the same storage account and container as the source vhd."
echo -e "If you already have a VNet and a Storage Account with a Container called 'vhds', then you don't need to run this script."
echo -e "This script requires the Azure CLI. Please see https://aka.ms/azcli for details"
echo -e "================================================================================================================================================="
echo -e "${reset}"

echo "Please enter the name of the Resource Group"
read rgName
echo "Please enter the Azure Region to deploy the resources to. Please use 'az account list-locations --output table' to find available locations."
read rgLocation
echo $rgLocation
echo "Please enter a prefix, max 11 characters, lower case letters and numbers only."
read namePrefix

subDeploymentName=RTCSubDeployment-"$(date +%Y%m%d%H%M%S)"

az deployment sub create --name $subDeploymentName --location $rgLocation --template-file "./prerequisites.json"  --parameters rgName=$rgName rgLocation=$rgLocation namePrefix=$namePrefix 

