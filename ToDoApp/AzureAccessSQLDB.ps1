# Create a virtual network service endpoint
$clusterresourcegroup = "callcenterapplication-rg"
$dbresourcegroupname = "fabrikam-fiber-db-group"
$servername = "fab-fiber-1287587798"
#$clusterresourcegroup = "<cluster resource group>"
$resource = Get-AzResource -ResourceGroupName $clusterresourcegroup -ResourceType Microsoft.Network/virtualNetworks | Select-Object -first 1
$vnetName = $resource.Name


Write-Host 'Virtual network name: ' $vnetName 

# Get the virtual network by name.
$vnet = Get-AzVirtualNetwork `
  -ResourceGroupName $clusterresourcegroup `
  -Name              $vnetName

Write-Host "Get the subnet in the virtual network:"

# Get the subnet, assume the first subnet contains the Service Fabric cluster.
$subnet = Get-AzVirtualNetworkSubnetConfig -VirtualNetwork $vnet | Select-Object -first 1

$subnetName = $subnet.Name
$subnetID = $subnet.Id
$addressPrefix = $subnet.AddressPrefix

Write-Host "Subnet name: " $subnetName " Address prefix: " $addressPrefix " ID: " $subnetID

# Assign a Virtual Service endpoint 'Microsoft.Sql' to the subnet.
$vnet = Set-AzVirtualNetworkSubnetConfig `
  -Name            $subnetName `
  -AddressPrefix   $addressPrefix `
  -VirtualNetwork  $vnet `
  -ServiceEndpoint Microsoft.Sql | Set-AzVirtualNetwork

$vnet.Subnets[0].ServiceEndpoints;  # Display the first endpoint.

# Add a SQL DB firewall rule for the virtual network service endpoint
$subnet = Get-AzVirtualNetworkSubnetConfig `
  -Name           $subnetName `
  -VirtualNetwork $vnet;

$VNetRuleName="ServiceFabricClusterVNetRule"
$vnetRuleObject1 = New-AzSqlServerVirtualNetworkRule `
  -ResourceGroupName      $dbresourcegroupname `
  -ServerName             $servername `
  -VirtualNetworkRuleName $VNetRuleName `
  -VirtualNetworkSubnetId $subnetID;