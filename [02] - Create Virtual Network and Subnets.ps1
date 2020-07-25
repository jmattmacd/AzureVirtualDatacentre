# connect-azurermaccount 

New-AzureRmVirtualNetwork -Name JMM_VNet01 -ResourceGroupName "JMM_RG01" -Location UKSouth -AddressPrefix "10.$IP.0.0/16" 

$vnet = Get-AzureRmVirtualNetwork -name JMM_VNet01 -ResourceGroupName JMM_RG01
Add-AzureRmVirtualNetworkSubnetConfig -Name ManagementSubnet -VirtualNetwork $vnet -AddressPrefix '10.$IP.200.0/24' |Set-AzureRmVirtualNetwork 

$vnet = Get-AzureRmVirtualNetwork -name JMM_VNet01 -ResourceGroupName JMM_RG01
Add-AzureRmVirtualNetworkSubnetConfig -Name WebSubnet -VirtualNetwork $vnet -AddressPrefix '10.$IP.10.0/24' |Set-AzureRmVirtualNetwork 

$vnet = Get-AzureRmVirtualNetwork -name JMM_VNet01 -ResourceGroupName JMM_RG01
Add-AzureRmVirtualNetworkSubnetConfig -Name BusinessSubnet -VirtualNetwork $vnet -AddressPrefix '10.$IP.20.0/24' |Set-AzureRmVirtualNetwork 

$vnet = Get-AzureRmVirtualNetwork -name JMM_VNet01 -ResourceGroupName JMM_RG01
Add-AzureRmVirtualNetworkSubnetConfig -Name DataSubnet -VirtualNetwork $vnet -AddressPrefix '10.$IP.30.0/24' |Set-AzureRmVirtualNetwork 

$vnet = Get-AzureRmVirtualNetwork -name JMM_VNet01 -ResourceGroupName JMM_RG01
Add-AzureRmVirtualNetworkSubnetConfig -Name MigrationSubnet -VirtualNetwork $vnet -AddressPrefix '10.$IP.0.0/24' |Set-AzureRmVirtualNetwork 

$vnet = Get-AzureRmVirtualNetwork -name JMM_VNet01 -ResourceGroupName JMM_RG01
Add-AzureRmVirtualNetworkSubnetConfig -Name InfrastructureSubnet -VirtualNetwork $vnet -AddressPrefix '10.$IP.190.0/24' |Set-AzureRmVirtualNetwork 

$vnet = Get-AzureRmVirtualNetwork -name JMM_VNet01 -ResourceGroupName JMM_RG01
Add-AzureRmVirtualNetworkSubnetConfig -Name DMZSubnet -VirtualNetwork $vnet -AddressPrefix '10.$IP.254.0/24' |Set-AzureRmVirtualNetwork 

$vnet = New-AzureRmVirtualNetwork -Name JMM_DMZ_VNet -ResourceGroupName "JMM_RG01" -Location UKSouth -AddressPrefix "172.16.0.0/24" 
Add-AzureRmVirtualNetworkSubnetConfig -Name DMZSubnetPublic -VirtualNetwork $vnet -AddressPrefix '172.16.0.0/24' |Set-AzureRmVirtualNetwork  
