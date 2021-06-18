#!/bin/bash 
green="\e[0;92m"
bold="\e[1m"
reset="\e[0m"

echo -e "${green}${bold}"
echo -e "================================================================================================================================================="
echo -e "This script copies a VHD file from one Storage Account to another using SAS URLs."
echo -e "You have to provide the source SAS URL as an input parameter."
echo -e "The destination SAS URL is generated based on the Storage Account Name and File Name provided."
echo -e "The destination Storage Account must have a Container called 'vhds'"
echo -e "This script requires the Azure CLI. Please see https://aka.ms/azcli for details"
echo -e "This script requires the azcopy utility. Please see https://aka.ms/azcopy for details"
echo -e "================================================================================================================================================="
echo -e "${reset}"

echo "Please enter the SAS URL for the source VHD file"
read sourceVHDSASURL
echo "Please enter the name of the target Storage Account"
read targetStorageAccountName
echo "Please enter the name of the file to copy the VHD to"
read targetVHDFileName


end=`date -u -d "30 minutes" '+%Y-%m-%dT%H:%MZ'`
targetSAS=`az storage container generate-sas --account-name $targetStorageAccountName --name vhds --https-only --permissions cw --expiry $end -o tsv`

commandString="azcopy cp \""$sourceVHDSASURL"\" \"https://"$targetStorageAccountName".blob.core.windows.net/vhds/"$targetVHDFileName"?"$targetSAS"\""

echo -e "${green}${bold}"
echo -e "============================================================================================================="
echo -e "VHD Blob URI (required for VM deployment):"
echo -e "https://"$targetStorageAccountName".blob.core.windows.net/vhds/"$targetVHDFileName
echo -e "============================================================================================================="
echo -e "${reset}"

eval "$commandString"

