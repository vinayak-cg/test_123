@description('3 digit agenct code')
@minLength(3)
@maxLength(3)
param agencyCode string = 'h58'

@description('single digit environment code like p-production, t-test, d-development etc')
@allowed([
  'p'
  't'
  'd'
])
param envCode string = 'd'

@description('Optional. Location for all resources.')
param location string = resourceGroup().location

@description('Application name to b eused in the cloud services name')
param applicationName string = 'bicepdev'

@description('sequence number to postfix to the cloud service name')
param instanceNum string = '001'

@description('NSG name of the App VM')
param appVMNSGName string

@description('NSG name of the SQL MI')
param SQLMINSGName string

@description('tags to add for the cloud services')
param tags object = {}

module appVMFEASG '../modules/asg.bicep' = {
  name: '${agencyCode}${envCode}-${applicationName}-WinVMFE-asg-${instanceNum}'
  params: {
    agencyCode: agencyCode
    envCode: envCode
    applicationName: applicationName
    AppCompType: 'WinVMFE'
    instanceNum: instanceNum
    tags: tags
    location: location    
  }
}

//output obj object = appVMFEASG.outputs.ASG
output resourceGroupName string = appVMFEASG.outputs.ASG.resourceGroupName
output location string = appVMFEASG.outputs.ASG.location
output id string = appVMFEASG.outputs.ASG.resourceId
output subscriptionId string = appVMFEASG.outputs.ASG.subscriptionId

