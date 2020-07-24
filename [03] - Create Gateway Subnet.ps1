# connect-AzureRM

$vnet = Get-AzureRmVirtualNetwork -name JMM_VNet01 -ResourceGroupName JMM_RG01
Add-AzureRmVirtualNetworkSubnetConfig -Name GatewaySubnet -VirtualNetwork $vnet -AddressPrefix '10.$IP.255.0/27' |Set-AzureRmVirtualNetwork 
