#!/bin/bash 

echo "Please enter the source VHD storage account name"
read sourceStorageAccountName
echo "Please enter the source VHD container name"
read sourceStorageContainerName
echo "Please enter the name of the source VHD file"
read sourceVHDFileName

end=`date -u -d "30 minutes" '+%Y-%m-%dT%H:%MZ'`
sourceSAS=`az storage container generate-sas --account-name $sourceStorageAccountName --name $sourceStorageContainerName --https-only --permissions lr --expiry $end -o tsv`
sourceVHDSASURL="https://"$sourceStorageAccountName".blob.core.windows.net/"$sourceStorageContainerName"/"$sourceVHDFileName"?"$sourceSAS
echo $sourceVHDSASURL

echo "Please enter the SAS URL for the source VHD file"
read sourceVHDSASURL
echo "Please enter the target storage account name"
read targetStorageAccountName
targetStorageContainerName="vhds"
echo "Please enter the name of the file to copy the VHD to"
read targetVHDFileName


end=`date -u -d "30 minutes" '+%Y-%m-%dT%H:%MZ'`
targetSAS=`az storage container generate-sas --account-name $targetStorageAccountName --name $targetStorageContainerName --https-only --permissions cw --expiry $end -o tsv`

#echo      "\""$sourceVHDSASURL"\"" "\"https://"$targetStorageAccountName".blob.core.windows.net/"$targetStorageContainerName"/"$targetVHDFileName"?"$targetSAS"\""
commandString="azcopy cp \""$sourceVHDSASURL"\" \"https://"$targetStorageAccountName".blob.core.windows.net/"$targetStorageContainerName"/"$targetVHDFileName"?"$targetSAS"\""
#echo $commandString
eval "$commandString"

