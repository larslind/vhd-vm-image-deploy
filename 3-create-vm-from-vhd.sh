#!/bin/bash 
green="\e[0;92m"
bold="\e[1m"
reset="\e[0m"

echo -e "${green}${bold}"
echo -e "================================================================================================================================================="
echo -e "This script creates a VM from a VHD file and downloads a file to the VM after deployment"
echo -e "You have to provide a URI for the VHD file, which should be located in a 'vhds' Container in a Storage Account"
echo -e "The VM will be created with an unmanaged disk with the disk VHD in the same Container"
echo -e "The script assumes the Storage Account with the 'vhds' Container and the VNet that the VM will be deployed to already exists"
echo -e "This script requires the Azure CLI. Please see https://aka.ms/azcli for details"
echo -e "================================================================================================================================================="
echo -e "${reset}"


echo "Please enter the name of the Resource Group"
read rgName
rgLocation=$(az group show --name $rgName --query 'location' --output tsv)
echo "Deployment region is "$rgLocation

echo "Name of the VM"
read vmName
echo "Uri of the existing OS VHD in ARM standard or premium storage"
read osDiskVhdUri
echo "Size of the VM. Recommend Standard_B1s for test deployments (low performance) and <TBC> for production deployments"
read vmSize
echo "Name of the existing VNet"
read existingVirtualNetworkName
echo "Name of the subnet in the VNet that you want the VM to be deployed to"
read subnetName
echo "Provide a URL to a file to be downloaded to the VM after installation"
read fileToDownloadUrl

rgDeploymentName=RTCRGDeployment-"$(date +%Y%m%d%H%M%S)"

az deployment group create --resource-group $rgName --name $rgDeploymentName --template-file "./vm-from-vhd.json"  --parameters vmName=$vmName osDiskVhdUri=$osDiskVhdUri vmSize=$vmSize existingVirtualNetworkName=$existingVirtualNetworkName subnetName=$subnetName fileToDownloadUrl=$fileToDownloadUrl