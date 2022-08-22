targetScope = 'subscription'

param defaultlocation string = 'westeurope'

resource rgcsa 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: 'rg-csa-content'
  location: defaultlocation
}


module ResourceGroup_csacontent 'rg-csa-content/main.bicep' = {
  scope: rgcsa
  name: 'rg-csa-content'
  params: {
    location: defaultlocation
  }
}
