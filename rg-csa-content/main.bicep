param location string = 'westeurope'
param resourceTags object

resource sacsacontent 'Microsoft.Storage/storageAccounts@2021-09-01' = {
  name: 'sacsacontentniop'
  location: location
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
  tags: resourceTags
}
