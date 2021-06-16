echo "Please enter the name of the Resource Group"
read rgName
echo "Please enter the Azure Region to deploy the resources to. Please use 'az account list-locations --output table' to find available locations."
read rgLocation
echo $rgLocation
echo "Please enter a prefix, max 11 characters, lower case letters and numbers only."
read namePrefix

subDeploymentName=RTCSubDeployment-"$(date +%Y%m%d%H%M%S)"

az deployment sub create --name $subDeploymentName --location $rgLocation --template-file "./prerequisites.json"  --parameters rgName=$rgName rgLocation=$rgLocation namePrefix=$namePrefix 

