@minLength(5)
@maxLength(50)

@description('Provide a location for the registry.')
param location string = resourceGroup().location

@description('Provice Tags for the deployed resources')
param resourceTags object

// Solutions to add to workspace
var solutions = [
  {
    deploy: true
    name: 'AzureActivity'
    product: 'OMSGallery/AzureActivity'
    publisher: 'Microsoft'
    promotionCode: ''
  }
  {
    deploy: true
    name: 'SecurityInsights'
    product: 'OMSGallery/SecurityInsights'
    publisher: 'Microsoft'
    promotionCode: ''
  }
  {
    deploy: true
    name: 'VMInsights'
    product: 'OMSGallery/VMInsights'
    publisher: 'Microsoft'
    promotionCode: '' 
  }
  {
    deploy: true
    name: 'Security'
    product: 'OMSGallery/Security'
    publisher: 'Microsoft'
    promotionCode: ''
  }
  {
    deploy: true
    name: 'ServiceMap'
    publisher: 'Microsoft'
    product: 'OMSGallery/ServiceMap'
    promotionCode: ''
  }
  {
    deploy: true
    name: 'ContainerInsights'
    publisher: 'Microsoft'
    product: 'OMSGallery/ContainerInsights'
    promotionCode: ''
  }
  {
    deploy: true
    name: 'KeyVaultAnalytics'
    publisher: 'Microsoft'
    product: 'OMSGallery/KeyVaultAnalytics'
    promotionCode: ''
  }
]

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

/*Add Sentinal Solution to the Workspace*/
resource laWorkspaceSolution 'Microsoft.OperationsManagement/solutions@2015-11-01-preview' =  [for solution in solutions: if(solution.deploy) {
  name: '${solution.name}(${laWorkspace.name})'
  location: location
  properties: {
    workspaceResourceId: laWorkspace.id
  }
  plan: {
    name: '${solution.name}(${laWorkspace.name})'
    product: solution.product
    publisher: solution.publisher
    promotionCode: solution.promotionCode
  }
  tags: resourceTags
}]
