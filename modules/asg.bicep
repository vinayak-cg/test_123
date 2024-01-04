
//targetScope = 'resourceGroup'
@description('Required. The State of Minnesota Agency code (3-characters).')
param agencyCode string

@description('Required. The 1-character code representing the environment (Production, Development, Test, Staging, Reference).')
@allowed([
  'p'
  'd'
  't'
  's'
  'r'
])
param envCode string

@description('Required. Code representing the type of app component (WinVM: FrontEnd Windows VL ,SQLMI: MSSQL Managed INstance).')
@allowed([
  'WinVMFE'
  'SQLMI'
])
param AppCompType string

@description('Optional. Application workload segment name.')
param applicationName string = ''

param instanceNum string = '001'

@description('Optional. Location for all resources.')
param location string = resourceGroup().location

@description('Optional. Tags of the NSG resource.')
param tags object = {}

// Create a prefix using optional applicationName param.
var prefix = empty(applicationName) ? '${agencyCode}${envCode}' : '${agencyCode}${envCode}-${applicationName}'

@description('Required. Name of the Network Security Group.')
var asgName = '${prefix}-${AppCompType}-asg-${padLeft(instanceNum, 3, '0')}'

resource applicationSecurityGroup 'Microsoft.Network/applicationSecurityGroups@2023-04-01' = {
  name: asgName
  location: location
  tags: tags
  properties: {}
}

output ASG object = applicationSecurityGroup
