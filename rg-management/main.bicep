@minLength(5)
@maxLength(50)

@description('Provide a location for the registry.')
param location string = resourceGroup().location

@description('Provice Tags for the deployed resources')
param resourceTags object

/*Resource Log Analytics Workspace*/
resource laWorkspace 'Microsoft.OperationalInsights/workspaces@2015-11-01-preview' = {
  name: 'laManagementWorkspace'
  location: location
  properties: {
    sku: {
      name: 'PerGB2018'
    }
  }
  tags: resourceTags
}

