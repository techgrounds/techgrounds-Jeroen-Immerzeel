# Project Deployment Information
This document is a step by step guide to deploy the app.
First there will be a short bullet point overview, afterwards each point is explained in detail.

## Steps:
1) Define a resource group with Azure CLI or Powershell
2) Define a key vault resource
3) Place the required secrets in the key vault.
4) Check whether the secrets are set correctly
5) Deploy the app
6) Check the deployment
7) Set any needed extra requirements

### Step 1
To define a resource group use the Azure CLI and enter:  
```az group create --name <RG name> --location GermanyWestCentral```

Afterward enter  
```az configure --defaults group=<RG name>```  
This will create a resource group and set the location to deploy the app to that resource group.

The <RG name> is the name of the resource group. The <RG name> needs to be at least x characters long and max y characters long.

### Step 2
To define a key vault use the Azure CLI and enter:  
```az keyvault create --name <key vault name> --resource-group <RG name> --location GermanyWestCentral --enabled-for-deployment true --enabled-for-template-deployment true```

The ```--name <key vault name>``` has to be a unique name, and also needs to be set in the ```1.1.parameters.json``` file

### step 3
To place the secrets in the key vault use the Azure CLI and enter 1 by 1:  
```az keyvault secret set --vault-name <vault name> --name linuxUser --value <username>```

```az keyvault secret set --vault-name <vault name> --name linuxPassword --value <linux password value>```

```az keyvault secret set --vault-name <vault name> --name adminUser --value <username>```

```az keyvault secret set --vault-name <vault name>  --name adminPassword --value <admin password>```

The values need to be set to whatever you want them to be; fitting to your security requirements.

After the secrets an ssh key is required for the webserver. This requires 2 steps:
1) creating the key:
```
Az keyvault key create \
	--curve P-256 \
	--name<name of key> \
	--kty RSA \
	--size 4096 \
	--vault-name <vault name> 
```

In this the ```name of key``` is a self chosen name, and ```<vault name>``` is the name of the key vault is.

2) Exporting the public key to the VM:

```
az vm user update \
 --resource-group test\
  --name <VM name>\
  --username <username> \
  --ssh-key-value <public key name and path i.e ~/.ssh/id_rsa.pub >
```

In this the ```VM name``` is the name of the VM with the webserver role; the ```username``` the username for the admin and ```ssh-key-value``` is the path to the public key.

### Step 4
After setting the secrets it is a good idea to check that they are set correctly; this can be done both in the portal (under Key vault -> secrets) and via the Azure CLI command:
```az keyvault secret list --vault-name <vault name>```

![Location of the Key Vault secrets](/Project_documentation/vault_secrets_example.png)
*the location of the Key Vault secrets*

### Step 5
Now the app can be deployed.

Deployment is done by using the Azure CLI command:  
```az deployment group create -f main.bicep --parameters app.parameters.json``` 

During the deployment 3 parameters need to be set manually:  
    - the "environmentType"  
    - the "VM_size"  
    - The adminIP  

These parameters are there to make certain the right settings are used. 

The "environmentType" is used to set the environment in which the app is launched; "dev" is for development and uses the cheaper LRS storage type, whereas "prod" is for production use and uses the more expensive but redundant GRS storage type.

The "adminIP" is set in order to limit the access to the administrator VM to that IP address.  

The "VM_size" is used to determine the type of VMs that will be used. There are 3 allowed options:
 - **Standard-B1s**: is the cheapest with an estimated monthly cost of ~$9,-, but also the least powerfull. 
 - **Standard-B1ms**: is a good middle ground with an estimated monthly cost of ~$16,50 , and is slightly more powerfull.
 - **Standard_B2s**: is the more premium choice, with a cost of ~$33 per month, but also the most powerfull reasonable option. 

My suggestion is to test the VMs and see which size fits your requirements.

### Step 7
After deployment it is needed to set the backups via the portal. Sadly trusted Azure VMs can only be backed up via the enhanced policies, and those are at the time of writing not definable via Bicep templates.

The steps are reasonably easy:
1) Select the backup vault
2) Select the "getting started"- > "Backup" option
3) Select the Azure workload, and Virtual Machine options and press "backup"
4) Select the "enhanced" subtype and the "enhanced" policy and press "add" to be able to select the VMs.
5) Select the VMs and press OK
6)..invullen


### Step 8
After deployment it is prudent to check whether everything works as intended. A few possible steps for this include:
1.	Check the Azure portal to whether all resources are created (this can also be done via the cli with the command ```az resource list --resource-group <resource group>```)
2.	Log into the administrator server
3.	Log into the Linux server from the administrator server
4.	Create a SSH key pair on the Linux so that it can be used instead of the username/password. 
5.	Setup a test website


# Information
If there are any questions, problems or any other need for inquiries, we will be able to help.