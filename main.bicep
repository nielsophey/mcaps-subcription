targetScope = 'subscription'

param defaultlocation string = 'westeurope'
param resourceGroupNames array = [
  'management'
  'shared'
  'csa-content'
]
var resourceTags = {
  Environment: 'Demo'
  Dreployment: 'GithubAction'
}

/* Loop thru the array of RGs*/
resource newResourceGroup 'Microsoft.Resources/resourceGroups@2021-04-01' = [for resourceGroupName in resourceGroupNames : {
  name: 'rg-${resourceGroupName}'
  location: defaultlocation
  tags: resourceTags
}]

/*Deploy RG management*/
module rgManagement 'rg-management/main.bicep' = {
  name:  resourceGroupNames[0]
  scope: resourceGroup('rg-${resourceGroupNames[0]}')
   params: {
    location: defaultlocation
    resourceTags: resourceTags
  }
  dependsOn: newResourceGroup
}

/*Deploy RG shared*/
module rgShared 'rg-shared/main.bicep' = {
  name:  resourceGroupNames[1]
  scope: resourceGroup('rg-${resourceGroupNames[1]}')
   params: {
    location: defaultlocation
    resourceTags: resourceTags
  }
  dependsOn: newResourceGroup
}

/*Deploy RG csa-content */
module rgCsaContent 'rg-csa-content/main.bicep' = {
  name:  resourceGroupNames[2]
  scope: resourceGroup('rg-${resourceGroupNames[2]}')
   params: {
    location: defaultlocation
    resourceTags: resourceTags
  }
  dependsOn: newResourceGroup
}

